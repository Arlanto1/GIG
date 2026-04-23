import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';
import 'package:intl/intl.dart';

import '../models/notification_model.dart';
import '../models/request_models/notification_email_request.dart';

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
              getQualificationsResponse: null,  draftTemplateHtml: null,
          ),
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
      /// 4️⃣ NOTIFICATION LIST (🔥 NEW)
      final notificationResponse =
      await services.getNotificationList(eventProtectionId, eventDurationType);

      final notificationItems = notificationResponse.data ?? [];

      final emailTemplates = notificationItems.map((e) => {
        "id": e.id,                   // ✅ 385, 386...
        "html": e.notification,       // ✅ template html
      }).toList();


      emit(
        state.copyWith(
            status: FormStatus.initial,
            model: model,
            additionalEmails: emails,
            guardAttachments: model.images,
            loadAttachments: model.images,
            foundArticles: foundArticles.items,
          emailTemplates: emailTemplates,
        ),
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

  void onCheckBoxChange(EventInfoResponse model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onModelValueChange(EventInfoResponse model) {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    log('-onModelValueChange--${model.notification}-');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  // void addAttachment(List<ImageContent>? data) async {
  //   log('--state.status-1---${state.status}----');
  //   emit(
  //     state.copyWith(
  //       loadAttachments: [], // ✅ Clear first
  //       status: FormStatus.loading,
  //     ),
  //   );
  //   int eventIds = math.Random.secure().nextInt(5);
  //   if (data != null) {
  //     for (ImageContent image in data) {
  //       image.type = 0;
  //     }
  //     log('--data----${data.length}----');
  //
  //     state.model.images = data;
  //     emit(
  //       state.copyWith(
  //         eventId: eventIds,
  //         model: state.model,
  //         // loadAttachments: data,
  //         loadAttachments: data,
  //         status: FormStatus.initial,
  //       ),
  //     );
  //
  //     log('--state.status--3--${state.status}----');
  //   }
  // }

  void addAttachment(List<ImageContent>? data) async {
    //  Remove this intermediate emit that clears attachments:
    // emit(state.copyWith(loadAttachments: [], status: FormStatus.loading));

    if (data != null) {
      for (ImageContent image in data) {
        image.type = 0;
      }
      emit(
        state.copyWith(
          model: state.model..images = data,
          loadAttachments: data,
          status: FormStatus.addAttachment,  // use addAttachment, not initial
        ),
      );
    }
  }
  Future<void> getEPEmailInfoById(String id) async {
    emit(state.copyWith(
      status: FormStatus.templateLoading,
      isTemplateLoading: true,
    ));

    try {
      /// ✅ CALL CORRECT API
      final response = await services.getEventInfo(id,eventDurationType);

      final exists = (state.emailTemplates ?? []).any(
            (e) => e["id"] == response.id,
      );

      if (!exists) {
        final updatedTemplates = List<Map<String, dynamic>>.from(
          state.emailTemplates ?? [],
        )..add({
          "id": response.id,
          "html": response.notification,
        });

        emit(state.copyWith(
          emailTemplates: updatedTemplates,
          draftTemplateHtml: response.notification,
          status: FormStatus.templateLoaded,
          isTemplateLoading: false,
        ));
      } else {
        emit(state.copyWith(
          draftTemplateHtml: response.notification,
          status: FormStatus.templateLoaded,
          isTemplateLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: FormStatus.error,
        isTemplateLoading: false,
        message: e.toString(),
      ));
    }
  }

  Future<EventNotificationModel> getNotificationById(String id) async {
    return await services.getNotificationById(id);
  }

  // In EventInfoCubit
  Future<EventInfoResponse> getNotificationDetailsById(String id) async {
    final response = await services.getEventInfo(id, eventDurationType);


    log("API images: ${response.images}");
    log("API images length: ${response.images?.length}");
    // ✅ Always sync attachments from the response
    emit(
      state.copyWith(
        loadAttachments: response.images ?? [], // clears old images if API returns []
      ),
    );

    return response;
  }

  Future<void> submitTemplateAndRefresh({
    required String html,
    int? id,
  }) async {
    emit(state.copyWith(status: FormStatus.loading));

    try {
      final eventInfo = EventInfoResponse(
        id: id,
        notification: html,
        emails: state.model.emails,
        images: state.model.images, // ✅ FIXED
      );

      final request = NotificationEmailRequest(
        eventProtectionInfo: eventInfo,
      );

      await services.createEventNotification(
        body: request,
        eventDuration: eventDurationType,
        epId: int.parse(eventProtectionId),
      );

      final listResponse =
      await services.getNotificationList(eventProtectionId,eventDurationType);

      final items = listResponse.data ?? [];

      emit(state.copyWith(
        status: FormStatus.templateSuccess,
        emailTemplates: items.map((e) => {
          "id": e.id,
          "html": e.notification,
        }).toList(),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormStatus.error,
        message: e.toString(),
      ));
    }
  }

  // void submitForm({
  //   bool isSaveOnly = false,
  //   bool addArticleFound = false,
  //   required String updatedEmailText,
  // }) async {
  //   emit(state.copyWith(status: FormStatus.loading));
  //
  //   var updatedModel = state.model;
  //
  //   if (!updatedEmailText.isEmptyOrNull) {
  //     state.model.notification = updatedEmailText;
  //   }
  //
  //   DateTime dateTime;
  //   if (state.model.date != null && !Utils().isTimestamp(state.model.date!)) {
  //     dateTime = DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.date!);
  //     int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  //     state.model.date = inputDate.toString();
  //   }
  //
  //   EventInfoRequest request =
  //   EventInfoRequest(eventProtectionInfo: updatedModel);
  //
  //   GenericResponse response = GenericResponse();
  //
  //   try {
  //     if (isSaveOnly) {
  //       response = await services.createEventEi(
  //         body: request,
  //         isSubmit: false,
  //         eventDuration: eventDurationType,
  //       );
  //     } else {
  //       if (!state.isValid.status) {
  //         if (isClosed) return;
  //
  //         emit(state.copyWith(
  //           status: FormStatus.formError,
  //           message: state.isValid.message,
  //         ));
  //         return;
  //       }
  //
  //       response = await services.createEventEi(
  //         body: request,
  //         isSubmit: true,
  //         eventDuration: eventDurationType,
  //       );
  //     }
  //   } on GenericResponse catch (e) {
  //     Utils().emitErrorState(e, emit, state);
  //     return;
  //   } catch (e) {
  //     if (isClosed) return;
  //
  //     emit(state.copyWith(
  //       message: e.toString(),
  //       status: FormStatus.formError,
  //     ));
  //     return;
  //   }
  //
  //   if (isClosed) return;
  //
  //   if (addArticleFound) {
  //     state.model.id = int.tryParse(response.id ?? '');
  //     emit(
  //       state.copyWith(
  //         model: state.model,
  //         message: response.message,
  //         status: FormStatus.addArticleFound,
  //       ),
  //     );
  //   }  else {
  //     emit(state.copyWith(
  //       model: updatedModel, // ✅ IMPORTANT
  //       message: response.message,
  //       status: FormStatus.success,
  //     ));
  //   }
  // }

  Future<bool> submitForm({
    bool isSaveOnly = false,
    bool addArticleFound = false,
    required String updatedEmailText,
  }) async {
    emit(state.copyWith(status: FormStatus.loading));

    var updatedModel = state.model;

    if (!updatedEmailText.isEmptyOrNull) {
      state.model.notification = updatedEmailText;
    }

    DateTime dateTime;
    if (state.model.date != null && !Utils().isTimestamp(state.model.date!)) {
      dateTime = DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.date!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.date = inputDate.toString();
    }

    EventInfoRequest request =
    EventInfoRequest(eventProtectionInfo: updatedModel);

    GenericResponse response = GenericResponse();

    try {
      if (isSaveOnly) {
        response = await services.createEventEi(
          body: request,
          isSubmit: false,
          eventDuration: eventDurationType,
        );
      } else {
        if (!state.isValid.status) {
          if (isClosed) return false;

          emit(state.copyWith(
            status: FormStatus.formError,
            message: state.isValid.message,
          ));
          return false;
        }

        response = await services.createEventEi(
          body: request,
          isSubmit: true,
          eventDuration: eventDurationType,
        );
      }
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      return false;
    } catch (e) {
      if (isClosed) return false;

      emit(state.copyWith(
        message: e.toString(),
        status: FormStatus.formError,
      ));
      return false;
    }

    if (isClosed) return false;

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
      emit(state.copyWith(
        model: updatedModel,
        message: response.message,
        status: FormStatus.success,
      ));
    }

    return true;
  }
  void clearAttachments() {
    state.model.images = [];

    emit(
      state.copyWith(
        loadAttachments: [],
        model: state.model,
        status: FormStatus.initial,
      ),
    );

    debugPrint("Attachments cleared");
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
