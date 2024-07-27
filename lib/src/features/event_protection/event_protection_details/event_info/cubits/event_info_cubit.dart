import 'dart:developer';
import 'dart:math' as math;
import 'package:intl/intl.dart';

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/event_info/models/event_info_response.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/event_info/models/request_models/event_into_request.dart';
import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';
import 'package:db_atom/src/features/lawenforcement/models/add_entities.dart';
import 'package:db_atom/src/features/lawenforcement/models/add_qualifications.dart';
import 'package:db_atom/src/models/base_user.dart';
import 'package:db_atom/src/models/image_content.dart';
import 'package:db_atom/src/models/responseModels/generic_response.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

import '../../../../../constants/constants.dart';
import '../../../../../enums/form_status.dart';
import '../../../../../models/organisation.dart';
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
              locations: Locations(),
              loggedInUserDetails: User(),
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
    log('-status-ddd1-${state.status}--');
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    try {
      EventInfoResponse model = EventInfoResponse();
      log('--1111--$model');
      if (id.isNotEmpty) {
        model = await services.getEventInfo(id, eventDuration);
      }
      log('--1111--$model');
      FoundListModel foundArticles = await services.getFoundArticleList(
          startPosition: '0', maximumRecords: '50', eventId: id.toString());
      log('--2222--$foundArticles');
      List<String> emails = Utils().splitStringAfterComma(model.emails ?? '');

      emit(
        state.copyWith(
            status: FormStatus.initial,
            model: model,
            additionalEmails: emails,
            foundArticles: foundArticles.items),
      );
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
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
    List<ImageContent>? data,
    List<ImageContent>? guardImages,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.addAttachment,
      ),
    );
    int eventIds = math.Random.secure().nextInt(5);

    log('--guardImages---${guardImages?.length}----');
    if (guardImages != null) {
      if(state.model.image == null) {
        state.model.image == [];
      }
      state.model.image?.addAll(guardImages);

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


    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.date!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.date!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.date = inputDate.toString();
    }

    /// Create/Update API Call
    EventInfoRequest request =
        EventInfoRequest(eventProtectionInfo: state.model);


    log('--request---${request.eventProtectionInfo?.date}---');
    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        response = (await services.createEventEi(
            body: request, isSubmit: false, eventDuration: eventDuration));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = (await services.createEventEi(
            body: request, isSubmit: true, eventDuration: eventDuration));
      }
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.formError,
        ),
      );
      return;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.formError,
        ),
      );
    }

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
    emit(state.copyWith(status: FormStatus.loading));

    List<String> updatedEmails = List.from(state.additionalEmails ?? []);
    updatedEmails.remove(email);

    // state.copyWith(additionalEmails: updatedEmails);

    state.model.emails = Utils().joinListWithComma(updatedEmails);

    emit(state.copyWith(
      model: state.model,
      additionalEmails: updatedEmails,
      status: FormStatus.initial,
    ));
  }
}
