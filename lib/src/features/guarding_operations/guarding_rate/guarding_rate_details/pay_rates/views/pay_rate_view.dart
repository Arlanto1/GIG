import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';

import 'add_security_guard_pop_up.dart';

class PayRateView extends StatefulWidget {
  final List<PayRate> payRates;
  final GMRate? rate;
  final String title;

  const PayRateView({
    super.key,
    required this.payRates,
    required this.rate,
    required this.title,
  });

  @override
  State<PayRateView> createState() => _PayRateViewState();
}

class _PayRateViewState extends State<PayRateView> {
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  addSecurityGuardPopUp({
    required BuildContext context,
    required PayRate payRate,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AddSecurityGuardPopUp(
            title: widget.title,
            payRate: payRate,
            mainContext: context,
            onSubmit: (PayRate payRate) {
              //loginFormKey.currentState!.validate();
              FocusScope.of(context).unfocus();

              log('-widget.title---${widget.title}----');

              switch (widget.title) {
                case Constants.createSecurityGuard:
                  payRate.rankId = 1;
                  break;

                case Constants.createSecuritySupervisor:
                  payRate.rankId = 3;
                  break;

                case Constants.createSecurityOfficer:
                  payRate.rankId = 2;
                  break;

                case Constants.createSecurityFacilitator:
                  payRate.rankId = 4;
                  break;

                default:
                  payRate.rankId = 5;
                  break;
              }

              log('--newPayRate--total---${payRate.total}------------');
              log('--newPayRate--2222--33333--rankid-${payRate.rankId}------------');

              BlocProvider.of<PayRateCubit>(context)
                  .onSave(isSubmit: false, newPayRate: payRate);
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PayRateCubit, PayRateState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            extendBody: true,
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: floatingButtons(state, context),
            ),

            // floatingActionButton: floatingButtons(state, context),
            appBar: BaseAppBar().buildAppHeader(
                context: context,
                title: widget.title,
                showPopUp: false,
                showSaveButton: false,
                showCustomIcon: false,
                showSubmitButton: false,
                showDisLikeButton: false,
                showLikeButton: false,
                onTapCustomIcon: () {
                  addSecurityGuardPopUp(context: context, payRate: PayRate());
                }),
            body: BlocConsumer<PayRateCubit, PayRateState>(
              listener: (context, state) {
                Utils().formError(state, context);
                Utils().errorAndLogout(state, context);

                if (state.status == FormStatus.loading) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state.status == FormStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // if (state.items.isEmptyOrNull) {
                //   return Center(
                // child: AppButton(
                //   width: 150,
                //   backgroundColor: AppColors.navigationSkyBlueColor,
                //   key: const Key(Keys.cancelButton),
                //   buttonText: Constants.add,
                //   buttonTextKey: Keys.cancelButton,
                //   onTap: () {
                //     addSecurityGuardPopUp(
                //         context: context, payRate: PayRate());
                //   },
                // ),
                //   );
                // }
                return Stack(
                  children: [
                    // 🔹 Background
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/bg2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                          child: Container(
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        if (!state.model.lock.isEmptyOrNull) ...[
                          RecordLockedWidget(text: '${state.model.lock}'),
                        ],
                        Expanded(
                          // <-- Wrap ListView.builder inside Expanded
                          child: Stack(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                // This can be removed since Expanded handles height
                                itemCount: state.items.length,
                                itemBuilder: (context, index) {
                                  List<Label> labels = [];
                                  labels.add(Label(
                                      key: 'Monthly',
                                      value: '${state.items[index].total}'));
                                  labels.add(Label(
                                      key: 'Days',
                                      value:
                                          '${state.items[index].days ?? ''}'));
                                  labels.add(Label(
                                      key: 'Per Hour',
                                      value: '${state.items[index].perHour}'));

                                  return Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            // Color(0xFF6474C6),
                                            // Color(0xFF6474C6),
                                            Colors.transparent,
                                            Colors.transparent,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 18, sigmaY: 18),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.white.withValues(
                                                            alpha: 0.09),
                                                        Colors.transparent,
                                                        Colors.white.withValues(
                                                            alpha: 0.09),
                                                        // Color(0xFF6474C6).withOpacity(0.14)
                                                      ],
                                                      stops: [0.02, 0.35, 1],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            27),
                                                    border: Border.all(
                                                      color: Colors.white
                                                          .withValues(
                                                              alpha: 0.6),
                                                      width: 0.7,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.white
                                                            .withValues(
                                                                alpha: 0.0),
                                                        blurRadius: 12,
                                                        offset:
                                                            const Offset(0, 2),
                                                      ),
                                                    ],
                                                  ),
                                                  child: BaseListTileItem(
                                                    id: state.items[index].id,
                                                    labels: labels,
                                                    onTap: (selectedIndex) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            dialogContext) {
                                                          return BasePopUpItems(
                                                            isMasterGuard:
                                                                false,
                                                            id: state
                                                                .items[
                                                                    selectedIndex]
                                                                .id
                                                                .toString(),
                                                            labels: labels,
                                                          );
                                                        },
                                                      );
                                                    },
                                                    onEditTap: (selectedIndex) {
                                                      addSecurityGuardPopUp(
                                                          context: context,
                                                          payRate: state
                                                              .items[index]);
                                                    },
                                                    onViewTap: (selectedIndex) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            dialogContext) {
                                                          return BasePopUpItems(
                                                            id: state
                                                                .items[
                                                                    selectedIndex]
                                                                .id
                                                                .toString(),
                                                            labels: labels,
                                                            isMasterGuard:
                                                                false,
                                                          );
                                                        },
                                                      );
                                                    },
                                                    index: index,
                                                  )))));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ));
      },
    );
  }

  Widget floatingButtons(PayRateState state, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.title == Constants.createOthers)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              cancelButtonDisplay(),
              const SizedBox(),
            ],
          )
        else
          cancelButtonDisplay(),
        const SizedBox(
          width: 30,
        ),
        Visibility(
          visible: widget.title != Constants.createOthers,
          // Only show the submit button for specific titles
          child: submitButtonDisplay(
            title: widget.title,
            onTap: () {
              log('-onTapSubmit--${state.model.vendor?.name}----');
              FocusScope.of(context).unfocus();

              String title = '';
              List<PayRate> payRates = [];
              switch (widget.title) {
                case Constants.createSecuritySupervisor:
                  title = Constants.createSecurityOfficer;
                  payRates = state.model.securityOfficerRates ?? [];
                  state.newPayRate.rankId = 2;
                  break;

                case Constants.createSecurityGuard:
                  title = Constants.createSecuritySupervisor;
                  payRates = state.model.securitySupervisorRates ?? [];
                  state.newPayRate.rankId = 3;
                  break;

                case Constants.createSecurityOfficer:
                  title = Constants.createSecurityFacilitator;
                  payRates = state.model.securityFacilitatorRates ?? [];
                  state.newPayRate.rankId = 4;
                  break;

                case Constants.createSecurityFacilitator:
                  log('--case ---createSecurityFacilitator-');
                  title = Constants.createGunMan;
                  payRates = state.model.securityGunManRates ?? [];
                  state.newPayRate.rankId = 5;
                  break;

                default:
                  title = Constants.createOthers;
                  payRates = state.model.otherRates ?? [];
                  state.newPayRate.rankId = 6;
                  break;
              }

              if (widget.title == Constants.createOthers) {
                BlocProvider.of<PayRateCubit>(context).onSave(
                  isSubmit: true,
                  // newPayRate: state.newPayRate,
                );

                Navigator.pushReplacementNamed(
                  context,
                  guardingRateDetailsRoute,
                  arguments: {
                    "title": Constants.createGuardingRatingCards,
                    "gmRate": state.model,
                  },
                );
                return;
              }
              log('--ifff-3333-');

              Navigator.pushReplacementNamed(
                context,
                payRateRoute,
                arguments: {
                  "payRates": payRates,
                  "gmRate": state.model,
                  "title": title,
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget cancelButtonDisplay() {
    return AppButton(
      width: Constants.cancelButtonWidth,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.close,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget submitButtonDisplay({required Function onTap, required String title}) {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText:
          title == Constants.createOthers ? Constants.submit : Constants.next,
      buttonTextKey: Keys.submitButton,
      onTap: onTap,
    );
  }
}
