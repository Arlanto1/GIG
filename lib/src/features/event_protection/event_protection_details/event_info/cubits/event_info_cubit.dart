import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';
import 'package:intl/intl.dart';

part 'event_info_state.dart';

class EventInfoCubit extends Cubit<EventInfoState> {
  final EventProtectionServices services;
  final String eventProtectionId;
  final int eventDurationType;

  /// Before, During, After the event
  final CommonServices commonServices;

  EventInfoCubit({
    required this.services,
    required this.commonServices,
    required this.eventProtectionId,
    required this.eventDurationType,
  }) : super(
          EventInfoState.initial(
              model: EventInfoResponse(),
              locations: Locations(),
              loggedInUserDetails: User(),
              users: const [],
              eventDuration: eventDurationType,
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

      log('--id----$eventProtectionId--');
      if (eventProtectionId.isNotEmpty) {
        model =
            await services.getEventInfo(eventProtectionId, eventDurationType);
      }
      FoundListModel foundArticles = await services.getFoundArticleList(
          startPosition: '0',
          maximumRecords: '50',
          eventId: eventProtectionId.toString());
      List<String> emails = Utils().splitStringAfterComma(model.emails ?? '');

      emit(
        state.copyWith(
            status: FormStatus.initial,
            model: model,
            additionalEmails: emails,
            guardAttachments: model.image,
            loadAttachments: model.image,
            foundArticles: foundArticles.items),
      );
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.formError,
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
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
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
      if (state.model.image == null) {
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

  void submitForm({
    bool isSaveOnly = false,
    bool addArticleFound = false,
    required String updatedEmailText,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    log('-state.email####--${state.model.email}-----');

    if (!updatedEmailText.isEmptyOrNull) {
      state.model.email = updatedEmailText;
    }

    DateTime dateTime;
    if (state.model.date != null && !Utils().isTimestamp(state.model.date!)) {
      dateTime = DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.date!);
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
            body: request, isSubmit: false, eventDuration: eventDurationType));
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
            body: request, isSubmit: true, eventDuration: eventDurationType));
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
