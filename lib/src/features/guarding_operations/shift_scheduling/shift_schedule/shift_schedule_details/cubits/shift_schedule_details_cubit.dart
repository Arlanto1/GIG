import 'dart:convert';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/models/requestModel/duty_post_request.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/models/ss_ui_labels.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:intl/intl.dart';

part 'shift_schedule_details_state.dart';

class ShiftScheduleDetailsCubit extends Cubit<ShiftScheduleDetailsState> {
  final ShiftScheduleServices services = ShiftScheduleServices();
  final ShiftScheduleModel? model;

  final CommonServices commonServices = CommonServices();
  final String id;
  final DutyPostModel? mainDutyPostModel;

  ShiftScheduleDetailsCubit({
    required this.id,
    this.mainDutyPostModel,
    this.model,
  }) : super(
    ShiftScheduleDetailsState.initial(
      model: ShiftScheduleModel(),
      locations: Locations(),
      loggedInUserDetails: User(),
      users: const [],
      emailUsers: const [],
      errorMessage: '',
      vendors: const [],
      selectedDutyPostModel: mainDutyPostModel,
    ),
  );

  void onModelValueChange(ShiftScheduleModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> getDutyPostById(int id) async {
    log('-getGuardsByAssignedId---');
    emit(state.copyWith(status: FormStatus.loading));
    DutyPostModel dutyPostModel = await services.getDutyPostById(id: id);
    log('-dutyPostModel--${dutyPostModel.name}-');
    emit(state.copyWith(
      seletedDutyPostModel: dutyPostModel,
      status: FormStatus.navigateToNextScreen,
    ));
  }

  String _getCurrentDate() {
    return DateFormat(Constants.fulldateFormat).format(DateTime.now());
  }

  void onCheckBoxChange(ShiftScheduleModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onAddPOC(String poc) {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    List<String>? pocs = state.pocs ?? [];

    pocs.add(poc);

    state.copyWith(
      pocs: pocs,
    );

    log('---pocs-3333--${pocs.toString()}--');
    log('---state.pocs.toString()-3333--${state.pocs.toString()}--');
    state.model.poc = Utils().joinListWithComma(pocs);
    log('--state.model.poc-2222-${state.model.poc}--');
    emit(
      state.copyWith(
        model: state.model,
        pocs: pocs,
        status: FormStatus.initial,
      ),
    );
  }

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    Vendors vendors = await commonServices.getVendors(name: 'ATOM_VENDORS');

    emit(
      state.copyWith(
        status: FormStatus.initial,
        vendors: vendors.items,
      ),
    );
  }

  Future<void> initializeValues() async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    ShiftScheduleModel model = ShiftScheduleModel();
    if (id.isNotEmpty) {
      model = await services.getById(int.tryParse(id) ?? 0);
    }

    var userId = await SharedPrefs.getUserId();
    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUsersByRole(roleName: 'T1_Analyst'),
        commonServices.getEntities(name: 'ATOM_ENTITIES'),
        commonServices.getUsers(),
        services.getDutyPostsById(id: model.id, dutyType: model.dutyType),
        commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER'),
        commonServices.getDepartments(name: 'ATOM_VENDORS'),
        commonServices.getVendors(name: 'ATOM_VENDORS'),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.guardingMasterModuleCode),
        SharedPrefs.getDefaultLocation(),
      ]);

      Locations getLocationsData = futures[0];
      User loggedInUserDetails = futures[1];
      Analyst users = futures[2];
      List<User> entrySecurities = futures[4];
      List<DutyPostModel> dutyPosts = futures[5];
      GetDepositor emailUsers = futures[6];
      Vendors vendors = futures[8];
      dynamic responseLabels = futures[9];
      Organisation? defaultLocation = futures[10];
      log('--model.inputDate--${model.inputDate == null ? Utils()
          .getCurrentDate() : Utils().formatUnixTimestamp(
          model.inputDate ?? '')}--');

      log('--model.location--${model.location?.id}--');
      if (model.location == null && defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: Constants.shiftScheduleModule,
        );
        model.location = defaultLocation;
        model.slNo = slNo.serialNo;
      }
      model.entrySecurity ??= loggedInUserDetails;
      model.inputDate = model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(model?.inputDate ?? '0'), Constants.fulldateFormat);
      // Get Date of Creation
      // model.inputDate = model.inputDate == null
      //     ? Utils().getCurrentDate()
      //     : Utils().formatUnixTimestamp(model.inputDate ?? '');
      model.modifiedDate = state.model.modifiedDate == null
          ? Utils().getCurrentDate()
          : Utils().formatUnixTimestamp(model.modifiedDate ?? '');
      // model.inputDate =
      //     DateFormat(Constants.fulldateFormat).format(DateTime.now());
      // model.modifiedDate =
      //     DateFormat(Constants.fulldateFormat).format(DateTime.now());
      // dynamic participationDates = Utils()
      //     .splitStringAfterComma(state.model.csrParticipationDates ?? '');

      SSUiLabels labels = SSUiLabels.fromJson(responseLabels);
      List<String> pocs = Utils().splitStringAfterComma(model.poc ?? '');
      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: model,
          users: users.t1Analyst,
          vendors: vendors.items,
          entrySecurities: entrySecurities,
          dutyPosts: dutyPosts,
          emailUsers: emailUsers.atomStaticUser,
          labels: labels,
          pocs: pocs,
        ),
      );
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Shift Schedule Details Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
          status: FormStatus.error,
        ),
      );
    }
  }

  String jsonString =
      "{\n    \"id\": 55,\n    \"name\": \"Shift I/C SECURITY SUPERVISOR\",\n    \"ranks\": [\n        {\n            \"rank\": 1,\n            \"shifts\": [\n                {\n                    \"shift\": \"A\",\n                    \"allowed\": 1,\n                    \"selectedGuards\": [\n                        {\n                            \"userId\": 463,\n                            \"name\": \"Manas  Mohapatra \"\n                        }\n                    ],\n                    \"availableGuards\": [\n                        {\n                            \"userId\": 495,\n                            \"name\": \"Sagar Kumar Barik\"\n                        },\n                        {\n                            \"userId\": 494,\n                            \"name\": \"Rupam Gurung\"\n                        },\n                        {\n                            \"userId\": 493,\n                            \"name\": \"Munibur Raja Choudhury\"\n                        },\n                        {\n                            \"userId\": 492,\n                            \"name\": \"Mohanlal Banjara\"\n                        },\n                        {\n                            \"userId\": 490,\n                            \"name\": \"Kadappa Billannavar\"\n                        },\n                        {\n                            \"userId\": 489,\n                            \"name\": \"Bikram Chakma\"\n                        },\n                        {\n                            \"userId\": 488,\n                            \"name\": \"Rakesh Kumar Nayak\"\n                        },\n                        {\n                            \"userId\": 487,\n                            \"name\": \"Chandan Malik\"\n                        },\n                        {\n                            \"userId\": 486,\n                            \"name\": \"Chinaswamy \"\n                        },\n                        {\n                            \"userId\": 485,\n                            \"name\": \"Krishna Sharma\"\n                        },\n                        {\n                            \"userId\": 484,\n                            \"name\": \"Maheshwar Behera\"\n                        },\n                        {\n                            \"userId\": 483,\n                            \"name\": \"Balaji S\"\n                        },\n                        {\n                            \"userId\": 482,\n                            \"name\": \"Subrata Jana\"\n                        },\n                        {\n                            \"userId\": 481,\n                            \"name\": \"Manoj Kumar Nayak\"\n                        },\n                        {\n                            \"userId\": 480,\n                            \"name\": \"Suman Das\"\n                        },\n                        {\n                            \"userId\": 479,\n                            \"name\": \"Sanjoy Maity\"\n                        },\n                        {\n                            \"userId\": 478,\n                            \"name\": \"Ranuj Pegu\"\n                        },\n                        {\n                            \"userId\": 477,\n                            \"name\": \"Ishwar Majhi\"\n                        },\n                        {\n                            \"userId\": 476,\n                            \"name\": \"Keshab Chandra Jena\"\n                        },\n                        {\n                            \"userId\": 475,\n                            \"name\": \"Janak Gogoi\"\n                        },\n                        {\n                            \"userId\": 474,\n                            \"name\": \"Bulu Pradhan\"\n                        },\n                        {\n                            \"userId\": 473,\n                            \"name\": \"Suryakanta Chhotaray\"\n                        },\n                        {\n                            \"userId\": 472,\n                            \"name\": \"Rajib Munda Lohar\"\n                        },\n                        {\n                            \"userId\": 471,\n                            \"name\": \"Krushnachandra Sethy\"\n                        },\n                        {\n                            \"userId\": 470,\n                            \"name\": \"Soumya Ranjan Barik\"\n                        },\n                        {\n                            \"userId\": 466,\n                            \"name\": \"Sekhar Chandra Muduli\"\n                        }\n                    ],\n                    \"replacement\": null\n                }\n            ]\n        },\n{\n            \"rank\": 2,\n            \"shifts\": [\n                {\n                    \"shift\": \"A\",\n                    \"allowed\": 1,\n                    \"selectedGuards\": [\n                        {\n                            \"userId\": 463,\n                            \"name\": \"Manas  Mohapatra \"\n                        }\n                    ],\n                    \"availableGuards\": [\n                        {\n                            \"userId\": 495,\n                            \"name\": \"Sagar Kumar Barik\"\n                        },\n                        {\n                            \"userId\": 494,\n                            \"name\": \"Rupam Gurung\"\n                        },\n                        {\n                            \"userId\": 493,\n                            \"name\": \"Munibur Raja Choudhury\"\n                        },\n                        {\n                            \"userId\": 492,\n                            \"name\": \"Mohanlal Banjara\"\n                        },\n                        {\n                            \"userId\": 490,\n                            \"name\": \"Kadappa Billannavar\"\n                        },\n                        {\n                            \"userId\": 489,\n                            \"name\": \"Bikram Chakma\"\n                        },\n                        {\n                            \"userId\": 488,\n                            \"name\": \"Rakesh Kumar Nayak\"\n                        },\n                        {\n                            \"userId\": 487,\n                            \"name\": \"Chandan Malik\"\n                        },\n                        {\n                            \"userId\": 486,\n                            \"name\": \"Chinaswamy \"\n                        },\n                        {\n                            \"userId\": 485,\n                            \"name\": \"Krishna Sharma\"\n                        },\n                        {\n                            \"userId\": 484,\n                            \"name\": \"Maheshwar Behera\"\n                        },\n                        {\n                            \"userId\": 483,\n                            \"name\": \"Balaji S\"\n                        },\n                        {\n                            \"userId\": 482,\n                            \"name\": \"Subrata Jana\"\n                        },\n                        {\n                            \"userId\": 481,\n                            \"name\": \"Manoj Kumar Nayak\"\n                        },\n                        {\n                            \"userId\": 480,\n                            \"name\": \"Suman Das\"\n                        },\n                        {\n                            \"userId\": 479,\n                            \"name\": \"Sanjoy Maity\"\n                        },\n                        {\n                            \"userId\": 478,\n                            \"name\": \"Ranuj Pegu\"\n                        },\n                        {\n                            \"userId\": 477,\n                            \"name\": \"Ishwar Majhi\"\n                        },\n                        {\n                            \"userId\": 476,\n                            \"name\": \"Keshab Chandra Jena\"\n                        },\n                        {\n                            \"userId\": 475,\n                            \"name\": \"Janak Gogoi\"\n                        },\n                        {\n                            \"userId\": 474,\n                            \"name\": \"Bulu Pradhan\"\n                        },\n                        {\n                            \"userId\": 473,\n                            \"name\": \"Suryakanta Chhotaray\"\n                        },\n                        {\n                            \"userId\": 472,\n                            \"name\": \"Rajib Munda Lohar\"\n                        },\n                        {\n                            \"userId\": 471,\n                            \"name\": \"Krushnachandra Sethy\"\n                        },\n                        {\n                            \"userId\": 470,\n                            \"name\": \"Soumya Ranjan Barik\"\n                        },\n                        {\n                            \"userId\": 466,\n                            \"name\": \"Sekhar Chandra Muduli\"\n                        }\n                    ],\n                    \"replacement\": null\n                }\n            ]\n        },\n\n{\n            \"rank\": 3,\n            \"shifts\": [\n                {\n                    \"shift\": \"A\",\n                    \"allowed\": 1,\n                    \"selectedGuards\": [\n                        {\n                            \"userId\": 463,\n                            \"name\": \"Manas  Mohapatra \"\n                        }\n                    ],\n                    \"availableGuards\": [\n                        {\n                            \"userId\": 495,\n                            \"name\": \"Sagar Kumar Barik\"\n                        },\n                        {\n                            \"userId\": 494,\n                            \"name\": \"Rupam Gurung\"\n                        },\n                        {\n                            \"userId\": 493,\n                            \"name\": \"Munibur Raja Choudhury\"\n                        },\n                        {\n                            \"userId\": 492,\n                            \"name\": \"Mohanlal Banjara\"\n                        },\n                        {\n                            \"userId\": 490,\n                            \"name\": \"Kadappa Billannavar\"\n                        },\n                        {\n                            \"userId\": 489,\n                            \"name\": \"Bikram Chakma\"\n                        },\n                        {\n                            \"userId\": 488,\n                            \"name\": \"Rakesh Kumar Nayak\"\n                        },\n                        {\n                            \"userId\": 487,\n                            \"name\": \"Chandan Malik\"\n                        },\n                        {\n                            \"userId\": 486,\n                            \"name\": \"Chinaswamy \"\n                        },\n                        {\n                            \"userId\": 485,\n                            \"name\": \"Krishna Sharma\"\n                        },\n                        {\n                            \"userId\": 484,\n                            \"name\": \"Maheshwar Behera\"\n                        },\n                        {\n                            \"userId\": 483,\n                            \"name\": \"Balaji S\"\n                        },\n                        {\n                            \"userId\": 482,\n                            \"name\": \"Subrata Jana\"\n                        },\n                        {\n                            \"userId\": 481,\n                            \"name\": \"Manoj Kumar Nayak\"\n                        },\n                        {\n                            \"userId\": 480,\n                            \"name\": \"Suman Das\"\n                        },\n                        {\n                            \"userId\": 479,\n                            \"name\": \"Sanjoy Maity\"\n                        },\n                        {\n                            \"userId\": 478,\n                            \"name\": \"Ranuj Pegu\"\n                        },\n                        {\n                            \"userId\": 477,\n                            \"name\": \"Ishwar Majhi\"\n                        },\n                        {\n                            \"userId\": 476,\n                            \"name\": \"Keshab Chandra Jena\"\n                        },\n                        {\n                            \"userId\": 475,\n                            \"name\": \"Janak Gogoi\"\n                        },\n                        {\n                            \"userId\": 474,\n                            \"name\": \"Bulu Pradhan\"\n                        },\n                        {\n                            \"userId\": 473,\n                            \"name\": \"Suryakanta Chhotaray\"\n                        },\n                        {\n                            \"userId\": 472,\n                            \"name\": \"Rajib Munda Lohar\"\n                        },\n                        {\n                            \"userId\": 471,\n                            \"name\": \"Krushnachandra Sethy\"\n                        },\n                        {\n                            \"userId\": 470,\n                            \"name\": \"Soumya Ranjan Barik\"\n                        },\n                        {\n                            \"userId\": 466,\n                            \"name\": \"Sekhar Chandra Muduli\"\n                        }\n                    ],\n                    \"replacement\": null\n                }\n            ]\n        }\n    ]\n}\n";

  Future<void> updateDropdownValues({
    Organisation? location,
    Organisation? vendor,
    int? status,
    int? systemAccess,
    int? dutyType,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    ////Get Sl No from API
    if (location != null) {
      log('--location--${location.name}--');
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.shiftScheduleModule,
      );

      state.model.location = location;
      state.model.slNo = slNo.serialNo;
      model?.inputDate = model?.inputDate == null
          ? Utils().getCurrentDate()
          : Utils().formatUnixTimestamp(model?.inputDate ?? '');
      if (state.model.vendor != null) {
        List<DutyPostModel> dutyPosts = await getDutyPosts();

        NextAvailableDate availableDate = await getNextAvailableDate();

        emit(state.copyWith(
          model: state.model,
          dutyPosts: dutyPosts,
          availableDate:availableDate,
          status: FormStatus.initial,
        ));
      }
    }
    if (vendor != null) {
      state.model.vendor = vendor;

      if (state.model.location != null) {
        List<DutyPostModel> dutyPosts = await getDutyPosts();
        NextAvailableDate availableDate = await getNextAvailableDate();
        emit(state.copyWith(
          dutyPosts: dutyPosts,
          availableDate: availableDate,
          status: FormStatus.initial,
        ));
      }
    }
    if (dutyType != null) {
      state.model.dutyType = dutyType;
      List<DutyPostModel> dutyPosts = await getDutyPosts();
      // List<DutyPostModel> dutyPosts=[];
      // dutyPosts.add(DutyPostModel.fromJson(json.decode(jsonString)));
      emit(state.copyWith(
        model: state.model,
        dutyPosts: dutyPosts,
        status: FormStatus.initial,
      ));
    }

    state.model.status = status ?? state.model.status;

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  Future<NextAvailableDate> getNextAvailableDate() async {
    NextAvailableDate availableDate = NextAvailableDate();
    availableDate = await services.getNextAvailableDate(
      locationId: state.model.location!.id!,
      vendorId: state.model.vendor!.id!,
    );
    return availableDate;
  }

  Future<List<DutyPostModel>> getDutyPosts() async {
    if (state.model.location == null ||
        state.model.vendor == null ||
        state.model.dutyType == null) {
      return [];
    }
    List<DutyPostModel> dutyPosts =
    await services.getDutyPostsByLocationAndVendor(
      locationId: state.model.location!.id ?? 0,
      vendorId: state.model.vendor?.id ?? 0,
      dutyType: state.model.dutyType,
    );
    return dutyPosts;
  }

  void updateReplacement(Replacement replacement,) {
    emit(state.copyWith(
      status: FormStatus.loading,
    ));

    log('----state.selectedDutyPostModel--before-${json.encode(
        state.selectedDutyPostModel.toString())}-');
    log('----replacement.fromDate---${replacement.fromDate}-');

    // Check if replacement has an ID
    if (replacement.id != null) {
      // Iterate over ranks and shifts to find and update the replacement
      state.selectedDutyPostModel?.ranks?.forEach((rank) {
        rank.shifts?.forEach((shift) {
          shift.replacements?.forEach((existingReplacement) {
            log('----existingReplacement-${existingReplacement
                .id} ${(replacement.id)}--${existingReplacement.toString()}-');
            if (existingReplacement.id == replacement.id) {
              // Update the existing replacement with the new values
              existingReplacement.replacedFor = replacement.replacedFor;
              existingReplacement.replacementBy = replacement.replacementBy;
              existingReplacement.fromDate = replacement.fromDate;
              existingReplacement.toDate = replacement.toDate;
              existingReplacement.status = replacement.status;
            }
          });
        });
      });
    } else {
      // If replacement has no ID, add it as a new object to the replacements list
      state.selectedDutyPostModel?.ranks?.forEach((rank) {
        rank.shifts?.forEach((shift) {
          shift.replacements ??= [];
          shift.replacements!.add(replacement);
        });
      });
    }

    log('----state.selectedDutyPostModel--after-${json.encode(
        state.selectedDutyPostModel.toString())}-');

    log('----end----');
    emit(state.copyWith(
      model: state.model,
      seletedDutyPostModel: state.selectedDutyPostModel,
      status: FormStatus.initial,
    ));
  }

  void submitForm({
    bool isSaveOnly = false,
    bool navigateToNextScreen = false,
    int? dutyPostNameId,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (state.model.status == 0 || state.model.status == null) {
      state.model.status = 0;
    }
    // Setting time in milliseconds
    // state.model.inputDate =
    //     (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.inputDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
      int inputDate = dateTime
          .toUtc()
          .millisecondsSinceEpoch ~/ 1000;
      state.model.inputDate = inputDate.toString();
    }

    // Create/Update API Call
    ShiftScheduleRequest request =
    ShiftScheduleRequest(shiftScheduleModel: state.model);

    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValidDraft.message,
            ),
          );
          return;
        }
        response = (await services.createShiftSchedule(
            body: request, isSubmit: false));
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
        response = (await services.createShiftSchedule(
          body: request,
          isSubmit: true,
        ));
      }
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model?.inputDate ?? '0'),
          Constants.fulldateFormat);
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
      );
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(state.model?.inputDate ?? '0'),
          Constants.fulldateFormat);
      return;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }

    log('---response--msg--${response.message}---');

    DutyPostModel selectedDutyPostModel = DutyPostModel();
    if (dutyPostNameId != null &&
        navigateToNextScreen &&
        !response.id.isEmptyOrNull) {
      selectedDutyPostModel =
      await services.getDutyPostByShiftIdAndDutyPostNameId(
        dutyPostId: dutyPostNameId,
        shiftId: int.tryParse(response.id!) ?? 0,
      );
    }

    emit(
      state.copyWith(
        message: response.message,
        seletedDutyPostModel: selectedDutyPostModel,
        status: navigateToNextScreen
            ? FormStatus.navigateToNextScreen
            : FormStatus.success,
      ),
    );
  }

  void submitDutyPost({
    bool isSaveOnly = false,
    required DutyPostModel model,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    log('---submitDutyPost---');

    // Create/Update API Call
    DutyPostRequest request = DutyPostRequest(dutyPost: model);

    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        // if (!state.isValidDraft.status) {
        //   emit(
        //     state.copyWith(
        //       status: FormStatus.error,
        //       message: state.isValidDraft.message,
        //     ),
        //   );
        //   return;
        // }
        response = (await services.assignGuards(
          body: request,
          isSubmit: false,
        ));
      } else {
        //Validating Fields
        // if (!state.isValid.status) {
        //   emit(
        //     state.copyWith(
        //       status: FormStatus.error,
        //       message: state.isValid.message,
        //     ),
        //   );
        //   return;
        // }
        response = (await services.assignGuards(
          body: request,
          isSubmit: true,
        ));
      }
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
      );
      return;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }

    log('---response--msg--${response.message}---');

    emit(
      state.copyWith(
        message: response.message,
        status: FormStatus.success,
      ),
    );
  }

  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
        id: id, module: Constants.shiftScheduleModule);
  }
}
