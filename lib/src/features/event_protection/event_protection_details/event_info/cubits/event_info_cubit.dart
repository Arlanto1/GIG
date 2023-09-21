import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/event_info/models/event_info_response.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/event_info/models/request_models/event_into_request.dart';
import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';
import 'package:db_atom/src/features/lawenforcement/models/addQualifications.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/models/base_user.dart';
import 'package:db_atom/src/models/department.dart';
import 'package:db_atom/src/models/entity.dart';
import 'package:db_atom/src/models/responseModels/generic_creat_response.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

import '../../../../../constants/constants.dart';
import '../../../../../enums/form_status.dart';
import '../../../../../models/entry_security.dart';
import '../../../../../models/responseModels/error_response_validation.dart';
import '../../../../../utils/util.dart';
import '../../../../article_found_register_module/foundlist/models/foundlist_model.dart';

part 'event_info_state.dart';

class EventInfoCubit extends Cubit<EventInfoState> {
  final EventProtectionServices services;
  final String id;
  final int eventDuration;
  final CommonServices commonServices;

  EventInfoCubit({
    required this.services,
    required this.commonServices,
    required this.id,
    required this.eventDuration,
  }) : super(
          EventInfoState.initial(
              model: EventInfoResponse(),
              locations: GetLocations(),
              loggedInUserDetails: EntrySecurity(),
              users: const [],
              eventDuration: eventDuration,
              emailUsers: const [],
              errorMessage: '',
              loadAttachments: const [],
              eventId: null,
              listOfEntities: const [],
              getEntitiesResponse: null,
              departments: const [],
              listOfQualifications: const [],
              getQualificationsResponse: null),
        );

  Future<void> initializeValues() async {
    log('-status-1-${state.status}--');
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      EventInfoResponse model = EventInfoResponse();
      if (id.isNotEmpty) {
        model = await services.getEventInfo(id, eventDuration);
      }
      FoundListModel foundArticles = await services.getFoundArticleList(
          startPosition: '0', maximumRecords: '50', eventId: id.toString());

      List<String> emails = Utils().splitStringAfterComma(model.emails ?? '');

      emit(
        state.copyWith(
            status: FormStatus.initial,
            model: model,
            additionalEmails: emails,
            foundArticles: foundArticles.list),
      );
    } catch (e) {
      log('initialization issue', error: e, name: (EventInfoCubit).toString());
      emit(
        state.copyWith(
          message: Constants.errorText,
          // TODO: error message should be dynamic
          status: FormStatus.error,
        ),
      );
    }
  }

  void onModelValueChange(EventInfoResponse model) {
    log('-onModelValueChange--${model.email}-');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void addAttachment({
    List<CreateImage>? data,
    List<CreateImage>? guardImages,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.addAttachment,
      ),
    );
    int eventIds = math.Random.secure().nextInt(5);

    log('--guardImages---${guardImages?.length}----');
    if (guardImages != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          guardAttachments: guardImages,
          status: FormStatus.initial,
        ),
      );
    }
  }

  void submitForm(
      {bool isSaveOnly = false, bool addArticleFound = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    /// Create/Update API Call
    EventInfoRequest request =
        EventInfoRequest(eventProtectionInfo: state.model);

    GenericCreateResponse response = GenericCreateResponse();
    try {
      if (isSaveOnly) {
        response = (await services.createEventEi(
            body: request, isSubmit: false, eventDuration: eventDuration));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = (await services.createEventEi(
            body: request, isSubmit: true, eventDuration: eventDuration));
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }

    log('---response--msg--${response.message}---');

    if (addArticleFound) {
      state.model.id = int.tryParse(response.id ?? '');
      emit(
        state.copyWith(
          model: state.model,
          message: response.message,
          status: FormStatus.addArticleFound,
        ),
      );
    } else {
      emit(
        state.copyWith(
          message: response.message,
          status: FormStatus.success,
        ),
      );
    }
  }

  void onAddEmail(String email) {
    log('-email---$email-');
    emit(state.copyWith(status: FormStatus.loading));

    if (!EmailValidator.validate(email)) {
      emit(state.copyWith(status: FormStatus.invalidEmail));
      return;
    }

    log('-state.additionalEmails---before---${state.additionalEmails}----');
    List<String>? dates = state.additionalEmails ?? [];
    dates.add(email);

    state.copyWith(
      additionalEmails: dates,
    );

    log('-state.additionalEmails---after---${state.additionalEmails}----');
    state.model.emails = Utils().joinListWithComma(dates);

    log('-state.model.emails--final---${state.model.emails}----');

    emit(state.copyWith(model: state.model, status: FormStatus.initial));
  }

  void removeEmail(String email) {
    log('-email to be removed---$email-');
    List<String> updatedEmails = List.from(state.additionalEmails ?? []);
    updatedEmails.remove(email);

    state.copyWith(additionalEmails: updatedEmails);

    log('-state.additionalEmails---after---${state.additionalEmails}----');
    state.model.emails = Utils().joinListWithComma(updatedEmails);

    log('-state.model.emails--final---${state.model.emails}----');
    emit(state.copyWith(model: state.model, status: FormStatus.initial));
  }
}
