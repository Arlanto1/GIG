import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_pop_up_items.dart';
import 'package:db_atom/src/common_widgets/floating_button.dart';
import 'package:db_atom/src/common_widgets/progress_indicators/custom_circular_progress_indicator.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/occurrences_bloc.dart';

class OccurrencesView extends StatefulWidget {
  const OccurrencesView({
    super.key,
  });

  @override
  State<OccurrencesView> createState() => _OccurrencesViewState();
}

class _OccurrencesViewState extends State<OccurrencesView> {
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
          .read<OccurrencesBloc>()
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
            Navigator.pushNamed(context, occurrenceDetailsRoute, arguments: {
              "title": Constants.createOccurrence,
            }),
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.occurrence,
          showPopUp: true,
          showSaveButton: false,
          excelAPIName: 'exportEPExcel',
          pdfAPIName: 'exportEPPDF',
        ),
        body: BlocBuilder<OccurrencesBloc, OccurrencesState>(
            builder: (context, state) {
          if (state.status == FormStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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
                List<Label> labels = [];
                if (index < state.list.length) {
                  labels.add(
                    Label(
                        key: 'Date of Creation',
                        value: state.list[index].inputDate != null
                            ? Utils.timestamptoDateConversion(
                                int.parse(state.list[index].inputDate ?? '0'),
                                Constants.dateFormat)
                            : ''),
                  );
                  labels.add(Label(
                      key: 'Region',
                      value: state.list[index].locationRegion?.name ?? ''));
                  labels.add(Label(
                      key: 'Location',
                      value: state.list[index].location?.name ?? ''));
                  labels.add(Label(
                      key: 'Shift Handed Over By',
                      value: state.list[index].entrySecurity?.name ?? ''));
                }
                return index >= state.list.length
                    ? const Center(
                        child: CustomCircularProgressIndicator(),
                      )
                    : BaseListTileItem(
                        id: state.list[index].id,
                        labels: labels,
                        status: state.list[index].status,
                        isOccurrenceStatus: true,
                        isEventProtectionStatus: false,
                        onTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.list[selectedIndex].id.toString(),
                                slNo: state.list[selectedIndex].slNo,
                                status: state.list[selectedIndex].status,
                                labels: labels,
                                shiftBrfngAttnded:
                                    state.list[selectedIndex].shiftBrfngAttnded,
                                materialMovement:
                                    state.list[selectedIndex].materialMovement,
                                leoVisit: state.list[selectedIndex].leoVisit,
                                handOverSecurity:
                                    state.list[selectedIndex].handOverSecurity,
                                isOccurrenceStatus: true,
                                isMasterGuard: false,
                                isEventProtectionStatus: false,
                              );
                            },
                          );
                        },
                        onEditTap: (selectedIndex) {
                          getId(id: state.list[index].id ?? 0);
                        },
                        onViewTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.list[selectedIndex].id.toString(),
                                slNo: state.list[selectedIndex].slNo,
                                status: state.list[selectedIndex].status,
                                labels: labels,
                                shiftBrfngAttnded:
                                    state.list[selectedIndex].shiftBrfngAttnded,
                                materialMovement:
                                    state.list[selectedIndex].materialMovement,
                                leoVisit: state.list[selectedIndex].leoVisit,
                                handOverSecurity:
                                    state.list[selectedIndex].handOverSecurity,
                                isEventProtectionStatus: false,
                                isMasterGuard: false,
                                isOccurrenceStatus: true,
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

  getId({
    required int id,
  }) async {
    Navigator.pushNamed(
      context,
      occurrenceDetailsRoute,
      arguments: {
        'id': id.toString(),
        "title": Constants.editOccurrence,
      },
    );
  }
}
