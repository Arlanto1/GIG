import 'dart:developer';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_circular_loader.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_filter/base_filter_widget.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_no_record_found_widget.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_pop_up_items.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/guarding_rates/bloc/guarding_rates_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/services/guarding_services.dart';
import 'package:db_atom/src/models/base_filter_model.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class GuardingRates extends StatefulWidget {
  const GuardingRates({
    super.key,
  });

  @override
  State<GuardingRates> createState() => _GuardingRatesState();
}

class _GuardingRatesState extends State<GuardingRates> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<GuardingRatesBloc>().add(
          const InitializeValuesGR(),
        );
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
      context.read<GuardingRatesBloc>().add(FetchList(
            startPos: pageNumber,
            maxPos: 20,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  void _onRefresh() async {
    context.read<GuardingRatesBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) {
      setState(() {});
    }
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        // floatingActionButton: Flutterfloatingbutton(
        //   backgroundColor: AppColors.navigationSkybluecolor,
        //   foregroundColor: AppColors.backgroundWhitecolor,
        //   onPressed: () => {
        //     Navigator.pushNamed(
        //       context,
        //       guardingRateDetailsRoute,
        //       arguments: {
        //         "title": Constants.createGuardingRatingCards,
        //         "gmRate": GMRate(),
        //       },
        //     )
        //   },
        // ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.guardingRates,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
        ),
        body: BlocBuilder<GuardingRatesBloc, GuardingRatesState>(
            builder: (context, state) {
          // if (state.status == FormStatus.initial) {
          //   return const BaseLoader();
          // }
          // if (state.items.isEmptyOrNull) {
          //   return const NoRecordFoundWidget();
          // }
          return Container(
            margin: allMargin16,
            decoration: const ShapeDecoration(
                color: AppColors.backgroundWhitecolor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                )),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BaseSearchWidget(
                  applySearchFilters: applySearchFilters,
                  applyFilters: applyFilters,
                  commonFilters: state.commonFilters ??
                      CommonFilters(
                        statuses: [],
                        regions: [],
                      ),
                ),
                CommonWidgets.verticalSpacerWidget(height * 0.001),
                // if (state.status == FormStatus.loading) ...[
                //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                //   const BaseLoader(),
                //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                // ],
                // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
                // Text('state.status=====${state.status}'),
                if (state.items.isEmptyOrNull &&
                    state.status != FormStatus.loading) ...[
                  CommonWidgets.verticalSpacerWidget(height * 0.1),
                  const NoRecordFoundWidget(),
                ],

                Expanded(
                  child: SmartRefresher(
                    controller: refreshController,
                    enablePullDown: true,
                    physics: const BouncingScrollPhysics(),
                    header: const WaterDropHeader(
                      waterDropColor: AppColors.navigationSkybluecolor,
                      refresh: BaseLoader(),
                    ),
                    key: const Key(Keys.refreshKey),
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.hasReachedMax
                          ? state.items.length
                          : state.items.length + 1,
                      itemBuilder: (context, index) {
                        return index >= state.items.length
                            ? const BaseLoader()
                            : BaseListTileItem(
                                id: state.items[index].id,
                                inputDate: state.items[index].inputDate,
                                location: state.items[index].location,
                                locationRegion:
                                    state.items[index].locationRegion,
                                vendors: state.items[index].vendor,
                                onTap: (selectedIndex) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return BasePopUpItems(
                                        id: state.items[selectedIndex].id
                                            .toString(),
                                        inputDate: state
                                            .items[selectedIndex].inputDate,
                                        location:
                                            state.items[selectedIndex].location,
                                        locationRegion: state
                                            .items[selectedIndex]
                                            .locationRegion,
                                        slNo: state.items[selectedIndex].slNo,
                                        vendors:
                                            state.items[selectedIndex].vendor,
                                      );
                                    },
                                  );
                                },
                                onEditTap: (selectedIndex) {
                                  getId(state.items[index].id ?? 0);
                                },
                                onViewTap: (selectedIndex) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return BasePopUpItems(
                                        id: state.items[selectedIndex].id
                                            .toString(),
                                        inputDate: state
                                            .items[selectedIndex].inputDate,
                                        location:
                                            state.items[selectedIndex].location,
                                        locationRegion: state
                                            .items[selectedIndex]
                                            .locationRegion,
                                        slNo: state.items[selectedIndex].slNo,
                                        vendors:
                                            state.items[selectedIndex].vendor,

                                        // status: state.items[selectedIndex].status
                                        //     .toString(),
                                        // entrySecurityName: state
                                        //     .items[selectedIndex].entrySecurityName,
                                      );
                                    },
                                  );
                                },
                                index: index,
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }

  getId(int id) async {
    showLoadingDialog(context);

    GMRate response = await GuardingServices().getRate(id);

    log('----response sgr--------${response.securityGuardRates?.length}---');

    editDataLoading(response);
  }

  void editDataLoading(GMRate? rate) {
    dismissLoadingDialog(context);
    if (rate != null) {
      Navigator.pushNamed(
        context,
        guardingRateDetailsRoute,
        arguments: {
          "title": Constants.createGuardingRatingCards,
          "gmRate": rate,
        },
      );
    }
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    log('Applying Search Filters');

    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<GuardingRatesBloc>(context).add(
      FetchList(startPos: 0, maxPos: 20, newSearch: true, filters: filters),
    );
  }

  void applyFilters(
    Filters model,
  ) {
    log('Applying Filters');

    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
    log('id---filtersFun----${filters.filterCriteria!.filters!.id}---');

    BlocProvider.of<GuardingRatesBloc>(context).add(
      FetchList(startPos: 0, maxPos: 20, newSearch: true, filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
