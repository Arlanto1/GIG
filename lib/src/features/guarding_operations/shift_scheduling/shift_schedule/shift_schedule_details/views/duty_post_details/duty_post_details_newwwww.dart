import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/base_widget/opacity_absorb_widget.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/duty_post_details/cubits/duty_post_details_cubit.dart';

class DutyPostDetailsNewwwww extends StatefulWidget {
  final DutyPostModel? model;
  final int shiftScheduleId;

  const DutyPostDetailsNewwwww({
    super.key,
    this.model,
    required this.shiftScheduleId,
  });

  @override
  State<DutyPostDetailsNewwwww> createState() => _DutyPostDetailsNewwwwwState();
}

class _DutyPostDetailsNewwwwwState extends State<DutyPostDetailsNewwwww> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isReadOnly = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DutyPostDetailsCubit>(context).initializeValues();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<DutyPostDetailsCubit, DutyPostDetailsState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Record Saved',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                shiftScheduleListRoute,
                arguments: {},
              );
            },
          );

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => dialog,
          );
        }
      },
      builder: (context, state) {
        if (!state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }

        log('-state.model.activeShift----${state.model.activeShift}---');
        // TODO: uncomment after backend deployment
        // if (!state.model.activeShift) {
        //   isReadOnly = true;
        // }

        isReadOnly = !state.model.activeShift;

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.model?.name ?? '',
            showPopUp: false,
            showSaveButton: isReadOnly ? false : true,
            showSubmitButton: isReadOnly ? false : true,
            showDisLikeButton: false,
            showLikeButton: false,
            popAndReplace: () {
              log('--popAndReplace-----');
              // Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.popAndPushNamed(
              //   context,
              //   contactDetailsListRoute,
              // );
            },
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<DutyPostDetailsCubit>(context).submitForm(
                isSaveOnly: true,
                model: state.model,
                status: FormStatus.initial,
                newSelectedShift: state.selectedShift!,
                checkValidations: true,
              );
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<DutyPostDetailsCubit>(context).submitForm(
                isSaveOnly: false,
                model: state.model,
                newSelectedShift: state.selectedShift!,
                checkValidations: true,
              );
            },
          ),
          backgroundColor: Colors.transparent,
          // extendBodyBehindAppBar: true,
          extendBody: true,
          body: getBody(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  Organisation? selectedRank;
  Organisation? selectedShift;

  getBody(DutyPostDetailsState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }
    return SizedBox.expand(
      child: Stack(
        children: [
          // 🔹 Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg2.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 Blur Layer
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
              child: Container(
                color: Colors.black.withValues(alpha: 0.08), // optional tint
              ),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * 0.01,
                  color: Colors.transparent,
                ),
                Container(
                  decoration: const ShapeDecoration(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.0)),
                      )),
                  // child: AbsorbPointer(
                  //   absorbing: isReadOnly,
                  child: Form(
                    key: _formKey,
                    // autovalidateMode: isReadOnly
                    //     ? AutovalidateMode.disabled
                    //     : AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Column(
                            children: [
                              if (!state.model.lock.isEmptyOrNull) ...[
                                RecordLockedWidget(text: '${state.model.lock}'),
                              ],
                              IntrinsicHeight(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Rank Dropdown
                                    CommonWidgets.textDisplay(
                                      state.labels?.locale.rank ??
                                          state.labels?.defaultLocale.rank ??
                                          Constants.rank,
                                      Styles.textStyleWhite14,
                                      isMandatory: true,
                                    ),

                                    // Problem: Not displaying selected element
                                    // please update the below widget to show selected element

                                    DropdownWidget(
                                      label: 'Select Rank',
                                      items: state.ranks ?? [],
                                      isInitial: false,
                                      initialValue: selectedRank,
                                      onChange: (Organisation? value) async {
                                        setState(() {
                                          selectedRank = value;
                                          selectedShift =
                                              null; //It will be removing the previous selected shift
                                          state.model.selectForAttendance = null;
                                          state.model.shift = null;
                                        });
                                        log('---onChange-region-----');

                                        // BlocProvider.of<DutyPostDetailsCubit>(
                                        //         context)
                                        //     .submitForm(
                                        //   isSaveOnly: true,
                                        //   model: state.model,
                                        //   status: FormStatus.initial,
                                        //   newSelectedShift: state.selectedShift!,
                                        // );
                                        // if (state.status != FormStatus.formError) {
                                        BlocProvider.of<DutyPostDetailsCubit>(
                                                context)
                                            .getShifts(rank: value!);
                                        // }
                                      },
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Select For Shift Dropdown
                                    CommonWidgets.textDisplay(
                                      state.labels?.locale.rank ??
                                          state.labels?.defaultLocale.rank ??
                                          Constants.selectForShift,
                                      Styles.textStyleWhite14,
                                      isMandatory: true,
                                    ),

                                    DropdownWidget(
                                      label: 'Select Shift',
                                      items: state.shifts ?? [],
                                      isInitial: selectedRank != null &&
                                              selectedShift == null
                                          ? true
                                          : false,
                                      initialValue: selectedShift,
                                      onChange: (Organisation? value) {
                                        // selectedShift = value;
                                        setState(() {
                                          selectedShift = value;
                                        });
                                        // BlocProvider.of<DutyPostDetailsCubit>(
                                        //         context)
                                        //     .submitForm(
                                        //   isSaveOnly: true,
                                        //   model: state.model,
                                        //   status: FormStatus.initial,
                                        //   newSelectedShift: value!,
                                        // );

                                        // if (state.status != FormStatus.formError) {
                                        BlocProvider.of<DutyPostDetailsCubit>(
                                                context)
                                            .getAvailableSelectedGuardsByShift(
                                          // rank: state.selectedRank,
                                          shift: value!,
                                        );
                                        // }
                                      },
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.02),

                                    /// Guard Lists (Drag Drop)

                                    OpacityAbsorbInkWellWidget(
                                      absorbing: isReadOnly,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              buildShiftColumn(
                                                state: state,
                                                shift: state.model,
                                                isSourceList: true,
                                              ),
                                              buildShiftColumn(
                                                state: state,
                                                shift: state.model,
                                                isSourceList: false,
                                              ),
                                            ],
                                          ),
                                          CommonWidgets.verticalSpacerWidget(
                                              MediaQuery.of(context).size.height *
                                                  0.02),
                                          if (!state.model.selectedGuards
                                              .isEmptyOrNull) ...[
                                            buildReplacementColumn(state),
                                          ],
                                        ],
                                      ),
                                    ),

                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.02),

                                    /// Save Button
                                    if (!isReadOnly) ...[
                                      Center(child: submitButtonDisplay(state)),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.06),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget submitButtonDisplay(DutyPostDetailsState state) {
    log('-state.selectedShift--${state.selectedShift}----');
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.save,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<DutyPostDetailsCubit>(context).submitForm(
          isSaveOnly: true,
          model: state.model,
          status: FormStatus.initial,
          newSelectedShift: state.selectedShift!,
          checkValidations: true,
        );
      },
    );
  }

  Column buildShiftColumn({
    required ShiftModel shift,
    required bool isSourceList,
    required DutyPostDetailsState state,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonWidgets.textDisplay(
          isSourceList
              ? 'Select For Shift: ${state.selectedShift?.name ?? shift.shift}'
              : 'Selected (Max Allowed: ${shift.allowed})',
          isMandatory: false,
          Styles.textStyleWhite14,
        ),
        CommonWidgets.verticalSpacerWidget(
            MediaQuery.of(context).size.height * 0.01),
        buildUserList(
          availableGuards: isSourceList
              ? shift.availableGuards ?? {}
              : shift.selectedGuards ?? {},
          isSourceList: isSourceList,
          selectedGuards: shift.selectedGuards ?? {},
          maxAllowed: shift.allowed ?? 0,
          onAdd: (BaseUser user) {
            if (!user.description.isEmptyOrNull) {
              var dialog = CustomAlertDialog(
                // title: Constants.deleteAllNotifications,
                message: user.description,
                onPositivePressed: () {
                  Navigator.pop(context);
                },
                positiveBtnText: Constants.ok,
              );
              showDialog(
                  context: context, builder: (BuildContext context) => dialog);
            }

            setState(() {
              shift.availableGuards = Set.from(shift.availableGuards!)
                ..remove(user);
              shift.selectedGuards = Set.from(shift.selectedGuards!)..add(user);
            });

            /// Save Record
            BlocProvider.of<DutyPostDetailsCubit>(context)
                .submitAndRefreshScreen(
              checkValidations: false,
            );
          },
          onRemove: (BaseUser guard) {
            setState(() {
              shift.selectedGuards = Set.from(shift.selectedGuards!)
                ..remove(guard);
              shift.availableGuards = Set.from(shift.availableGuards!)
                ..add(guard);

              log('---shift.selectedGuards.isEmptyOrNull-11---${shift.selectedGuards.isEmptyOrNull}--');

              shift.replacements
                  ?.removeWhere((u) => u.replacedFor?.id == guard.id);

              /// To remove all the replacements
              // if (guard.id = shift.selectedGuards.isEmptyOrNull) {
              //   log('---shift.selectedGuards.isEmptyOrNull------');
              //   shift.replacements?.clear();
              // }
            });

            /// Save Record
            BlocProvider.of<DutyPostDetailsCubit>(context)
                .submitAndRefreshScreen(
              checkValidations: false,
            );
          },
        ),
      ],
    );
  }

  // Widget buildUserList({
  //   required Set<BaseUser> availableGuards,
  //   required Set<BaseUser> selectedGuards,
  //   required bool isSourceList,
  //   required int maxAllowed,
  //   required void Function(BaseUser guard) onAdd,
  //   required void Function(BaseUser guard) onRemove,
  // }) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10.0),
  //       color: AppColors.disableTextFieldBackground,
  //     ),
  //     height: MediaQuery.of(context).size.height / 2.5,
  //     width: MediaQuery.of(context).size.width / 2.3,
  //     child: availableGuards.isEmptyOrNull
  //         ? const Center(
  //             child: Text(
  //             'No Guards Found.',
  //             style: TextStyle(color: AppColors.white),
  //           ))
  //         : ListView.builder(
  //             itemCount: availableGuards.length,
  //             shrinkWrap: true,
  //             itemBuilder: (context, index) {
  //               final element = availableGuards.toList()[index];
  //               return GestureDetector(
  //                 onTap: () => handleUserListTap(isSourceList, element,
  //                     selectedGuards, maxAllowed, onAdd, onRemove),
  //                 child: Card(
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Text(
  //                       element.name ?? '',
  //                       style: const TextStyle(
  //                           fontSize: 15, color: AppColors.white),
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //   );
  // }

  Widget buildUserList({
    required Set<BaseUser> availableGuards,
    required Set<BaseUser> selectedGuards,
    required bool isSourceList,
    required int maxAllowed,
    required void Function(BaseUser guard) onAdd,
    required void Function(BaseUser guard) onRemove,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // ✅ glass blur
        child: Container(
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width / 2.3,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05), // ✅ glass tint
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 1),
              width: 1,
            ),
          ),
          child: availableGuards.isEmptyOrNull
              ? const Center(
            child: Text(
              'No Guards Found.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: availableGuards.length,
            itemBuilder: (context, index) {
              final element = availableGuards.toList()[index];

              return GestureDetector(
                onTap: () => handleUserListTap(
                  isSourceList,
                  element,
                  selectedGuards,
                  maxAllowed,
                  onAdd,
                  onRemove,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter:
                    ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(1),
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 1),
                          width: 0.8,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          element.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }


  void handleUserListTap(
    bool isSourceList,
    BaseUser element,
    Set<BaseUser> selectedGuards,
    int maxAllowed,
    void Function(BaseUser guard) onAdd,
    void Function(BaseUser guard) onRemove,
  ) {
    setState(() {
      if (isSourceList) {
        if (selectedGuards.length < maxAllowed &&
            !selectedGuards.contains(element)) {
          onAdd(element);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text('You can not add more than $maxAllowed'),
            ),
          );
        }
      } else {
        onRemove(element);
      }
    });
  }

  Column buildReplacementColumn(DutyPostDetailsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => showReplacementPopUp(
            context: context,
            model: Replacement(),
            selectedGuards: state.model.selectedGuards ?? {},
            rankId: state.selectedRank!.id!,
            dutyPostId: widget.model!.id!,
            shiftId: state.selectedShift!.id!,
            state: state,
          ),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 14),
              SvgPicture.asset(
                AppIcon.pluscircle,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                Constants.addReplacement,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
              CommonWidgets.verticalSpacerWidget(
                  MediaQuery.of(context).size.height * 0.03),
            ],
          ),
        ),
        CommonWidgets.verticalSpacerWidget(
            MediaQuery.of(context).size.height * 0.01),
        if (state.model.replacements != null &&
            state.model.replacements!.isNotEmpty) ...[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildReplacements(state),
            ),
          ),
          CommonWidgets.verticalSpacerWidget(
              MediaQuery.of(context).size.height * 0.01),
        ],
      ],
    );
  }

  // List<Widget> buildReplacements(DutyPostDetailsState state) {
  //   return [
  //     for (Replacement replacement in state.model.replacements ?? [])
  //       InkWell(
  //         onTap: () => showReplacementPopUp(
  //           context: context,
  //           model: replacement,
  //           selectedGuards: state.model.selectedGuards ?? {},
  //           rankId: state.selectedRank!.id!,
  //           dutyPostId: widget.model!.id!,
  //           shiftId: state.selectedShift!.id!,
  //           state: state,
  //         ),
  //         child: Stack(
  //           children: [
  //             Card(
  //               color: Colors.transparent,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     buildTextWithLabel(
  //                         'Replacement For:', replacement.replacedFor?.name),
  //                     buildTextWithLabel(
  //                       'From Date:',
  //                       replacement.fromDate != null
  //                           ? Utils.timestampToDateConversion(
  //                               int.tryParse(replacement.fromDate ?? '0'),
  //                               Constants.dateFormat,
  //                             )
  //                           : '',
  //                     ),
  //                     buildTextWithLabel(
  //                       'To Date:',
  //                       replacement.toDate != null
  //                           ? Utils.timestampToDateConversion(
  //                               int.parse(replacement.toDate ?? '0'),
  //                               Constants.dateFormat,
  //                             )
  //                           : '',
  //                     ),
  //                     buildTextWithLabel(
  //                         'Reason:',
  //                         Utils().getKeyFromValue(
  //                           value: replacement.status!,
  //                           dropdownValues: attendanceReasonDropDownValues,
  //                         )),
  //                     buildTextWithLabel(
  //                         'Replacement By:', replacement.replacementBy?.name),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               right: 0,
  //               top: 0,
  //               child: InkWell(
  //                 onTap: () {
  //                   state.model.replacements?.remove(replacement);
  //                   BlocProvider.of<DutyPostDetailsCubit>(context)
  //                       .submitAndRefreshScreen(
  //                     checkValidations: false,
  //                   );
  //                   setState(() {});
  //                 },
  //                 child: Card(
  //                   elevation: 5,
  //                   child: BaseIcons().closeIcon(),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //   ];
  // }

  List<Widget> buildReplacements(DutyPostDetailsState state) {
    return [
      for (Replacement replacement in state.model.replacements ?? [])
        InkWell(
          onTap: () => showReplacementPopUp(
            context: context,
            model: replacement,
            selectedGuards: state.model.selectedGuards ?? {},
            rankId: state.selectedRank!.id!,
            dutyPostId: widget.model!.id!,
            shiftId: state.selectedShift!.id!,
            state: state,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Card(
                elevation: 0,
                color: Colors.white.withValues(alpha: 0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: Colors.white.withValues(alpha: 1),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextWithLabel(
                        'Replacement For:',
                        replacement.replacedFor?.name,
                      ),
                      buildTextWithLabel(
                        'From Date:',
                        replacement.fromDate != null
                            ? Utils.timestampToDateConversion(
                          int.tryParse(
                              replacement.fromDate ?? '0'),
                          Constants.dateFormat,
                        )
                            : '',
                      ),
                      buildTextWithLabel(
                        'To Date:',
                        replacement.toDate != null
                            ? Utils.timestampToDateConversion(
                          int.parse(
                              replacement.toDate ?? '0'),
                          Constants.dateFormat,
                        )
                            : '',
                      ),
                      buildTextWithLabel(
                        'Reason:',
                        Utils().getKeyFromValue(
                          value: replacement.status!,
                          dropdownValues:
                          attendanceReasonDropDownValues,
                        ),
                      ),
                      buildTextWithLabel(
                        'Replacement By:',
                        replacement.replacementBy?.name,
                      ),

                      const SizedBox(height: 8),

                      // 🔹 CLOSE BUTTON AT BOTTOM RIGHT
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            state.model.replacements
                                ?.remove(replacement);
                            BlocProvider.of<DutyPostDetailsCubit>(
                                context)
                                .submitAndRefreshScreen(
                              checkValidations: false,
                            );
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.6),
                              ),
                            ),
                            child: BaseIcons().closeIcon(
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    ];
  }

  Widget buildTextWithLabel(String label, String? value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.white, // You can adjust the color as needed
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void showReplacementPopUp({
    required BuildContext context,
    required Replacement model,
    required Set<BaseUser> selectedGuards,
    required int dutyPostId,
    required int rankId,
    required int shiftId,
    required DutyPostDetailsState state,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AddReplacementPopUp(
          viaAttendance: false,
          model: model,
          mainContext: context,
          selectedGuards: selectedGuards,
          shiftId: shiftId,
          dutyPostId: dutyPostId,
          rankId: rankId,
          shiftModel: state.model,
        );
      },
    );
  }
}
