import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_circular_loader.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_no_record_found_widget.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_pop_up_items.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enums/form_status.dart';
import '../bloc/guarding_master_report_bloc.dart';

class GuardingMasterReport extends StatefulWidget {
  const GuardingMasterReport({
    super.key,
  });

  @override
  State<GuardingMasterReport> createState() => _GuardingMasterReportState();
}

class _GuardingMasterReportState extends State<GuardingMasterReport> {
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
          .read<GuardingMasterReportBloc>()
          .add(FetchReportList(startPos: pageNumber, maxPos: 20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.guardingMasterReportTitle,
          showPopUp: true,
          showSaveButton: false,
          excelAPIName: 'gmReportExcel',
          pdfAPIName: 'gmReportPDF',
        ),
        body: BlocBuilder<GuardingMasterReportBloc, GuardingMasterReportState>(
            builder: (context, state) {
          if (state.status == FormStatus.initial) {
            return const BaseLoader();
          }
          if (state.list.isEmptyOrNull) {
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
                  ? state.list.length
                  : state.list.length + 1,
              itemBuilder: (context, index) {
                return index >= state.list.length
                    ? const BaseLoader()
                    : BaseListTileItem(
                        id: state.list[index].id,
                        vendor: state.list[index].vendor,
                        region: state.list[index].region,
                        guardCount: state.list[index].guardCount,
                        pvcExpired: state.list[index].pvcExpired,
                        msgbExempted: state.list[index].msgbExempted,
                        locationStr: state.list[index].location,
                        onTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.list[selectedIndex].id.toString(),
                                vendor: state.list[selectedIndex].vendor,
                                region: state.list[index].region,
                                guardCount: state.list[index].guardCount,
                                pvcExpired: state.list[index].pvcExpired,
                                msgbExempted: state.list[index].msgbExempted,
                                mcNotSubmitted:
                                    state.list[selectedIndex].mcNotSubmitted,
                                mcExpired: state.list[selectedIndex].mcExpired,
                                systemAccess:
                                    state.list[selectedIndex].systemAccess,
                                trainingCertPending: state
                                    .list[selectedIndex].trainingCertPending,
                              );
                            },
                          );
                        },
                        showEditButton: false,
                        onViewTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.list[selectedIndex].id.toString(),
                                vendor: state.list[selectedIndex].vendor,
                                region: state.list[selectedIndex].region,
                                guardCount:
                                    state.list[selectedIndex].guardCount,
                                mcNotSubmitted:
                                    state.list[selectedIndex].mcNotSubmitted,
                                mcExpired: state.list[selectedIndex].mcExpired,
                                photoNotSubmitted:
                                    state.list[selectedIndex].photoNotSubmitted,
                                deploymentOrderPending: state
                                    .list[selectedIndex].deploymentOrderPending,
                                pvcExpired:
                                    state.list[selectedIndex].pvcExpired,
                                msgbExempted:
                                    state.list[selectedIndex].msgbExempted,
                                msgbNotExempted:
                                    state.list[selectedIndex].msgbNotExempted,
                                msgbFormBNotSubmitted: state
                                    .list[selectedIndex].msgbFormBNotSubmitted,
                                msgbFormBUnderProcess: state
                                    .list[selectedIndex].msgbFormBUnderProcess,
                                systemAccess:
                                    state.list[selectedIndex].systemAccess,
                                trainingCertPending: state
                                    .list[selectedIndex].trainingCertPending,
                                precPending:
                                    state.list[selectedIndex].precPending,
                                precDoseCount:
                                    state.list[selectedIndex].precDoseCount,
                                ertCertified:
                                    state.list[selectedIndex].ertCertified,
                                ertPending:
                                    state.list[selectedIndex].ertPending,
                                esicPending:
                                    state.list[selectedIndex].esicPending,
                                uanNoPending:
                                    state.list[selectedIndex].uanNoPending,
                                firstAidCertified:
                                    state.list[selectedIndex].firstAidCertified,
                                firstAidNotCertified: state
                                    .list[selectedIndex].firstAidNotCertified,
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
}
