import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_pop_up_items.dart';
import 'package:db_atom/src/common_widgets/floating_button.dart';
import 'package:db_atom/src/common_widgets/progress_indicators/custom_circular_progress_indicator.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enums/form_status.dart';
import '../../../../utils/util.dart';
import '../bloc/sst_incident_bloc.dart';

class SstIncidentView extends StatefulWidget {
  final bool isInternal;

  const SstIncidentView({
    super.key,
    required this.isInternal,
  });

  @override
  State<SstIncidentView> createState() => _SstIncidentViewState();
}

class _SstIncidentViewState extends State<SstIncidentView> {
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

  // void _onScroll() {
  //   if (!_scrollController.hasClients) return;
  //   final maxScroll = _scrollController.position.maxScrollExtent;
  //   final currentScroll = _scrollController.position.pixels;
  //
  //   // Set a threshold value, e.g., 100 pixels from the end
  //   const threshold = 1000.0;
  //
  //   if (maxScroll - currentScroll <= threshold) {
  //     pageNumber = pageNumber + 20;
  //     context
  //         .read<EventProtectionsBloc>()
  //         .add(InwardFetch(startPos: pageNumber, maxPos: 20));
  //   }
  // }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      pageNumber = pageNumber + 20;
      context
          .read<SstIncidentBloc>()
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
            Navigator.pushNamed(
              context,
              sstIncidentDetailsRoute,
            )
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: widget.isInternal
              ? Constants.internalStaff
              : Constants.externalVendor,
          showPopUp: true,
          showSaveButton: false,
          excelAPIName: 'exportEPExcel',
          pdfAPIName: 'exportEPPDF',
        ),
        body: BlocBuilder<SstIncidentBloc, SstIncidentState>(
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
                  ? state.items.length
                  : state.items.length + 1,
              itemBuilder: (context, index) {
                List<Label> labels = [];
                if (index < state.items.length) {
                  labels.add(Label(
                      key: 'Date of Creation',
                      value: state.items[index].inputDate != null
                          ? Utils.timestamptoDateConversion(
                              int.parse(state.items[index].inputDate ?? '0'),
                              Constants.dateFormat)
                          : ''));
                  labels.add(Label(
                      key: 'Region',
                      value: state.items[index].locationRegion?.name ?? ''));
                  labels.add(Label(
                      key: 'Location',
                      value: state.items[index].location?.name ?? ''));
                }

                return index >= state.items.length
                    ? const Center(
                        child: CustomCircularProgressIndicator(),
                      )
                    : BaseListTileItem(
                        id: state.items[index].id,
                        labels: labels,
                        status: state.items[index].status,
                        isMasterGuard: false,
                        onTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.items[selectedIndex].id.toString(),
                                labels: labels,
                                slNo: state.items[selectedIndex].slNo,
                                status: state.items[selectedIndex].status,
                                isMasterGuard: false,
                                epManager1Name:
                                    state.items[selectedIndex].epManager1Name,
                                eventType: state.items[selectedIndex].eventType,
                              );
                            },
                          );
                        },
                        onEditTap: (selectedIndex) {
                          getId(
                              id: state.items[index].id ?? 0,
                              eventStatus: state.items[index].status ?? 0);
                        },
                        onViewTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.items[selectedIndex].id.toString(),
                                labels: labels,
                                slNo: state.items[selectedIndex].slNo,
                                status: state.items[selectedIndex].status,
                                epManager1Name:
                                    state.items[selectedIndex].epManager1Name,
                                eventType: state.items[selectedIndex].eventType,
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

  getId({required int id, required int eventStatus}) async {
    Navigator.pushNamed(
      context,
      sstIncidentDetailsRoute,
      arguments: {
        'id': id.toString(),
        'eventStatus': eventStatus,
      },
    );
  }
}
