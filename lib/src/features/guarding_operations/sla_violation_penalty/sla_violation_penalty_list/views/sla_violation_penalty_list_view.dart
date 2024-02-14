import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_circular_loader.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_no_record_found_widget.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_pop_up_items.dart';
import 'package:db_atom/src/common_widgets/floating_button.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enums/form_status.dart';
import '../../../../../utils/util.dart';
import '../../models/sla_violation_penalty_response_model.dart';
import '../../services/sla_violation_penalty_services.dart';
import '../bloc/sla_violation_penalty_list_bloc.dart';

class SLAViolationPenaltyListView extends StatefulWidget {
  const SLAViolationPenaltyListView({
    super.key,
  });

  @override
  State<SLAViolationPenaltyListView> createState() =>
      _ContactDetailsListViewState();
}

class _ContactDetailsListViewState extends State<SLAViolationPenaltyListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      pageNumber = pageNumber + 20;
      context
          .read<SLAViolationPenaltyListBloc>()
          .add(FetchData(startPos: pageNumber, maxPos: 20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton: Flutterfloatingbutton(
          backgroundColor: AppColors.navigationSkybluecolor,
          foregroundColor: AppColors.backgroundWhitecolor,
          onPressed: () => {
            Navigator.pushNamed(context, slaViolationPenaltyDetailsRoute,
                arguments: {
                  "title": Constants.slaViolationPenalty,
                })
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.slaViolationPenalty,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
          excelAPIName: 'exportSvpExcel',
          pdfAPIName: 'exportSvpPDF',
        ),
        body: BlocBuilder<SLAViolationPenaltyListBloc,
            SLAViolationPenaltyListState>(builder: (context, state) {
          if (state.status == FormStatus.initial) {
            return const BaseLoader();
          }
          if (state.items.isEmptyOrNull) {
            return const NoRecordFoundWidget();
          }
          return Container(
            margin: allMargin16,
            decoration: const ShapeDecoration(
                color: AppColors.backgroundWhitecolor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                )),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.items.length
                  : state.items.length + 1,
              itemBuilder: (context, index) {
                List<Label> labels = [];
                if (index < state.items.length) {
                  labels.add(Label(
                      key: state.labels?.locale.entrySecurity ??
                          state.labels?.defaultLocale.entrySecurity ??
                          'Created By',
                      value: '${state.items[index].entrySecurity?.firstName ?? ''} ${state.items[index].entrySecurity?.lastName ?? ''}'));
                  labels.add(Label(
                      key: state.labels?.locale.locationRegion ??
                          state.labels?.defaultLocale.locationRegion ??
                          'Region',
                      value: state.items[index].locationRegion?.name ?? ''));
                  labels.add(Label(
                      key: state.labels?.locale.location ??
                          state.labels?.defaultLocale.location ??
                          'Location',
                      value: state.items[index].location?.name ?? ''));
                  labels.add(Label(
                      key: state.labels?.locale.slNo ??
                          state.labels?.defaultLocale.slNo ??
                          'SL No',
                      value: state.items[index].slNo ?? ''));
                  labels.add(Label(
                      key: state.labels?.locale.inputDate ??
                          state.labels?.defaultLocale.inputDate ??
                          'Date of Creation',
                      value: state.items[index].inputDate != null
                          ? Utils.timestamptoDateConversion(
                              int.parse(state.items[index].inputDate ?? '0'),
                              Constants.dateFormat)
                          : ''));
                }
                return index >= state.items.length
                    ? const BaseLoader()
                    : BaseListTileItem(
                        id: state.items[index].id,
                        status: state.items[index].status,
                        labels: labels,
                        isEventProtectionStatus: false,
                        isSLAViolationStatus: true,
                        onTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.items[selectedIndex].id.toString(),
                                status: state.items[selectedIndex].status,
                                isSLAViolationStatus: true,
                                isEventProtectionStatus: false,
                                isMasterGuard: false,
                                labels: labels,
                              );
                            },
                          );
                        },
                        onEditTap: (selectedIndex) {
                          getById(state.items[index].id ?? 0);
                        },
                        onViewTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.items[selectedIndex].id.toString(),
                                status: state.items[selectedIndex].status,
                                isSLAViolationStatus: true,
                                isEventProtectionStatus: false,
                                isMasterGuard: false,
                                labels: labels,
                              );
                            },
                          );
                        },
                        index: index,
                      );
              },
            ),
          );
        }));
  }

  getById(int id) async {
    showLoadingDialog(context);

    SLAViolationPenaltyModel model =
        await SLAViolationPenaltyServices().getGvpById(id);

    editDataLoading(model);
  }

  void editDataLoading(SLAViolationPenaltyModel? model) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(
        context,
        slaViolationPenaltyDetailsRoute,
        arguments: {
          "model": model,
          "title": Constants.slaViolationPenalty,
        },
      );
    }
  }
}
