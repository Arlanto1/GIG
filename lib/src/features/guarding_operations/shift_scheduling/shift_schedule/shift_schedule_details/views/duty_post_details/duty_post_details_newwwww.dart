import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/duty_post_details/cubits/duty_post_details_cubit.dart';

class DutyPostDetailsNewwwww extends StatefulWidget {
  final DutyPostModel? model;

  const DutyPostDetailsNewwwww({
    super.key,
    this.model,
  });

  @override
  State<DutyPostDetailsNewwwww> createState() => _DutyPostDetailsNewwwwwState();
}

class _DutyPostDetailsNewwwwwState extends State<DutyPostDetailsNewwwww> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.model?.name??'',
            showPopUp: false,
            showSaveButton: true,
            showSubmitButton: true,
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
              );
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<DutyPostDetailsCubit>(context).submitForm(
                isSaveOnly: false,
                model: state.model,
              );
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
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
    return Container(
      color: AppColors.navigationSkybluecolor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.01,
              color: AppColors.navigationSkybluecolor,
            ),
            Container(
              decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhitecolor,
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
                          // if (!state.model.lock.isEmptyOrNull) ...[
                          //   RecordLockedWidget(text: '${state.model.lock}'),
                          // ],
                          IntrinsicHeight(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Rank
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.rank ??
                                      state.labels?.defaultLocale.rank ??
                                      Constants.rank,
                                  Styles.textStyleBlack14,
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
                                    });
                                    log('---onChange-region-----');
                                    BlocProvider.of<DutyPostDetailsCubit>(
                                            context)
                                        .getShiftListByAssignedDutyPostId(
                                            rank: value?.id);
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Select For Shift:
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.rank ??
                                      state.labels?.defaultLocale.rank ??
                                      Constants.selectForShift,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                DropdownWidget(
                                  label: 'Select Shift',
                                  items: state.shifts ?? [],
                                  isInitial: false,
                                  initialValue: selectedShift,
                                  onChange: (Organisation? value) {
                                    // selectedShift = value;
                                    setState(() {
                                      selectedShift = value;
                                    });
                                    BlocProvider.of<DutyPostDetailsCubit>(
                                            context)
                                        .getAvailableSelectedGuardsByShift(
                                      // rank: state.selectedRank,
                                      shift: value!,
                                    );
                                  },
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildShiftColumn(
                                      shift: state.model,
                                      isSourceList: true,
                                    ),
                                    buildShiftColumn(
                                      shift: state.model,
                                      isSourceList: false,
                                    ),
                                  ],
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    MediaQuery.of(context).size.height * 0.01),
                                if (!state
                                    .model.selectedGuards.isEmptyOrNull) ...[
                                  buildReplacementColumn(state),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CommonWidgets.verticalSpacerWidget(height * 0.02),
                    CommonWidgets.verticalSpacerWidget(height * 0.04),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildShiftColumn({required Shift shift, required bool isSourceList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonWidgets.textDisplay(
          isSourceList
              ? 'Select For Shift: ${shift.shift}'
              : 'Selected (Max Allowed: ${shift.allowed})',
          isMandatory: false,
          Styles.textStyleBlack14,
        ),
        CommonWidgets.verticalSpacerWidget(
            MediaQuery.of(context).size.height * 0.01),
        buildUserList(
          availableGuards: isSourceList
              ? shift.availableGuards ?? []
              : shift.selectedGuards ?? [],
          isSourceList: isSourceList,
          selectedGuards: shift.selectedGuards ?? [],
          maxAllowed: shift.allowed ?? 0,
          onAdd: (BaseUser guard) {
            setState(() {
              shift.availableGuards = List.from(shift.availableGuards!)
                ..remove(guard);
              shift.selectedGuards = List.from(shift.selectedGuards!)
                ..add(guard);
            });
          },
          onRemove: (BaseUser guard) {
            setState(() {
              shift.selectedGuards = List.from(shift.selectedGuards!)
                ..remove(guard);
              shift.availableGuards = List.from(shift.availableGuards!)
                ..add(guard);
            });
          },
        ),
      ],
    );
  }

  Widget buildUserList({
    required List<BaseUser> availableGuards,
    required List<BaseUser> selectedGuards,
    required bool isSourceList,
    required int maxAllowed,
    required void Function(BaseUser guard) onAdd,
    required void Function(BaseUser guard) onRemove,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.disabletextfieldBackground,
      ),
      height: MediaQuery.of(context).size.height / 3.3,
      width: MediaQuery.of(context).size.width / 2.3,
      child: availableGuards.isEmptyOrNull
          ? const Center(child: Text('No Guards Found.'))
          : ListView.builder(
              itemCount: availableGuards.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final element = availableGuards[index];
                return GestureDetector(
                  onTap: () => handleUserListTap(isSourceList, element,
                      selectedGuards, maxAllowed, onAdd, onRemove),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        element.name ?? '',
                        style: const TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void handleUserListTap(
    bool isSourceList,
    BaseUser element,
    List<BaseUser> selectedGuards,
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
            availableGuards: state.model.availableGuards ?? [],
            selectedGuards: state.model.selectedGuards ?? [],
            rankId: state.selectedRank!.id!,
            dutyPostId: widget.model!.id!,
            shiftId: state.selectedShift!.id!,

          ),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 14),
              SvgPicture.asset(AppIcon.pluscircle),
              const SizedBox(width: 10),
              const Text(
                Constants.addReplacement,
                style: TextStyle(
                  color: AppColors.navigationSkybluecolor,
                  decoration: TextDecoration.underline,
                ),
              ),
              CommonWidgets.verticalSpacerWidget(
                  MediaQuery.of(context).size.height * 0.01),
              CommonWidgets.verticalSpacerWidget(
                  MediaQuery.of(context).size.height * 0.01),
            ],
          ),
        ),
        if (state.model.replacements != null && state.model.replacements!.isNotEmpty) ...[
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

  List<Widget> buildReplacements(DutyPostDetailsState state) {
    return [
      for (Replacement replacement in state.model.replacements ?? [])
        InkWell(
          onTap: () => showReplacementPopUp(
            context: context,
            model: replacement,
            availableGuards: state.model.availableGuards ?? [],
            selectedGuards: state.model.selectedGuards ?? [],
            rankId: state.selectedRank!.id!,
            dutyPostId: widget.model!.id!,
            shiftId: state.selectedShift!.id!,
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextWithLabel(
                      'Replacement For:', replacement.replacedFor?.name),
                  buildTextWithLabel(
                    'From Date:',
                    replacement.fromDate != null
                        ? Utils.timestampToDateConversion(
                            int.tryParse(replacement.fromDate ?? '0'),
                            Constants.dateFormat,
                          )
                        : '',
                  ),
                  buildTextWithLabel(
                    'To Date:',
                    replacement.toDate != null
                        ? Utils.timestampToDateConversion(
                            int.parse(replacement.toDate ?? '0'),
                            Constants.dateFormat,
                          )
                        : '',
                  ),
                  buildTextWithLabel(
                      'Replacement By:', replacement.replacementBy?.name),
                ],
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
              color: Colors.black, // You can adjust the color as needed
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.black,
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
    required List<BaseUser> availableGuards,
    required List<BaseUser> selectedGuards,
    required int dutyPostId,
    required int rankId,
    required int shiftId,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AddReplacementPopUp(
          model: model,
          mainContext: context,
          availableGuards: availableGuards,
          selectedGuards: selectedGuards,
          shiftId: shiftId,
          dutyPostId: dutyPostId,
          rankId: rankId,
        );
      },
    );
  }
}
