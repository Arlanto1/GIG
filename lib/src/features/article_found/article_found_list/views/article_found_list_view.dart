// // // //
// // // //
// // // // import 'dart:developer';
// // // // import 'dart:ui';
// // // //
// // // // import 'package:db_atom/index.dart';
// // // // import 'package:db_atom/src/features/article_found/article_found_list/bloc/article_found_list_bloc.dart';
// // // // import 'package:db_atom/src/features/article_found/models/article_found_model.dart';
// // // // import 'package:db_atom/src/features/article_found/services/article_found_service.dart';
// // // //
// // // // class ArticleFoundNewListView extends StatefulWidget {
// // // //   const ArticleFoundNewListView({
// // // //     super.key,
// // // //   });
// // // //
// // // //   @override
// // // //   State<ArticleFoundNewListView> createState() => _ArticleFoundNewListViewState();
// // // // }
// // // //
// // // // class _ArticleFoundNewListViewState extends State<ArticleFoundNewListView> {
// // // //   late final ScrollController _scrollController;
// // // //   int pageNumber = 0;
// // // //   BaseFilterModel filters = BaseFilterModel();
// // // //
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     context.read<ArticleFoundBloc>().add(
// // // //       const InitializeValuesAF(),
// // // //     );
// // // //     _scrollController = ScrollController()..addListener(_onScroll);
// // // //   }
// // // //
// // // //   @override
// // // //   void dispose() {
// // // //     _scrollController
// // // //       ..removeListener(_onScroll)
// // // //       ..dispose();
// // // //     super.dispose();
// // // //   }
// // // //
// // // //   void _onScroll() {
// // // //     if (!_scrollController.hasClients) return;
// // // //     final maxScroll = _scrollController.position.maxScrollExtent;
// // // //     final currentScroll = _scrollController.position.pixels;
// // // //     if (currentScroll == maxScroll) {
// // // //       pageNumber = pageNumber + 20;
// // // //       context.read<ArticleFoundBloc>().add(FetchArticleData(
// // // //         startPos: pageNumber,
// // // //         maxPos: Constants.maxResults,
// // // //         newSearch: false,
// // // //         filters: filters,
// // // //       ));
// // // //     }
// // // //   }
// // // //
// // // //   Future<void> _onRefresh() async {
// // // //     context.read<ArticleFoundBloc>().add(
// // // //       const RefreshList(),
// // // //     );
// // // //     await Future.delayed(const Duration(milliseconds: 2000));
// // // //   }
// // // //
// // // //   // @override
// // // //   // Widget build(BuildContext context) {
// // // //   //   final size = MediaQuery.of(context).size;
// // // //   //   double height = size.height;
// // // //   //   return BlocConsumer<ArticleFoundBloc, ArticleFoundState>(
// // // //   //       listener: (context, state) {},
// // // //   //       builder: (context, state) {
// // // //   //         log('plus ${state.extraProperties?.hasWritePermission}');
// // // //   //         return Scaffold(
// // // //   //             backgroundColor: const  Color(0xFF071130),
// // // //   //             floatingActionButton:
// // // //   //             state.extraProperties?.hasWritePermission ??
// // // //   //                 false
// // // //   //                 ?
// // // //   //             Flutterfloatingbutton(
// // // //   //               backgroundColor: AppColors.navigationSkyBlueColor,
// // // //   //               foregroundColor: AppColors.backgroundWhiteColor,
// // // //   //               onPressed: () => {
// // // //   //                 Navigator.pushNamed(context, articleFoundNewDetailsRoute,
// // // //   //                     arguments: {
// // // //   //                       "title": Constants.createFound
// // // //   //                     }),
// // // //   //               },
// // // //   //             )
// // // //   //                 : const SizedBox(),
// // // //   //             appBar: BaseAppBar().buildAppHeader(
// // // //   //               context: context,
// // // //   //               title: Constants.foundListTitle,
// // // //   //               showPopUp: true,
// // // //   //               showSaveButton: false,
// // // //   //               showSubmitButton: false,
// // // //   //               showDisLikeButton: false,
// // // //   //               showLikeButton: false,
// // // //   //               excelAPIName: 'exportFoundExcel',
// // // //   //               pdfAPIName: 'exportFoundPDF',
// // // //   //             ),
// // // //   //             body:
// // // //   //             BlocBuilder<ArticleFoundBloc, ArticleFoundState>(
// // // //   //                 builder: (context, state) {
// // // //   //                   return Container(
// // // //   //                     margin: allMargin16,
// // // //   //                     decoration: const ShapeDecoration(
// // // //   //                         color: AppColors.white,
// // // //   //                         shape: RoundedRectangleBorder(
// // // //   //                           borderRadius:
// // // //   //                           BorderRadius.vertical(top: Radius.circular(20.0)),
// // // //   //                         )),
// // // //   //                     child: Column(
// // // //   //                       children: [
// // // //   //                         BaseSearchWidget(
// // // //   //                           applySearchFilters: applySearchFilters,
// // // //   //                           applyFilters: applyFilters,
// // // //   //                           commonFilters: state.commonFilters ??
// // // //   //                               CommonFilters(
// // // //   //                                 statuses: [],
// // // //   //                                 regions: [],
// // // //   //                               ),
// // // //   //                         ),
// // // //   //                         CommonWidgets.verticalSpacerWidget(height * 0.001),
// // // //   //                         if (state.status == FormStatus.loading) ...[
// // // //   //                           CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // //   //                           const BaseLoader(),
// // // //   //                           CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // //   //                         ],
// // // //   //                         if (state.items.isEmptyOrNull &&
// // // //   //                             state.status != FormStatus.loading) ...[
// // // //   //                           CommonWidgets.verticalSpacerWidget(height * 0.1),
// // // //   //                           const NoRecordFoundWidget(),
// // // //   //                         ],
// // // //   //
// // // //   //                         Expanded(
// // // //   //                           child: CustomMaterialIndicator(
// // // //   //                             onRefresh: () => _onRefresh(),
// // // //   //                             backgroundColor: Colors.white,
// // // //   //                             indicatorBuilder: (context, controller) {
// // // //   //                               return const Padding(
// // // //   //                                 padding: EdgeInsets.all(6.0),
// // // //   //                                 child: BaseLoader(),
// // // //   //                               );
// // // //   //                             },
// // // //   //                             child: ListView.builder(
// // // //   //                               controller: _scrollController,
// // // //   //                               itemCount: state.hasReachedMax
// // // //   //                                   ? state.items.length
// // // //   //                                   : state.items.length + 1,
// // // //   //                               itemBuilder: (context, index) {
// // // //   //                                 List<Label> labels = [];
// // // //   //                                 if (index < state.items.length) {
// // // //   //                                   labels.add(Label(
// // // //   //                                       key:
// // // //   //                                       // state.labels?.locale.inputDate ??
// // // //   //                                       //     state.labels?.defaultLocale
// // // //   //                                       //         .inputDate ??
// // // //   //                                       Constants.dateofcreation,
// // // //   //                                       value: state.items[index].inputDate != null
// // // //   //                                           ? Utils.timestampToDateConversion(
// // // //   //                                           int.parse(
// // // //   //                                               state.items[index].inputDate ??
// // // //   //                                                   '0'),
// // // //   //                                           Constants
// // // //   //                                               .twentyFourHourDateTimeFormat)
// // // //   //                                           : ''));
// // // //   //                                   labels.add(Label(
// // // //   //                                       key:
// // // //   //                                       // state.labels?.locale.inputDate ??
// // // //   //                                       //     state.labels?.defaultLocale
// // // //   //                                       //         .inputDate ??
// // // //   //                                           Constants.founddate,
// // // //   //                                       value: state.items[index].foundDate != null
// // // //   //                                           ? Utils.timestampToDateConversion(
// // // //   //                                           int.parse(
// // // //   //                                               state.items[index].foundDate ??
// // // //   //                                                   '0'),
// // // //   //                                           Constants
// // // //   //                                               .twentyFourHourDateTimeFormat)
// // // //   //                                           : ''));
// // // //   //                                   labels.add(Label(
// // // //   //                                       key:
// // // //   //                                     // state.labels?.locale.locationRegion ??
// // // //   //                                       //     state.labels?.defaultLocale
// // // //   //                                       //         .locationRegion ??
// // // //   //                                           Constants.region,
// // // //   //                                       value:
// // // //   //                                       state.items[index].locationRegion?.name ?? ''));
// // // //   //                                   labels.add(Label(
// // // //   //                                       key:
// // // //   //                                       // state.labels?.locale.location ??
// // // //   //                                       //     state.labels?.defaultLocale.location ??
// // // //   //                                           Constants.location,
// // // //   //                                       value: state.items[index].location?.name ??
// // // //   //                                           ''));
// // // //   //                                   labels.add(Label(
// // // //   //                                       key:
// // // //   //                                       // state.labels?.locale.entrySecurity ??
// // // //   //                                       //     state.labels?.defaultLocale
// // // //   //                                       //         .entrySecurity ??
// // // //   //                                           Constants.createdby,
// // // //   //                                       value:
// // // //   //                                       '${state.items[index].entrySecurity?.firstName ?? ''} ${state.items[index].entrySecurity?.lastName ?? ''}'));
// // // //   //
// // // //   //                                   return index >= state.items.length
// // // //   //                                       ? const BaseLoader()
// // // //   //                                       : BaseListTileItem(
// // // //   //                                     id: state.items[index].id,
// // // //   //                                     status: state.items[index].status,
// // // //   //                                     labels: labels,
// // // //   //                                     isArticleFoundStatus: true,
// // // //   //                                     isEventProtectionStatus: false,
// // // //   //                                     onTap: (selectedIndex) {
// // // //   //                                       showDialog(
// // // //   //                                         context: context,
// // // //   //                                         builder:
// // // //   //                                             (BuildContext dialogContext) {
// // // //   //                                           return BasePopUpItems(
// // // //   //                                             id: state.items[selectedIndex].id
// // // //   //                                                 .toString(),
// // // //   //                                             status: state.items[index].status,
// // // //   //                                             slNo: state
// // // //   //                                                 .items[selectedIndex].slNo,
// // // //   //                                             labels: labels,
// // // //   //                                             isEventProtectionStatus: false,
// // // //   //                                             isMasterGuard: false,
// // // //   //                                             isArticleFoundStatus: true,
// // // //   //                                           );
// // // //   //                                         },
// // // //   //                                       );
// // // //   //                                     },
// // // //   //                                     onEditTap: (selectedIndex) {
// // // //   //                                       getById(
// // // //   //                                           state.extraProperties
// // // //   //                                               ?.hasWritePermission ??
// // // //   //                                               false,
// // // //   //                                           state.items[index].id ?? 0);
// // // //   //                                     },
// // // //   //                                     showEditButton: state
// // // //   //                                         .items[index].status ==
// // // //   //                                         ConstantsIntValue.articleFoundStatusFound || state
// // // //   //                                         .items[index].status ==
// // // //   //                                         ConstantsIntValue.articleFoundStatusUnderSecurityCustody,
// // // //   //                                     onViewTap: (selectedIndex) {
// // // //   //                                       showDialog(
// // // //   //                                         context: context,
// // // //   //                                         builder:
// // // //   //                                             (BuildContext dialogContext) {
// // // //   //                                           return BasePopUpItems(
// // // //   //                                             id: state.items[selectedIndex].id
// // // //   //                                                 .toString(),
// // // //   //                                             slNo: state
// // // //   //                                                 .items[selectedIndex].slNo,
// // // //   //                                             status: state.items[index].status,
// // // //   //                                             labels: labels,
// // // //   //                                             isEventProtectionStatus: false,
// // // //   //                                             isArticleFoundStatus: true,
// // // //   //                                             isMasterGuard: false,
// // // //   //                                           );
// // // //   //                                         },
// // // //   //                                       );
// // // //   //                                     },
// // // //   //                                     index: index,
// // // //   //                                   );
// // // //   //                                 }
// // // //   //
// // // //   //                                 // Handle the case where index is out of bounds
// // // //   //                                 return const Center(
// // // //   //                                   child: SizedBox(),
// // // //   //                                 );
// // // //   //                               },
// // // //   //                             ),
// // // //   //                           ),
// // // //   //                         ),
// // // //   //                       ],
// // // //   //                     ),
// // // //   //                   );
// // // //   //                 }));
// // // //   //       });
// // // //   // }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final size = MediaQuery.of(context).size;
// // // //     double height = size.height;
// // // //
// // // //     return BlocConsumer<ArticleFoundBloc, ArticleFoundState>(
// // // //       listener: (context, state) {},
// // // //       builder: (context, state) {
// // // //         log('plus ${state.extraProperties?.hasWritePermission}');
// // // //         return Scaffold(
// // // //           backgroundColor: const Color(0xFF071130),
// // // //           floatingActionButton: (state.extraProperties?.hasWritePermission ?? false)
// // // //               ? Container(
// // // //             decoration: BoxDecoration(
// // // //               color: Colors.white.withOpacity(0.2),
// // // //               borderRadius: BorderRadius.circular(50),
// // // //               boxShadow: [
// // // //                 BoxShadow(
// // // //                   color: Colors.white.withOpacity(0.3),
// // // //                   blurRadius: 6,
// // // //                   spreadRadius: 1,
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //             child: ClipRRect(
// // // //               borderRadius: BorderRadius.circular(50),
// // // //               child: BackdropFilter(
// // // //                 filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// // // //                 child: Flutterfloatingbutton(
// // // //                   backgroundColor: Colors.white.withOpacity(0.25),
// // // //                   foregroundColor: Colors.white,
// // // //                   onPressed: () {
// // // //                     Navigator.pushNamed(context, articleFoundNewDetailsRoute, arguments: {
// // // //                       "title": Constants.createFound
// // // //                     });
// // // //                   },
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           )
// // // //               : const SizedBox(),
// // // //           appBar: BaseAppBar().buildAppHeader(
// // // //             context: context,
// // // //             title: Constants.foundListTitle,
// // // //             showPopUp: true,
// // // //             showSaveButton: false,
// // // //             showSubmitButton: false,
// // // //             showDisLikeButton: false,
// // // //             showLikeButton: false,
// // // //             excelAPIName: 'exportFoundExcel',
// // // //             pdfAPIName: 'exportFoundPDF',
// // // //           ),
// // // //           body: Container(
// // // //             decoration: const BoxDecoration(
// // // //               gradient: LinearGradient(
// // // //                 colors: [
// // // //                   Color(0xFF071130),
// // // //                   Color(0xFF1B2A4A),
// // // //                   Color(0xFF2C3E66),
// // // //                 ],
// // // //                 begin: Alignment.topCenter,
// // // //                 end: Alignment.bottomCenter,
// // // //               ),
// // // //             ),
// // // //             child: Column(
// // // //               children: [
// // // //                 Container(
// // // //                   margin: const EdgeInsets.all(12),
// // // //                   decoration: BoxDecoration(
// // // //                     borderRadius: BorderRadius.circular(12),
// // // //                     color: Colors.white.withOpacity(0.25),
// // // //                     boxShadow: [
// // // //                       BoxShadow(
// // // //                         color: Colors.white.withOpacity(0.25),
// // // //                         blurRadius: 8,
// // // //                         spreadRadius: 1,
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                   child: ClipRRect(
// // // //                     borderRadius: BorderRadius.circular(12),
// // // //                     child: BackdropFilter(
// // // //                       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// // // //                       child: BaseSearchWidget(
// // // //                         applySearchFilters: applySearchFilters,
// // // //                         applyFilters: applyFilters,
// // // //                         commonFilters: state.commonFilters ??
// // // //                             CommonFilters(
// // // //                               statuses: [],
// // // //                               regions: [],
// // // //                             ),
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //                 if (state.status == FormStatus.loading) ...[
// // // //                   CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // //                   const BaseLoader(),
// // // //                   CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // //                 ],
// // // //                 if (state.items.isEmptyOrNull && state.status != FormStatus.loading) ...[
// // // //                   CommonWidgets.verticalSpacerWidget(height * 0.1),
// // // //                   const NoRecordFoundWidget(),
// // // //                 ],
// // // //                 Expanded(
// // // //                   child: CustomMaterialIndicator(
// // // //                     onRefresh: _onRefresh,
// // // //                     backgroundColor: Colors.transparent,
// // // //                     indicatorBuilder: (context, controller) {
// // // //                       return const Padding(
// // // //                         padding: EdgeInsets.all(6.0),
// // // //                         child: BaseLoader(),
// // // //                       );
// // // //                     },
// // // //                     child: ListView.builder(
// // // //                       controller: _scrollController,
// // // //                       itemCount: state.hasReachedMax
// // // //                           ? state.items.length
// // // //                           : state.items.length + 1,
// // // //                       itemBuilder: (context, index) {
// // // //                         if (index >= state.items.length) {
// // // //                           return const BaseLoader();
// // // //                         }
// // // //
// // // //                         final item = state.items[index];
// // // //                         List<Label> labels = [
// // // //                           Label(
// // // //                             key: Constants.dateofcreation,
// // // //                             value: item.inputDate != null
// // // //                                 ? Utils.timestampToDateConversion(
// // // //                                 int.parse(item.inputDate ?? '0'),
// // // //                                 Constants.twentyFourHourDateTimeFormat)
// // // //                                 : '',
// // // //                           ),
// // // //                           Label(
// // // //                             key: Constants.founddate,
// // // //                             value: item.foundDate != null
// // // //                                 ? Utils.timestampToDateConversion(
// // // //                                 int.parse(item.foundDate ?? '0'),
// // // //                                 Constants.twentyFourHourDateTimeFormat)
// // // //                                 : '',
// // // //                           ),
// // // //                           Label(key: Constants.region, value: item.locationRegion?.name ?? ''),
// // // //                           Label(key: Constants.location, value: item.location?.name ?? ''),
// // // //                           Label(
// // // //                             key: Constants.createdby,
// // // //                             value:
// // // //                             '${item.entrySecurity?.firstName ?? ''} ${item.entrySecurity?.lastName ?? ''}',
// // // //                           ),
// // // //                         ];
// // // //
// // // //                         return Container(
// // // //                           margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// // // //                           decoration: BoxDecoration(
// // // //                             borderRadius: BorderRadius.circular(16),
// // // //                             border: Border.all(color: Colors.white.withOpacity(0.3)),
// // // //                             boxShadow: [
// // // //                               BoxShadow(
// // // //                                 color: Colors.white.withOpacity(0.1),
// // // //                                 blurRadius: 8,
// // // //                                 spreadRadius: 1,
// // // //                               ),
// // // //                             ],
// // // //                           ),
// // // //                           child: ClipRRect(
// // // //                             borderRadius: BorderRadius.circular(16),
// // // //                             child: BackdropFilter(
// // // //                               filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
// // // //                               child: Container(
// // // //                                 decoration: BoxDecoration(
// // // //                                   color: Colors.white.withOpacity(0.08),
// // // //                                   borderRadius: BorderRadius.circular(16),
// // // //                                 ),
// // // //                                 child: BaseListTileItem(
// // // //                                   id: item.id,
// // // //                                   status: item.status,
// // // //                                   labels: labels,
// // // //                                   isArticleFoundStatus: true,
// // // //                                   isEventProtectionStatus: false,
// // // //                                   onTap: (selectedIndex) {
// // // //                                     showDialog(
// // // //                                       context: context,
// // // //                                       builder: (_) => BasePopUpItems(
// // // //                                         id: item.id.toString(),
// // // //                                         status: item.status,
// // // //                                         slNo: item.slNo,
// // // //                                         labels: labels,
// // // //                                         isEventProtectionStatus: false,
// // // //                                         isArticleFoundStatus: true,
// // // //                                         isMasterGuard: false,
// // // //                                       ),
// // // //                                     );
// // // //                                   },
// // // //                                   onEditTap: (selectedIndex) {
// // // //                                     getById(
// // // //                                       state.extraProperties?.hasWritePermission ?? false,
// // // //                                       item.id ?? 0,
// // // //                                     );
// // // //                                   },
// // // //                                   showEditButton: item.status ==
// // // //                                       ConstantsIntValue.articleFoundStatusFound ||
// // // //                                       item.status ==
// // // //                                           ConstantsIntValue
// // // //                                               .articleFoundStatusUnderSecurityCustody,
// // // //                                   onViewTap: (selectedIndex) {
// // // //                                     showDialog(
// // // //                                       context: context,
// // // //                                       builder: (_) => BasePopUpItems(
// // // //                                         id: item.id.toString(),
// // // //                                         slNo: item.slNo,
// // // //                                         status: item.status,
// // // //                                         labels: labels,
// // // //                                         isEventProtectionStatus: false,
// // // //                                         isArticleFoundStatus: true,
// // // //                                         isMasterGuard: false,
// // // //                                       ),
// // // //                                     );
// // // //                                   },
// // // //                                   index: index,
// // // //                                 ),
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                         );
// // // //                       },
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //         );
// // // //       },
// // // //     );
// // // //   }
// // // //
// // // //   getById(bool hasWritePermission, int id) async {
// // // //     showLoadingDialog(context);
// // // //
// // // //     ArticleFoundModel model=
// // // //     await ArticleFoundServices().getById(id);
// // // //
// // // //     editDataLoading(model, hasWritePermission);
// // // //   }
// // // //
// // // //   void editDataLoading(
// // // //       ArticleFoundModel? model, bool hasWritePermission) {
// // // //     dismissLoadingDialog(context);
// // // //     if (model != null) {
// // // //       Navigator.pushNamed(context, articleFoundNewDetailsRoute, arguments: {
// // // //         "model": model,
// // // //         "title": Constants.editFound,
// // // //         ConstantsArgument.extraProperties:
// // // //         ExtraProperties(hasWritePermission: hasWritePermission),
// // // //       });
// // // //     }
// // // //   }
// // // //
// // // //   void applySearchFilters(
// // // //       FilterCriteria model,
// // // //       ) {
// // // //     filters = BaseFilterModel(filterCriteria: model);
// // // //
// // // //     BlocProvider.of<ArticleFoundBloc>(context).add(
// // // //       FetchArticleData(
// // // //           startPos: 0,
// // // //           maxPos: Constants.maxResults,
// // // //           newSearch: true,
// // // //           filters: filters),
// // // //     );
// // // //   }
// // // //
// // // //   void applyFilters(
// // // //       Filters model,
// // // //       ) {
// // // //     filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
// // // //
// // // //     BlocProvider.of<ArticleFoundBloc>(context).add(
// // // //       FetchArticleData(
// // // //           startPos: 0,
// // // //           maxPos: Constants.maxResults,
// // // //           newSearch: true,
// // // //           filters: filters),
// // // //     );
// // // //     Navigator.pop(context);
// // // //   }
// // // // }
// // // //
// // // // //
// // // // // import 'dart:ui';
// // // // // import 'dart:developer';
// // // // // import 'package:db_atom/index.dart';
// // // // // import 'package:db_atom/src/features/article_found/article_found_list/bloc/article_found_list_bloc.dart';
// // // // // import 'package:db_atom/src/features/article_found/models/article_found_model.dart';
// // // // // import 'package:db_atom/src/features/article_found/services/article_found_service.dart';
// // // // //
// // // // // import 'dart:developer';
// // // // // import 'package:db_atom/index.dart';
// // // // // import 'package:db_atom/src/features/article_found/article_found_list/bloc/article_found_list_bloc.dart';
// // // // // import 'package:db_atom/src/features/article_found/models/article_found_model.dart';
// // // // // import 'package:db_atom/src/features/article_found/services/article_found_service.dart';
// // // // //
// // // // // class ArticleFoundNewListView extends StatefulWidget {
// // // // //   const ArticleFoundNewListView({super.key});
// // // // //
// // // // //   @override
// // // // //   State<ArticleFoundNewListView> createState() => _ArticleFoundNewListViewState();
// // // // // }
// // // // //
// // // // // class _ArticleFoundNewListViewState extends State<ArticleFoundNewListView> {
// // // // //   late final ScrollController _scrollController;
// // // // //   int pageNumber = 0;
// // // // //   BaseFilterModel filters = BaseFilterModel();
// // // // //
// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     context.read<ArticleFoundBloc>().add(const InitializeValuesAF());
// // // // //     _scrollController = ScrollController()..addListener(_onScroll);
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   void dispose() {
// // // // //     _scrollController
// // // // //       ..removeListener(_onScroll)
// // // // //       ..dispose();
// // // // //     super.dispose();
// // // // //   }
// // // // //
// // // // //   void _onScroll() {
// // // // //     if (!_scrollController.hasClients) return;
// // // // //     final maxScroll = _scrollController.position.maxScrollExtent;
// // // // //     final currentScroll = _scrollController.position.pixels;
// // // // //     if (currentScroll == maxScroll) {
// // // // //       pageNumber = pageNumber + 20;
// // // // //       context.read<ArticleFoundBloc>().add(FetchArticleData(
// // // // //         startPos: pageNumber,
// // // // //         maxPos: Constants.maxResults,
// // // // //         newSearch: false,
// // // // //         filters: filters,
// // // // //       ));
// // // // //     }
// // // // //   }
// // // // //
// // // // //   Future<void> _onRefresh() async {
// // // // //     context.read<ArticleFoundBloc>().add(const RefreshList());
// // // // //     await Future.delayed(const Duration(milliseconds: 2000));
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final size = MediaQuery.of(context).size;
// // // // //     double height = size.height;
// // // // //
// // // // //     return BlocConsumer<ArticleFoundBloc, ArticleFoundState>(
// // // // //       listener: (context, state) {},
// // // // //       builder: (context, state) {
// // // // //         log('plus ${state.extraProperties?.hasWritePermission}');
// // // // //         return Scaffold(
// // // // //           backgroundColor: Colors.transparent,
// // // // //           extendBodyBehindAppBar: true,
// // // // //           floatingActionButton: (state.extraProperties?.hasWritePermission ?? false)
// // // // //               ? Flutterfloatingbutton(
// // // // //             backgroundColor: AppColors.navigationSkyBlueColor,
// // // // //             foregroundColor: AppColors.backgroundWhiteColor,
// // // // //             onPressed: () => {
// // // // //               Navigator.pushNamed(context, articleFoundNewDetailsRoute, arguments: {
// // // // //                 "title": Constants.createFound
// // // // //               }),
// // // // //             },
// // // // //           )
// // // // //               : const SizedBox(),
// // // // //           appBar: BaseAppBar().buildAppHeader(
// // // // //             context: context,
// // // // //             title: Constants.foundListTitle,
// // // // //             showPopUp: true,
// // // // //             showSaveButton: false,
// // // // //             showSubmitButton: false,
// // // // //             showDisLikeButton: false,
// // // // //             showLikeButton: false,
// // // // //             excelAPIName: 'exportFoundExcel',
// // // // //             pdfAPIName: 'exportFoundPDF',
// // // // //           ),
// // // // //           // body: Container(
// // // // //           //   decoration: const BoxDecoration(
// // // // //           //     gradient: LinearGradient(
// // // // //           //       colors: [Color(0xFF1B2A4A), Color(0xFF1B2A4A), Color(0xFF2C3E66)],
// // // // //           //       begin: Alignment.topCenter,
// // // // //           //       end: Alignment.bottomCenter,
// // // // //           //     ),
// // // // //           //   ),
// // // // //           //   child: SafeArea(
// // // // //           //     child: Container(
// // // // //           //       decoration: BoxDecoration(
// // // // //           //         gradient: const LinearGradient(
// // // // //           //           begin: Alignment.topLeft,
// // // // //           //           end: Alignment.bottomRight,
// // // // //           //           colors: [
// // // // //           //             Color(0xFF2C3E7E),
// // // // //           //             Color(0xFF101D45),
// // // // //           //           ],
// // // // //           //         ),
// // // // //           //         borderRadius: BorderRadius.circular(16),
// // // // //           //         border: Border.all(
// // // // //           //           color: Colors.white.withOpacity(0.7),
// // // // //           //           width: 1.3,
// // // // //           //         ),
// // // // //           //         boxShadow: [
// // // // //           //           BoxShadow(
// // // // //           //             color: const Color(0xFF7DA2FF).withOpacity(0.5),
// // // // //           //             blurRadius: 12,
// // // // //           //             spreadRadius: 2,
// // // // //           //           ),
// // // // //           //           const BoxShadow(
// // // // //           //             color: Colors.black26,
// // // // //           //             offset: Offset(0, 3),
// // // // //           //             blurRadius: 6,
// // // // //           //           ),
// // // // //           //         ],
// // // // //           //       ),
// // // // //           //       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// // // // //           //       child: Column(
// // // // //           //         children: [
// // // // //           //           BaseSearchWidget(
// // // // //           //             applySearchFilters: applySearchFilters,
// // // // //           //             applyFilters: applyFilters,
// // // // //           //             commonFilters: state.commonFilters ??
// // // // //           //                 CommonFilters(
// // // // //           //                   statuses: [],
// // // // //           //                   regions: [],
// // // // //           //                 ),
// // // // //           //           ),
// // // // //           //           const SizedBox(height: 12),
// // // // //           //           if (state.status == FormStatus.loading)
// // // // //           //             const Center(child: BaseLoader()),
// // // // //           //           if (state.items.isEmptyOrNull && state.status != FormStatus.loading)
// // // // //           //             const Expanded(child: NoRecordFoundWidget()),
// // // // //           //           if (state.items.isNotEmpty)
// // // // //           //             Expanded(
// // // // //           //               child: CustomMaterialIndicator(
// // // // //           //                 onRefresh: _onRefresh,
// // // // //           //                 backgroundColor: Colors.transparent,
// // // // //           //                 indicatorBuilder: (context, controller) {
// // // // //           //                   return const Padding(
// // // // //           //                     padding: EdgeInsets.all(6.0),
// // // // //           //                     child: BaseLoader(),
// // // // //           //                   );
// // // // //           //                 },
// // // // //           //                 child: ListView.builder(
// // // // //           //                   controller: _scrollController,
// // // // //           //                   itemCount: state.hasReachedMax
// // // // //           //                       ? state.items.length
// // // // //           //                       : state.items.length + 1,
// // // // //           //                   itemBuilder: (context, index) {
// // // // //           //                     if (index >= state.items.length) {
// // // // //           //                       return const BaseLoader();
// // // // //           //                     }
// // // // //           //
// // // // //           //                     final item = state.items[index];
// // // // //           //                     final labels = [
// // // // //           //                       Label(
// // // // //           //                           key: Constants.dateofcreation,
// // // // //           //                           value: item.inputDate != null
// // // // //           //                               ? Utils.timestampToDateConversion(
// // // // //           //                               int.parse(item.inputDate ?? '0'),
// // // // //           //                               Constants.twentyFourHourDateTimeFormat)
// // // // //           //                               : ''),
// // // // //           //                       Label(
// // // // //           //                           key: Constants.founddate,
// // // // //           //                           value: item.foundDate != null
// // // // //           //                               ? Utils.timestampToDateConversion(
// // // // //           //                               int.parse(item.foundDate ?? '0'),
// // // // //           //                               Constants.twentyFourHourDateTimeFormat)
// // // // //           //                               : ''),
// // // // //           //                       Label(
// // // // //           //                           key: Constants.region,
// // // // //           //                           value: item.locationRegion?.name ?? ''),
// // // // //           //                       Label(
// // // // //           //                           key: Constants.location,
// // // // //           //                           value: item.location?.name ?? ''),
// // // // //           //                       Label(
// // // // //           //                           key: Constants.createdby,
// // // // //           //                           value:
// // // // //           //                           '${item.entrySecurity?.firstName ?? ''} ${item.entrySecurity?.lastName ?? ''}'),
// // // // //           //                     ];
// // // // //           //
// // // // //           //                     return _buildItemCard(context, item, labels, index, state);
// // // // //           //                   },
// // // // //           //                 ),
// // // // //           //               ),
// // // // //           //             ),
// // // // //           //         ],
// // // // //           //       ),
// // // // //           //     ),
// // // // //           //   ),
// // // // //           // ),
// // // // //           body: Container(
// // // // //             decoration: BoxDecoration(
// // // // //               // gradient: const LinearGradient(
// // // // //               //   begin: Alignment.topCenter,
// // // // //               //   end: Alignment.bottomCenter,
// // // // //               //   colors: [
// // // // //               //     Color(0xFF1B2A4A),
// // // // //               //     Color(0xFF1B2A4A),
// // // // //               //     Color(0xFF2C3E66),
// // // // //               //   ],
// // // // //               // ),
// // // // //               borderRadius: BorderRadius.circular(16),
// // // // //               // border: Border.all(
// // // // //               //   color: Colors.white.withOpacity(0.7),
// // // // //               //   width: 1.3,
// // // // //               // ),
// // // // //               boxShadow: [
// // // // //                 BoxShadow(
// // // // //                   color: const Color(0xFF7DA2FF).withOpacity(0.5),
// // // // //                   blurRadius: 12,
// // // // //                   spreadRadius: 19,
// // // // //                 ),
// // // // //                 const BoxShadow(
// // // // //                   color: Colors.black26,
// // // // //                   offset: Offset(0, 3),
// // // // //                   blurRadius: 6,
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //             margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// // // // //             child: SafeArea(
// // // // //               child: Column(
// // // // //                 children: [
// // // // //                   BaseSearchWidget(
// // // // //                     applySearchFilters: applySearchFilters,
// // // // //                     applyFilters: applyFilters,
// // // // //                     commonFilters: state.commonFilters ??
// // // // //                         CommonFilters(
// // // // //                           statuses: [],
// // // // //                           regions: [],
// // // // //                         ),
// // // // //                   ),
// // // // //                   const SizedBox(height: 12),
// // // // //                   if (state.status == FormStatus.loading)
// // // // //                     const Center(child: BaseLoader()),
// // // // //                   if (state.items.isEmptyOrNull && state.status != FormStatus.loading)
// // // // //                     const Expanded(child: NoRecordFoundWidget()),
// // // // //                   if (state.items.isNotEmpty)
// // // // //                     Expanded(
// // // // //                       child: CustomMaterialIndicator(
// // // // //                         onRefresh: _onRefresh,
// // // // //                         backgroundColor: Colors.transparent,
// // // // //                         indicatorBuilder: (context, controller) {
// // // // //                           return const Padding(
// // // // //                             padding: EdgeInsets.all(6.0),
// // // // //                             child: BaseLoader(),
// // // // //                           );
// // // // //                         },
// // // // //                         child: ListView.builder(
// // // // //                           controller: _scrollController,
// // // // //                           itemCount: state.hasReachedMax
// // // // //                               ? state.items.length
// // // // //                               : state.items.length + 1,
// // // // //                           itemBuilder: (context, index) {
// // // // //                             if (index >= state.items.length) {
// // // // //                               return const BaseLoader();
// // // // //                             }
// // // // //
// // // // //                             final item = state.items[index];
// // // // //                             final labels = [
// // // // //                               Label(
// // // // //                                 key: Constants.dateofcreation,
// // // // //                                 value: item.inputDate != null
// // // // //                                     ? Utils.timestampToDateConversion(
// // // // //                                   int.parse(item.inputDate ?? '0'),
// // // // //                                   Constants.twentyFourHourDateTimeFormat,
// // // // //                                 )
// // // // //                                     : '',
// // // // //                               ),
// // // // //                               Label(
// // // // //                                 key: Constants.founddate,
// // // // //                                 value: item.foundDate != null
// // // // //                                     ? Utils.timestampToDateConversion(
// // // // //                                   int.parse(item.foundDate ?? '0'),
// // // // //                                   Constants.twentyFourHourDateTimeFormat,
// // // // //                                 )
// // // // //                                     : '',
// // // // //                               ),
// // // // //                               Label(
// // // // //                                 key: Constants.region,
// // // // //                                 value: item.locationRegion?.name ?? '',
// // // // //                               ),
// // // // //                               Label(
// // // // //                                 key: Constants.location,
// // // // //                                 value: item.location?.name ?? '',
// // // // //                               ),
// // // // //                               Label(
// // // // //                                 key: Constants.createdby,
// // // // //                                 value:
// // // // //                                 '${item.entrySecurity?.firstName ?? ''} ${item.entrySecurity?.lastName ?? ''}',
// // // // //                               ),
// // // // //                             ];
// // // // //
// // // // //                             return _buildItemCard(context, item, labels, index, state);
// // // // //                           },
// // // // //                         ),
// // // // //                       ),
// // // // //                     ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Widget _buildItemCard(BuildContext context, dynamic item, List<Label> labels,
// // // // //       int index, ArticleFoundState state) {
// // // // //     final Color statusColor;
// // // // //     final String statusText;
// // // // //
// // // // //     switch (item.status) {
// // // // //       case ConstantsIntValue.articleFoundStatusFound:
// // // // //         statusColor = Colors.blue;
// // // // //         statusText = 'Found';
// // // // //         break;
// // // // //       case ConstantsIntValue.articleFoundStatusUnderSecurityCustody:
// // // // //         statusColor = Colors.blue;
// // // // //         statusText = 'Under Security Custody';
// // // // //         break;
// // // // //       default:
// // // // //         statusColor = Colors.blue;
// // // // //         statusText = 'Unknown';
// // // // //     }
// // // // //
// // // // //     return GestureDetector(
// // // // //       onTap: () {
// // // // //         showDialog(
// // // // //           context: context,
// // // // //           builder: (BuildContext dialogContext) {
// // // // //             return BasePopUpItems(
// // // // //               id: item.id.toString(),
// // // // //               status: item.status,
// // // // //               slNo: item.slNo,
// // // // //               labels: labels,
// // // // //               isEventProtectionStatus: false,
// // // // //               isArticleFoundStatus: true,
// // // // //               isMasterGuard: false,
// // // // //             );
// // // // //           },
// // // // //         );
// // // // //       },
// // // // //       child: Container(
// // // // //         margin: const EdgeInsets.symmetric(vertical: 6),
// // // // //         padding: const EdgeInsets.all(12),
// // // // //         // decoration: BoxDecoration(
// // // // //         //   borderRadius: BorderRadius.circular(16),
// // // // //         //   color: Colors.white.withOpacity(0.1),
// // // // //         //   boxShadow: [
// // // // //         //     BoxShadow(
// // // // //         //       color: Colors.red.withOpacity(0.25),
// // // // //         //       blurRadius: 8,
// // // // //         //       offset: const Offset(0, 4),
// // // // //         //     ),
// // // // //         //   ],
// // // // //         //   border: Border.all(color: Colors.white24),
// // // // //         // ),
// // // // //         decoration: BoxDecoration(
// // // // //           gradient: const LinearGradient(
// // // // //             begin: Alignment.topLeft,
// // // // //             end: Alignment.bottomRight,
// // // // //             colors: [
// // // // //               Color(0xFF2C3E7E),
// // // // //               Color(0xFF101D45),
// // // // //             ],
// // // // //           ),
// // // // //           borderRadius: BorderRadius.circular(16),
// // // // //           border: Border.all(
// // // // //             color: Colors.white.withOpacity(0.7),
// // // // //             width: 1.3,
// // // // //           ),
// // // // //           boxShadow: [
// // // // //             BoxShadow(
// // // // //               color: const Color(0xFF7DA2FF).withOpacity(0.5),
// // // // //               blurRadius: 12,
// // // // //               spreadRadius: 2,
// // // // //             ),
// // // // //             const BoxShadow(
// // // // //               color: Colors.black26,
// // // // //               offset: Offset(0, 3),
// // // // //               blurRadius: 6,
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //         child: Column(
// // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //           children: [
// // // // //             Row(
// // // // //               children: [
// // // // //                 Text("ID: ${item.id}",
// // // // //                     style: const TextStyle(
// // // // //                         color: Colors.white, fontWeight: FontWeight.w600)),
// // // // //                 const Spacer(),
// // // // //                 Container(
// // // // //                   padding:
// // // // //                   const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// // // // //                   decoration: BoxDecoration(
// // // // //                     color: statusColor.withOpacity(0.2),
// // // // //                     borderRadius: BorderRadius.circular(12),
// // // // //                   ),
// // // // //                   child: Text(
// // // // //                     statusText,
// // // // //                     style: TextStyle(
// // // // //                       color: statusColor,
// // // // //                       fontSize: 12,
// // // // //                       fontWeight: FontWeight.w600,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //                 const SizedBox(width: 8),
// // // // //                 GestureDetector(
// // // // //                   onTap: () => getById(
// // // // //                       state.extraProperties?.hasWritePermission ?? false,
// // // // //                       item.id ?? 0),
// // // // //                   child: const Icon(Icons.edit_outlined,
// // // // //                       color: Colors.white70, size: 20),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //             const SizedBox(height: 8),
// // // // //             ...labels.map((label) => Padding(
// // // // //               padding: const EdgeInsets.symmetric(vertical: 2),
// // // // //               child: RichText(
// // // // //                 text: TextSpan(
// // // // //                   children: [
// // // // //                     TextSpan(
// // // // //                       text: '${label.key}: ',
// // // // //                       style: const TextStyle(
// // // // //                           color: Colors.white70,
// // // // //                           fontWeight: FontWeight.w500),
// // // // //                     ),
// // // // //                     TextSpan(
// // // // //                       text: label.value,
// // // // //                       style: const TextStyle(
// // // // //                           color: Colors.white,
// // // // //                           fontWeight: FontWeight.w400),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //             )),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   getById(bool hasWritePermission, int id) async {
// // // // //     showLoadingDialog(context);
// // // // //     ArticleFoundModel model = await ArticleFoundServices().getById(id);
// // // // //     editDataLoading(model, hasWritePermission);
// // // // //   }
// // // // //
// // // // //   void editDataLoading(ArticleFoundModel? model, bool hasWritePermission) {
// // // // //     dismissLoadingDialog(context);
// // // // //     if (model != null) {
// // // // //       Navigator.pushNamed(context, articleFoundNewDetailsRoute, arguments: {
// // // // //         "model": model,
// // // // //         "title": Constants.editFound,
// // // // //         ConstantsArgument.extraProperties:
// // // // //         ExtraProperties(hasWritePermission: hasWritePermission),
// // // // //       });
// // // // //     }
// // // // //   }
// // // // //
// // // // //   void applySearchFilters(FilterCriteria model) {
// // // // //     filters = BaseFilterModel(filterCriteria: model);
// // // // //     BlocProvider.of<ArticleFoundBloc>(context).add(FetchArticleData(
// // // // //         startPos: 0,
// // // // //         maxPos: Constants.maxResults,
// // // // //         newSearch: true,
// // // // //         filters: filters));
// // // // //   }
// // // // //
// // // // //   void applyFilters(Filters model) {
// // // // //     filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
// // // // //     BlocProvider.of<ArticleFoundBloc>(context).add(FetchArticleData(
// // // // //         startPos: 0,
// // // // //         maxPos: Constants.maxResults,
// // // // //         newSearch: true,
// // // // //         filters: filters));
// // // // //     Navigator.pop(context);
// // // // //   }
// // // // // }
// // // import 'dart:developer';
// // // import 'dart:ui';
// // // import 'package:db_atom/index.dart';
// // // import 'package:db_atom/src/features/article_found/article_found_list/bloc/article_found_list_bloc.dart';
// // // import 'package:db_atom/src/features/article_found/models/article_found_model.dart';
// // // import 'package:db_atom/src/features/article_found/services/article_found_service.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // //
// // // class ArticleFoundNewListView extends StatefulWidget {
// // //   const ArticleFoundNewListView({super.key});
// // //
// // //   @override
// // //   State<ArticleFoundNewListView> createState() => _ArticleFoundNewListViewState();
// // // }
// // //
// // // class _ArticleFoundNewListViewState extends State<ArticleFoundNewListView> {
// // //   late final ScrollController _scrollController;
// // //   int pageNumber = 0;
// // //   BaseFilterModel filters = BaseFilterModel();
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     context.read<ArticleFoundBloc>().add(const InitializeValuesAF());
// // //     _scrollController = ScrollController()..addListener(_onScroll);
// // //   }
// // //
// // //   @override
// // //   void dispose() {
// // //     _scrollController
// // //       ..removeListener(_onScroll)
// // //       ..dispose();
// // //     super.dispose();
// // //   }
// // //
// // //   void _onScroll() {
// // //     if (!_scrollController.hasClients) return;
// // //     final maxScroll = _scrollController.position.maxScrollExtent;
// // //     final currentScroll = _scrollController.position.pixels;
// // //     if (currentScroll == maxScroll) {
// // //       pageNumber = pageNumber + 20;
// // //       context.read<ArticleFoundBloc>().add(FetchArticleData(
// // //         startPos: pageNumber,
// // //         maxPos: Constants.maxResults,
// // //         newSearch: false,
// // //         filters: filters,
// // //       ));
// // //     }
// // //   }
// // //
// // //   Future<void> _onRefresh() async {
// // //     context.read<ArticleFoundBloc>().add(const RefreshList());
// // //     await Future.delayed(const Duration(milliseconds: 2000));
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final size = MediaQuery.of(context).size;
// // //     double height = size.height;
// // //
// // //     return BlocConsumer<ArticleFoundBloc, ArticleFoundState>(
// // //       listener: (context, state) {},
// // //       builder: (context, state) {
// // //         log('plus ${state.extraProperties?.hasWritePermission}');
// // //         return Scaffold(
// // //           backgroundColor: const Color(0xFF0A1638),
// // //           floatingActionButton: (state.extraProperties?.hasWritePermission ?? false)
// // //               ? Flutterfloatingbutton(
// // //             backgroundColor: AppColors.navigationSkyBlueColor,
// // //             foregroundColor: AppColors.backgroundWhiteColor,
// // //             onPressed: () => {
// // //               Navigator.pushNamed(context, articleFoundNewDetailsRoute,
// // //                   arguments: {"title": Constants.createFound}),
// // //             },
// // //           )
// // //               : const SizedBox(),
// // //           appBar: BaseAppBar().buildAppHeader(
// // //             context: context,
// // //             title: Constants.foundListTitle,
// // //             showPopUp: true,
// // //             showSaveButton: false,
// // //             showSubmitButton: false,
// // //             showDisLikeButton: false,
// // //             showLikeButton: false,
// // //             excelAPIName: 'exportFoundExcel',
// // //             pdfAPIName: 'exportFoundPDF',
// // //           ),
// // //           body: Stack(
// // //             children: [
// // //               // Gradient glass background
// // //               // Container(
// // //               //   decoration: const BoxDecoration(
// // //               //     gradient: LinearGradient(
// // //               //       colors: [
// // //               //         Color(0xFF1B2A4A),
// // //               //         Color(0xFF1B2A4A),
// // //               //         Color(0xFF2C3E66)
// // //               //       ],
// // //               //       begin: Alignment.topCenter,
// // //               //       end: Alignment.bottomCenter,
// // //               //     ),
// // //               //   ),
// // //               // ),
// // //
// // //               // Glass content
// // //               Container(
// // //                 margin: const EdgeInsets.all(12),
// // //                 child:
// // //                 ClipRRect(
// // //                   borderRadius: BorderRadius.circular(20.0),
// // //                   child: BackdropFilter(
// // //                     filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
// // //                     child: Container(
// // //                       // decoration: BoxDecoration(
// // //                       //   color: Colors.transparent,
// // //                       //   borderRadius: BorderRadius.circular(20.0),
// // //                       //   border: Border.all(
// // //                       //     color: Colors.white.withOpacity(0.25),
// // //                       //     width: 1,
// // //                       //   ),
// // //                       //   boxShadow: [
// // //                       //     BoxShadow(
// // //                       //       color: Colors.black.withOpacity(0.25),
// // //                       //       blurRadius: 10,
// // //                       //       offset: const Offset(0, 4),
// // //                       //     ),
// // //                       //   ],
// // //                       // ),
// // //                       child: Padding(
// // //                         padding: const EdgeInsets.all(8.0),
// // //                         child: Column(
// // //                           children: [
// // //                             BaseSearchWidget(
// // //                               applySearchFilters: applySearchFilters,
// // //                               applyFilters: applyFilters,
// // //                               commonFilters: state.commonFilters ??
// // //                                   CommonFilters(statuses: [], regions: []),
// // //                             ),
// // //                             CommonWidgets.verticalSpacerWidget(height * 0.001),
// // //
// // //                             if (state.status == FormStatus.loading) ...[
// // //                               CommonWidgets.verticalSpacerWidget(height * 0.01),
// // //                               const BaseLoader(),
// // //                               CommonWidgets.verticalSpacerWidget(height * 0.01),
// // //                             ],
// // //
// // //                             if (state.items.isEmptyOrNull &&
// // //                                 state.status != FormStatus.loading) ...[
// // //                               CommonWidgets.verticalSpacerWidget(height * 0.1),
// // //                               const NoRecordFoundWidget(),
// // //                             ],
// // //
// // //                             // Main list view with glass tile look
// // //                             Expanded(
// // //                               child: CustomMaterialIndicator(
// // //                                 onRefresh: () => _onRefresh(),
// // //                                 backgroundColor: Colors.transparent,
// // //                                 indicatorBuilder: (context, controller) {
// // //                                   return const Padding(
// // //                                     padding: EdgeInsets.all(6.0),
// // //                                     child: BaseLoader(),
// // //                                   );
// // //                                 },
// // //                                 child: ListView.builder(
// // //                                   controller: _scrollController,
// // //                                   itemCount: state.hasReachedMax
// // //                                       ? state.items.length
// // //                                       : state.items.length + 1,
// // //                                   // itemBuilder: (context, index) {
// // //                                   //   if (index >= state.items.length) {
// // //                                   //     return const BaseLoader();
// // //                                   //   }
// // //                                   //
// // //                                   //   final item = state.items[index];
// // //                                   //   List<Label> labels = [
// // //                                   //     Label(
// // //                                   //         key: Constants.dateofcreation,
// // //                                   //         value: item.inputDate != null
// // //                                   //             ? Utils.timestampToDateConversion(
// // //                                   //             int.parse(item.inputDate ?? '0'),
// // //                                   //             Constants.twentyFourHourDateTimeFormat)
// // //                                   //             : ''),
// // //                                   //     Label(
// // //                                   //         key: Constants.founddate,
// // //                                   //         value: item.foundDate != null
// // //                                   //             ? Utils.timestampToDateConversion(
// // //                                   //             int.parse(item.foundDate ?? '0'),
// // //                                   //             Constants.twentyFourHourDateTimeFormat)
// // //                                   //             : ''),
// // //                                   //     Label(
// // //                                   //         key: Constants.region,
// // //                                   //         value: item.locationRegion?.name ?? ''),
// // //                                   //     Label(
// // //                                   //         key: Constants.location,
// // //                                   //         value: item.location?.name ?? ''),
// // //                                   //     Label(
// // //                                   //         key: Constants.createdby,
// // //                                   //         value:
// // //                                   //         '${item.entrySecurity?.firstName ?? ''} ${item.entrySecurity?.lastName ?? ''}'),
// // //                                   //   ];
// // //                                   //
// // //                                   //   return Container(
// // //                                   //     margin: const EdgeInsets.symmetric(
// // //                                   //         horizontal: 8, vertical: 6),
// // //                                   //     decoration: BoxDecoration(
// // //                                   //       borderRadius: BorderRadius.circular(14),
// // //                                   //       border: Border.all(
// // //                                   //           color: Colors.white.withOpacity(0.2)),
// // //                                   //       color: Colors.white.withOpacity(0.08),
// // //                                   //       boxShadow: [
// // //                                   //         BoxShadow(
// // //                                   //           color:
// // //                                   //           Colors.black.withOpacity(0.15),
// // //                                   //           blurRadius: 6,
// // //                                   //           offset: const Offset(0, 3),
// // //                                   //         ),
// // //                                   //       ],
// // //                                   //     ),
// // //                                   //     child: BaseListTileItem(
// // //                                   //       id: item.id,
// // //                                   //       status: item.status,
// // //                                   //       labels: labels,
// // //                                   //       isArticleFoundStatus: true,
// // //                                   //       isEventProtectionStatus: false,
// // //                                   //       onTap: (selectedIndex) {
// // //                                   //         showDialog(
// // //                                   //           context: context,
// // //                                   //           builder: (BuildContext dialogContext) {
// // //                                   //             return BasePopUpItems(
// // //                                   //               id: state
// // //                                   //                   .items[selectedIndex].id
// // //                                   //                   .toString(),
// // //                                   //               status: item.status,
// // //                                   //               slNo: state
// // //                                   //                   .items[selectedIndex].slNo,
// // //                                   //               labels: labels,
// // //                                   //               isEventProtectionStatus: false,
// // //                                   //               isMasterGuard: false,
// // //                                   //               isArticleFoundStatus: true,
// // //                                   //             );
// // //                                   //           },
// // //                                   //         );
// // //                                   //       },
// // //                                   //       onEditTap: (selectedIndex) {
// // //                                   //         getById(
// // //                                   //             state.extraProperties
// // //                                   //                 ?.hasWritePermission ??
// // //                                   //                 false,
// // //                                   //             item.id ?? 0);
// // //                                   //       },
// // //                                   //       showEditButton: item.status ==
// // //                                   //           ConstantsIntValue
// // //                                   //               .articleFoundStatusFound ||
// // //                                   //           item.status ==
// // //                                   //               ConstantsIntValue
// // //                                   //                   .articleFoundStatusUnderSecurityCustody,
// // //                                   //       onViewTap: (selectedIndex) {
// // //                                   //         showDialog(
// // //                                   //           context: context,
// // //                                   //           builder: (BuildContext dialogContext) {
// // //                                   //             return BasePopUpItems(
// // //                                   //               id: state
// // //                                   //                   .items[selectedIndex].id
// // //                                   //                   .toString(),
// // //                                   //               slNo: state
// // //                                   //                   .items[selectedIndex].slNo,
// // //                                   //               status: item.status,
// // //                                   //               labels: labels,
// // //                                   //               isEventProtectionStatus: false,
// // //                                   //               isArticleFoundStatus: true,
// // //                                   //               isMasterGuard: false,
// // //                                   //             );
// // //                                   //           },
// // //                                   //         );
// // //                                   //       },
// // //                                   //       index: index,
// // //                                   //     ),
// // //                                   //   );
// // //                                   // },
// // //                                   itemBuilder: (context, index) {
// // //                                     if (index >= state.items.length) {
// // //                                       return const BaseLoader();
// // //                                     }
// // //
// // //                                     final item = state.items[index];
// // //                                     List<Label> labels = [
// // //                                       Label(
// // //                                           key: Constants.dateofcreation,
// // //                                           value: item.inputDate != null
// // //                                               ? Utils.timestampToDateConversion(
// // //                                               int.parse(item.inputDate ?? '0'),
// // //                                               Constants.twentyFourHourDateTimeFormat)
// // //                                               : ''),
// // //                                       Label(
// // //                                           key: Constants.founddate,
// // //                                           value: item.foundDate != null
// // //                                               ? Utils.timestampToDateConversion(
// // //                                               int.parse(item.foundDate ?? '0'),
// // //                                               Constants.twentyFourHourDateTimeFormat)
// // //                                               : ''),
// // //                                       Label(key: Constants.region, value: item.locationRegion?.name ?? ''),
// // //                                       Label(key: Constants.location, value: item.location?.name ?? ''),
// // //                                       Label(
// // //                                           key: Constants.createdby,
// // //                                           value:
// // //                                           '${item.entrySecurity?.firstName ?? ''} ${item.entrySecurity?.lastName ?? ''}'),
// // //                                     ];
// // //
// // //                                     return Padding(
// // //                                       padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
// // //                                       child: ClipRRect(
// // //                                         borderRadius: BorderRadius.circular(14),
// // //                                         child: BackdropFilter(
// // //                                           filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
// // //                                           child: Container(
// // //                                             decoration: BoxDecoration(
// // //                                               color: Colors.white.withOpacity(0.08),
// // //                                               border: Border.all(color: Colors.white.withOpacity(0.25), width: 1),
// // //                                               borderRadius: BorderRadius.circular(14),
// // //                                               boxShadow: [
// // //                                                 BoxShadow(
// // //                                                   color: Colors.black.withOpacity(0.3),
// // //                                                   blurRadius: 8,
// // //                                                   offset: const Offset(2, 3),
// // //                                                 ),
// // //                                               ],
// // //                                             ),
// // //                                             child: Padding(
// // //                                               padding: const EdgeInsets.all(10.0),
// // //                                               child: BaseListTileItem(
// // //                                                 id: item.id,
// // //                                                 status: item.status,
// // //                                                 labels: labels,
// // //                                                 isArticleFoundStatus: true,
// // //                                                 isEventProtectionStatus: false,
// // //                                                 onTap: (selectedIndex) {
// // //                                                   showDialog(
// // //                                                     context: context,
// // //                                                     builder: (BuildContext dialogContext) {
// // //                                                       return BasePopUpItems(
// // //                                                         id: state.items[selectedIndex].id.toString(),
// // //                                                         status: item.status,
// // //                                                         slNo: state.items[selectedIndex].slNo,
// // //                                                         labels: labels,
// // //                                                         isEventProtectionStatus: false,
// // //                                                         isMasterGuard: false,
// // //                                                         isArticleFoundStatus: true,
// // //                                                       );
// // //                                                     },
// // //                                                   );
// // //                                                 },
// // //                                                 onEditTap: (selectedIndex) {
// // //                                                   getById(
// // //                                                       state.extraProperties?.hasWritePermission ?? false,
// // //                                                       item.id ?? 0);
// // //                                                 },
// // //                                                 showEditButton: item.status ==
// // //                                                     ConstantsIntValue.articleFoundStatusFound ||
// // //                                                     item.status ==
// // //                                                         ConstantsIntValue
// // //                                                             .articleFoundStatusUnderSecurityCustody,
// // //                                                 onViewTap: (selectedIndex) {
// // //                                                   showDialog(
// // //                                                     context: context,
// // //                                                     builder: (BuildContext dialogContext) {
// // //                                                       return BasePopUpItems(
// // //                                                         id: state.items[selectedIndex].id.toString(),
// // //                                                         slNo: state.items[selectedIndex].slNo,
// // //                                                         status: item.status,
// // //                                                         labels: labels,
// // //                                                         isEventProtectionStatus: false,
// // //                                                         isArticleFoundStatus: true,
// // //                                                         isMasterGuard: false,
// // //                                                       );
// // //                                                     },
// // //                                                   );
// // //                                                 },
// // //                                                 index: index,
// // //                                               ),
// // //                                             ),
// // //                                            ),
// // //                                          ),
// // //                                       ),
// // //                                     );
// // //                                   },
// // //
// // //                                 ),
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //                ),
// // //             ],
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   getById(bool hasWritePermission, int id) async {
// // //     showLoadingDialog(context);
// // //     ArticleFoundModel model = await ArticleFoundServices().getById(id);
// // //     editDataLoading(model, hasWritePermission);
// // //   }
// // //
// // //   void editDataLoading(ArticleFoundModel? model, bool hasWritePermission) {
// // //     dismissLoadingDialog(context);
// // //     if (model != null) {
// // //       Navigator.pushNamed(context, articleFoundNewDetailsRoute, arguments: {
// // //         "model": model,
// // //         "title": Constants.editFound,
// // //         ConstantsArgument.extraProperties:
// // //         ExtraProperties(hasWritePermission: hasWritePermission),
// // //       });
// // //     }
// // //   }
// // //
// // //   void applySearchFilters(FilterCriteria model) {
// // //     filters = BaseFilterModel(filterCriteria: model);
// // //     BlocProvider.of<ArticleFoundBloc>(context).add(FetchArticleData(
// // //         startPos: 0,
// // //         maxPos: Constants.maxResults,
// // //         newSearch: true,
// // //         filters: filters));
// // //   }
// // //
// // //   void applyFilters(Filters model) {
// // //     filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
// // //     BlocProvider.of<ArticleFoundBloc>(context).add(FetchArticleData(
// // //         startPos: 0,
// // //         maxPos: Constants.maxResults,
// // //         newSearch: true,
// // //         filters: filters));
// // //     Navigator.pop(context);
// // //   }
// // // }
// //
// // import 'dart:developer';
// // import 'dart:ui';
// // import 'package:db_atom/index.dart';
// // import 'package:db_atom/src/features/article_found/article_found_list/bloc/article_found_list_bloc.dart';
// // import 'package:db_atom/src/features/article_found/models/article_found_model.dart';
// // import 'package:db_atom/src/features/article_found/services/article_found_service.dart';
// //
// // class ArticleFoundNewListView extends StatefulWidget {
// //   const ArticleFoundNewListView({super.key});
// //
// //   @override
// //   State<ArticleFoundNewListView> createState() => _ArticleFoundNewListViewState();
// // }
// //
// // class _ArticleFoundNewListViewState extends State<ArticleFoundNewListView> {
// //   late final ScrollController _scrollController;
// //   int pageNumber = 0;
// //   BaseFilterModel filters = BaseFilterModel();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     context.read<ArticleFoundBloc>().add(const InitializeValuesAF());
// //     _scrollController = ScrollController()..addListener(_onScroll);
// //   }
// //
// //   @override
// //   void dispose() {
// //     _scrollController
// //       ..removeListener(_onScroll)
// //       ..dispose();
// //     super.dispose();
// //   }
// //
// //   void _onScroll() {
// //     if (!_scrollController.hasClients) return;
// //     final maxScroll = _scrollController.position.maxScrollExtent;
// //     final currentScroll = _scrollController.position.pixels;
// //     if (currentScroll == maxScroll) {
// //       pageNumber += 20;
// //       context.read<ArticleFoundBloc>().add(
// //         FetchArticleData(
// //           startPos: pageNumber,
// //           maxPos: Constants.maxResults,
// //           newSearch: false,
// //           filters: filters,
// //         ),
// //       );
// //     }
// //   }
// //
// //   Future<void> _onRefresh() async {
// //     context.read<ArticleFoundBloc>().add(const RefreshList());
// //     await Future.delayed(const Duration(milliseconds: 1200));
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final height = MediaQuery.of(context).size.height;
// //
// //     return BlocConsumer<ArticleFoundBloc, ArticleFoundState>(
// //       listener: (context, state) {},
// //       builder: (context, state) {
// //         log('Write Permission: ${state.extraProperties?.hasWritePermission}');
// //         return Scaffold(
// //           backgroundColor: const Color(0xFF071130),
// //           floatingActionButton: (state.extraProperties?.hasWritePermission ?? false)
// //               ? Container(
// //             decoration: BoxDecoration(
// //               color: Colors.white.withOpacity(0.2),
// //               borderRadius: BorderRadius.circular(50),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.white.withOpacity(0.3),
// //                   blurRadius: 6,
// //                   spreadRadius: 1,
// //                 ),
// //               ],
// //             ),
// //             child: ClipRRect(
// //               borderRadius: BorderRadius.circular(50),
// //               child: BackdropFilter(
// //                 filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// //                 child: Flutterfloatingbutton(
// //                   backgroundColor: Colors.white.withOpacity(0.25),
// //                   foregroundColor: Colors.white,
// //                   onPressed: () {
// //                     Navigator.pushNamed(
// //                       context,
// //                       articleFoundNewDetailsRoute,
// //                       arguments: {"title": Constants.createFound},
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ),
// //           )
// //               : const SizedBox(),
// //           appBar: BaseAppBar().buildAppHeader(
// //             context: context,
// //             title: Constants.foundListTitle,
// //             showPopUp: true,
// //             showSaveButton: false,
// //             showSubmitButton: false,
// //             showDisLikeButton: false,
// //             showLikeButton: false,
// //             excelAPIName: 'exportFoundExcel',
// //             pdfAPIName: 'exportFoundPDF',
// //           ),
// //           body: Container(
// //             decoration: const BoxDecoration(
// //               gradient: LinearGradient(
// //                 colors: [
// //                   Color(0xFF071130),
// //                   Color(0xFF1B2A4A),
// //                   Color(0xFF2C3E66),
// //                 ],
// //                 begin: Alignment.topCenter,
// //                 end: Alignment.bottomCenter,
// //               ),
// //             ),
// //             child: Column(
// //               children: [
// //                 // 🔍 Search Filter Glass Box
// //                 Container(
// //                   margin: const EdgeInsets.all(12),
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(12),
// //                     color: Colors.white.withOpacity(0.2),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.white.withOpacity(0.2),
// //                         blurRadius: 6,
// //                         spreadRadius: 1,
// //                       ),
// //                     ],
// //                   ),
// //                   child: ClipRRect(
// //                     borderRadius: BorderRadius.circular(12),
// //                     child: BackdropFilter(
// //                       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// //                       child: BaseSearchWidget(
// //                         applySearchFilters: applySearchFilters,
// //                         applyFilters: applyFilters,
// //                         commonFilters: state.commonFilters ??
// //                             CommonFilters(
// //                               statuses: [],
// //                               regions: [],
// //                             ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //
// //                 if (state.status == FormStatus.loading) ...[
// //                   CommonWidgets.verticalSpacerWidget(height * 0.01),
// //                   const BaseLoader(),
// //                   CommonWidgets.verticalSpacerWidget(height * 0.01),
// //                 ],
// //                 if (state.items.isEmptyOrNull && state.status != FormStatus.loading) ...[
// //                   CommonWidgets.verticalSpacerWidget(height * 0.1),
// //                   const NoRecordFoundWidget(),
// //                 ],
// //
// //                 // 🧊 Glass List
// //                 Expanded(
// //                   child: CustomMaterialIndicator(
// //                     onRefresh: _onRefresh,
// //                     backgroundColor: Colors.transparent,
// //                     indicatorBuilder: (context, controller) => const Padding(
// //                       padding: EdgeInsets.all(6.0),
// //                       child: BaseLoader(),
// //                     ),
// //                     child: ListView.builder(
// //                       controller: _scrollController,
// //                       itemCount: state.hasReachedMax
// //                           ? state.items.length
// //                           : state.items.length + 1,
// //                       itemBuilder: (context, index) {
// //                         if (index >= state.items.length) {
// //                           return const BaseLoader();
// //                         }
// //
// //                         final item = state.items[index];
// //                         List<Label> labels = [
// //                           Label(
// //                             key: Constants.region,
// //                             value: item.locationRegion?.name ?? '',
// //                           ),
// //                           Label(
// //                             key: Constants.location,
// //                             value: item.location?.name ?? '',
// //                           ),
// //                           Label(
// //                             key: Constants.createdby,
// //                             value:
// //                             '${item.entrySecurity?.firstName ?? ''} ${item.entrySecurity?.lastName ?? ''}',
// //                           ),
// //                           Label(
// //                             key: Constants.founddate,
// //                             value: item.foundDate != null
// //                                 ? Utils.timestampToDateConversion(
// //                                 int.parse(item.foundDate ?? '0'),
// //                                 Constants.twentyFourHourDateTimeFormat)
// //                                 : '',
// //                           ),
// //                         ];
// //
// //                         return Container(
// //                           margin: const EdgeInsets.symmetric(
// //                               horizontal: 12, vertical: 6),
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(16),
// //                             border:
// //                             Border.all(color: Colors.white.withOpacity(0.3)),
// //                             boxShadow: [
// //                               BoxShadow(
// //                                 color: Colors.white.withOpacity(0.1),
// //                                 blurRadius: 8,
// //                                 spreadRadius: 1,
// //                               ),
// //                             ],
// //                           ),
// //                           child: ClipRRect(
// //                             borderRadius: BorderRadius.circular(16),
// //                             child: BackdropFilter(
// //                               filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
// //                               child: Container(
// //                                 padding: const EdgeInsets.all(12),
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.white.withOpacity(0.08),
// //                                   borderRadius: BorderRadius.circular(16),
// //                                 ),
// //                                 child: Row(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     Expanded(
// //                                       child: Column(
// //                                         crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                         children: [
// //                                           Text(
// //                                             'ID:${item.id ?? '-'}',
// //                                             style: const TextStyle(
// //                                               fontWeight: FontWeight.bold,
// //                                               color: Colors.white,
// //                                               fontSize: 13,
// //                                             ),
// //                                           ),
// //                                           const SizedBox(height: 4),
// //                                           // Text(
// //                                           //   'Region: ${item.locationRegion?.name ?? ''}',
// //                                           //   style: const TextStyle(
// //                                           //       color: Colors.white70,
// //                                           //       fontSize: 12),
// //                                           // ),
// //                                           Text(
// //                                             'Location: ${item.location?.name ?? ''}',
// //                                             style: const TextStyle(
// //                                                 color: Colors.white70,
// //                                                 fontSize: 12),
// //                                           ),
// //                                           Text(
// //                                             'CreatedBy: ${item.entrySecurity?.firstName ?? ''}',
// //                                             style: const TextStyle(
// //                                                 color: Colors.white70,
// //                                                 fontSize: 12),
// //                                           ),
// //                                           Text(
// //                                             'Found Date: ${item.foundDate != null ? Utils.timestampToDateConversion(int.parse(item.foundDate ?? '0'), Constants.twentyFourHourDateTimeFormat) : ''}',
// //                                             style: const TextStyle(
// //                                                 color: Colors.white70,
// //                                                 fontSize: 12),
// //                                           ),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                     Column(
// //                                       children: [
// //                                         Text(
// //                                           'Status: ${item.status}',
// //                                           style: const TextStyle(
// //                                             color: Colors.white,
// //                                             fontSize: 12,
// //                                             fontWeight: FontWeight.w500,
// //                                           ),
// //                                         ),
// //                                         const SizedBox(height: 6),
// //                                         Row(
// //                                           children: [
// //                                             IconButton(
// //                                               icon: const Icon(
// //                                                 Icons.edit_outlined,
// //                                                 size: 18,
// //                                                 color: Colors.white70,
// //                                               ),
// //                                               onPressed: () => getById(
// //                                                 state.extraProperties
// //                                                     ?.hasWritePermission ??
// //                                                     false,
// //                                                 item.id ?? 0,
// //                                               ),
// //                                             ),
// //                                             IconButton(
// //                                               icon: const Icon(
// //                                                 Icons.visibility_outlined,
// //                                                 size: 18,
// //                                                 color: Colors.white70,
// //                                               ),
// //                                               onPressed: () {
// //                                                 showDialog(
// //                                                   context: context,
// //                                                   builder: (_) => BasePopUpItems(
// //                                                     id: item.id.toString(),
// //                                                     slNo: item.slNo,
// //                                                     status: item.status,
// //                                                     labels: labels,
// //                                                     isEventProtectionStatus:
// //                                                     false,
// //                                                     isArticleFoundStatus: true,
// //                                                     isMasterGuard: false,
// //                                                   ),
// //                                                 );
// //                                               },
// //                                             ),
// //                                           ],
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// //
// //   getById(bool hasWritePermission, int id) async {
// //     showLoadingDialog(context);
// //     ArticleFoundModel model = await ArticleFoundServices().getById(id);
// //     editDataLoading(model, hasWritePermission);
// //   }
// //
// //   void editDataLoading(ArticleFoundModel? model, bool hasWritePermission) {
// //     dismissLoadingDialog(context);
// //     if (model != null) {
// //       Navigator.pushNamed(
// //         context,
// //         articleFoundNewDetailsRoute,
// //         arguments: {
// //           "model": model,
// //           "title": Constants.editFound,
// //           ConstantsArgument.extraProperties:
// //           ExtraProperties(hasWritePermission: hasWritePermission),
// //         },
// //       );
// //     }
// //   }
// //
// //   void applySearchFilters(FilterCriteria model) {
// //     filters = BaseFilterModel(filterCriteria: model);
// //     BlocProvider.of<ArticleFoundBloc>(context).add(
// //       FetchArticleData(
// //           startPos: 0,
// //           maxPos: Constants.maxResults,
// //           newSearch: true,
// //           filters: filters),
// //     );
// //   }
// //
// //   void applyFilters(Filters model) {
// //     filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
// //     BlocProvider.of<ArticleFoundBloc>(context).add(
// //       FetchArticleData(
// //           startPos: 0,
// //           maxPos: Constants.maxResults,
// //           newSearch: true,
// //           filters: filters),
// //     );
// //     Navigator.pop(context);
// //   }
// // }
//
//
// import 'dart:developer';
// import 'dart:ui';
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/article_found/article_found_list/bloc/article_found_list_bloc.dart';
// import 'package:db_atom/src/features/article_found/models/article_found_model.dart';
// import 'package:db_atom/src/features/article_found/services/article_found_service.dart';
//
// class ArticleFoundNewListView extends StatefulWidget {
//   const ArticleFoundNewListView({super.key});
//
//   @override
//   State<ArticleFoundNewListView> createState() =>
//       _ArticleFoundNewListViewState();
// }
//
// class _ArticleFoundNewListViewState extends State<ArticleFoundNewListView> {
//   late final ScrollController _scrollController;
//   int pageNumber = 0;
//   BaseFilterModel filters = BaseFilterModel();
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<ArticleFoundBloc>().add(const InitializeValuesAF());
//     _scrollController = ScrollController()..addListener(_onScroll);
//   }
//
//   @override
//   void dispose() {
//     _scrollController
//       ..removeListener(_onScroll)
//       ..dispose();
//     super.dispose();
//   }
//
//   void _onScroll() {
//     if (!_scrollController.hasClients) return;
//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final currentScroll = _scrollController.position.pixels;
//     if (currentScroll == maxScroll) {
//       pageNumber = pageNumber + 20;
//       context.read<ArticleFoundBloc>().add(FetchArticleData(
//         startPos: pageNumber,
//         maxPos: Constants.maxResults,
//         newSearch: false,
//         filters: filters,
//       ));
//     }
//   }
//
//   Future<void> _onRefresh() async {
//     context.read<ArticleFoundBloc>().add(const RefreshList());
//     await Future.delayed(const Duration(milliseconds: 2000));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     double height = size.height;
//     final scaffoldKey = GlobalKey<ScaffoldState>();
//
//     return BlocConsumer<ArticleFoundBloc, ArticleFoundState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         log('plus ${state.extraProperties?.hasWritePermission}');
//         return Scaffold(
//           bottomNavigationBar: CustomBottomNavigationBar(
//             scaffoldKey: scaffoldKey,
//             context: context,
//             displayMenu: state.displayMenu,
//             list: true, // 🔥 only "+" button mode
//             onAddPressed: () {
//               Navigator.pushNamed(
//                 context,
//                 articleFoundNewDetailsRoute,
//                 arguments: {"title": Constants.createFound},
//               );
//             },
//           ),
//           backgroundColor: const Color(0xFF071130),
//           // floatingActionButton: (state.extraProperties?.hasWritePermission ?? false)
//           //     ? Container(
//           //   width: 72,
//           //   height: 72,
//           //   decoration: BoxDecoration(
//           //     shape: BoxShape.circle,
//           //     color: Colors.white.withOpacity(0.12),
//           //     boxShadow: [
//           //       BoxShadow(
//           //         color: Colors.white.withOpacity(0.25),
//           //         blurRadius: 20,
//           //         spreadRadius: 1,
//           //         offset: const Offset(0, 4),
//           //       ),
//           //     ],
//           //   ),
//           //   child: ClipOval(
//           //     child: BackdropFilter(
//           //       filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//           //       child: Container(
//           //         decoration: BoxDecoration(
//           //           shape: BoxShape.circle,
//           //           gradient: LinearGradient(
//           //             colors: [
//           //               Colors.white.withOpacity(0.35),
//           //               Colors.white.withOpacity(0.05),
//           //             ],
//           //             begin: Alignment.topLeft,
//           //             end: Alignment.bottomRight,
//           //           ),
//           //         ),
//           //         child: IconButton(
//           //           icon: const Icon(Icons.add, color: Colors.white, size: 35),
//           //           onPressed: () {
//           //             Navigator.pushNamed(context, articleFoundNewDetailsRoute,
//           //                 arguments: {"title": Constants.createFound});
//           //           },
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // )
//           //   ?CustomBottomNavigationBar(
//           //   scaffoldKey: scaffoldKey,
//           //   context: context,
//           //   displayMenu: state.displayMenu!,
//           // )
//           //     : const SizedBox(),
//           appBar: BaseAppBar().buildAppHeader(
//             context: context,
//             title: Constants.foundListTitle,
//             showPopUp: true,
//             showSaveButton: false,
//             showSubmitButton: false,
//             showDisLikeButton: false,
//             showLikeButton: false,
//             excelAPIName: 'exportFoundExcel',
//             pdfAPIName: 'exportFoundPDF',
//           ),
//           // body: Container(
//           //
//           //     width: double.infinity,
//           //     height: double.infinity,
//           //     child: Image.asset(
//           //       'assets/images/login4.png',
//           //       fit: BoxFit.fitHeight,
//           //       width: double.infinity,
//           //     )
//           //
//           //   // decoration: const BoxDecoration(
//           //   //   gradient: LinearGradient(
//           //   //     colors: [
//           //   //       Color(0xFF071130),
//           //   //       Color(0xFF071130),
//           //   //       Color(0xFF071130),
//           //   //       // Color(0xFF1B2A4A),
//           //   //       // Color(0xFF2C3E66),
//           //   //     ],
//           //   //     begin: Alignment.topCenter,
//           //   //     end: Alignment.bottomCenter,
//           //   //   ),
//           //   // ),
//           //   child: Column(
//           //     children: [
//           //       // 🔍 Search bar glass style
//           //       // Container(
//           //       //   margin: const EdgeInsets.all(12),
//           //       //   decoration: BoxDecoration(
//           //       //     borderRadius: BorderRadius.circular(12),
//           //       //     color: Colors.white,
//           //       //     boxShadow: [
//           //       //       BoxShadow(
//           //       //         color: Colors.white.withOpacity(0.2),
//           //       //         blurRadius: 8,
//           //       //         spreadRadius: 1,
//           //       //       ),//       //     ],
//           //       //   ),
//           //
//           //     BaseSearchWidget(
//           //         applySearchFilters: applySearchFilters,
//           //         applyFilters: applyFilters,
//           //         commonFilters: state.commonFilters ??
//           //             CommonFilters(statuses: [], regions: []),
//           //       ),
//           //      // ClipRRect(
//           //      //      borderRadius: BorderRadius.circular(12),
//           //      //      child: BackdropFilter(
//           //      //        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           //      //        child: BaseSearchWidget(
//           //      //          applySearchFilters: applySearchFilters,
//           //      //          applyFilters: applyFilters,
//           //      //          commonFilters: state.commonFilters ??
//           //      //              CommonFilters(statuses: [], regions: []),
//           //      //        ),
//           //      //      ),
//           //      //    // ),
//           //
//           //       if (state.status == FormStatus.loading) ...[
//           //         CommonWidgets.verticalSpacerWidget(height * 0.01),
//           //         const BaseLoader(),
//           //         CommonWidgets.verticalSpacerWidget(height * 0.01),
//           //       ],
//           //       if (state.items.isEmptyOrNull &&
//           //           state.status != FormStatus.loading) ...[
//           //         CommonWidgets.verticalSpacerWidget(height * 0.1),
//           //         const NoRecordFoundWidget(),
//           //       ],
//           //
//           //       // 🧊 Glassmorphism List
//           //       Expanded(
//           //         child: CustomMaterialIndicator(
//           //           onRefresh: _onRefresh,
//           //           backgroundColor: Colors.transparent,
//           //           indicatorBuilder: (context, controller) {
//           //             return const Padding(
//           //               padding: EdgeInsets.all(6.0),
//           //               child: BaseLoader(),
//           //             );
//           //           },
//           //           child: ListView.builder(
//           //             controller: _scrollController,
//           //             itemCount: state.hasReachedMax
//           //                 ? state.items.length
//           //                 : state.items.length + 1,
//           //             itemBuilder: (context, index) {
//           //               if (index >= state.items.length) {
//           //                 return const BaseLoader();
//           //               }
//           //
//           //               final item = state.items[index];
//           //               List<Label> labels = [
//           //                 Label(
//           //                   key: Constants.dateofcreation,
//           //                   value: item.inputDate != null
//           //                       ? Utils.timestampToDateConversion(
//           //                       int.parse(item.inputDate ?? '0'),
//           //                       Constants.twentyFourHourDateTimeFormat)
//           //                       : '',
//           //                 ),
//           //                 Label(
//           //                   key: Constants.founddate,
//           //                   value: item.foundDate != null
//           //                       ? Utils.timestampToDateConversion(
//           //                       int.parse(item.foundDate ?? '0'),
//           //                       Constants.twentyFourHourDateTimeFormat)
//           //                       : '',
//           //                 ),
//           //                 Label(
//           //                     key: Constants.region,
//           //                     value: item.locationRegion?.name ?? ''),
//           //                 Label(
//           //                     key: Constants.location,
//           //                     value: item.location?.name ?? ''),
//           //                 Label(
//           //                   key: Constants.createdby,
//           //                   value:
//           //                   '${item.entrySecurity?.firstName ?? ''} ${item.entrySecurity?.lastName ?? ''}',
//           //                 ),
//           //               ];
//           //
//           //               // 🧊 Each card with glassmorphism + BaseListTileItem inside
//           //               return Container(
//           //                 margin: const EdgeInsets.symmetric(
//           //                     horizontal: 12, vertical: 8),
//           //                 decoration: BoxDecoration(
//           //                   borderRadius: BorderRadius.circular(18),
//           //                   border:
//           //                   Border.all(color: Colors.white.withOpacity(0.3)),
//           //                   boxShadow: [
//           //                     BoxShadow(
//           //                       color: Colors.white.withOpacity(0.1),
//           //                       blurRadius: 12,
//           //                       spreadRadius: 1,
//           //                     ),
//           //                   ],
//           //                 ),
//           //                 child: ClipRRect(
//           //                   borderRadius: BorderRadius.circular(18),
//           //                   child: BackdropFilter(
//           //                     filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//           //                     child: Container(
//           //                       decoration: BoxDecoration(
//           //                         color: Colors.transparent,
//           //                         borderRadius: BorderRadius.circular(18),
//           //                       ),
//           //                       child: BaseListTileItem(
//           //                         id: item.id,
//           //                         status: item.status,
//           //                         labels: labels,
//           //                         isArticleFoundStatus: true,
//           //                         isEventProtectionStatus: false,
//           //                         onTap: (selectedIndex) {
//           //                           showDialog(
//           //                             context: context,
//           //                             builder: (_) => BasePopUpItems(
//           //                               id: item.id.toString(),
//           //                               status: item.status,
//           //                               slNo: item.slNo,
//           //                               labels: labels,
//           //                               isEventProtectionStatus: false,
//           //                               isArticleFoundStatus: true,
//           //                               isMasterGuard: false,
//           //                             ),
//           //                           );
//           //                         },
//           //                         onEditTap: (selectedIndex) {
//           //                           getById(
//           //                             state.extraProperties
//           //                                 ?.hasWritePermission ??
//           //                                 false,
//           //                             item.id ?? 0,
//           //                           );
//           //                         },
//           //                         showEditButton: item.status ==
//           //                             ConstantsIntValue
//           //                                 .articleFoundStatusFound ||
//           //                             item.status ==
//           //                                 ConstantsIntValue
//           //                                     .articleFoundStatusUnderSecurityCustody,
//           //                         onViewTap: (selectedIndex) {
//           //                           showDialog(
//           //                             context: context,
//           //                             builder: (_) => BasePopUpItems(
//           //                               id: item.id.toString(),
//           //                               slNo: item.slNo,
//           //                               status: item.status,
//           //                               labels: labels,
//           //                               isEventProtectionStatus: false,
//           //                               isArticleFoundStatus: true,
//           //                               isMasterGuard: false,
//           //                             ),
//           //                           );
//           //                         },
//           //                         index: index,
//           //                       ),
//           //                     ),
//           //                   ),
//           //                 ),
//           //               );
//           //             },
//           //           ),
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//           // ),
//           body: Stack(
//             children: [
//               // 🌌 Background image
//               // Positioned.fill(
//               //   child: Image.asset(
//               //     'assets/images/bc.png',
//               //     fit: BoxFit.cover,
//               //   ),
//               // ),
//
//               // 🌫️ Foreground content (blur + list)
//               Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 color: const Color(0xFF6474C6),
//                 // optional overlay tint
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 10),
//                     BaseSearchWidget(
//                       applySearchFilters: applySearchFilters,
//                       applyFilters: applyFilters,
//                       commonFilters: state.commonFilters ??
//                           CommonFilters(statuses: [], regions: []),
//                     ),
//
//                     // if (state.status == FormStatus.loading) ...[
//                     //   CommonWidgets.verticalSpacerWidget(height * 0.01),
//                     //   const BaseLoader(),
//                     //   CommonWidgets.verticalSpacerWidget(height * 0.01),
//                     // ],
//                     if (state.items.isEmptyOrNull &&
//                         state.status != FormStatus.loading) ...[
//                       CommonWidgets.verticalSpacerWidget(height * 0.1),
//                       const NoRecordFoundWidget(),
//                     ],
//
//                     // 🧊 Glassmorphism List
//                     Expanded(
//                       child: CustomMaterialIndicator(
//                         onRefresh: _onRefresh,
//                         backgroundColor: Colors.transparent,
//                         indicatorBuilder: (context, controller) {
//                           return const Padding(
//                             padding: EdgeInsets.all(6.0),
//                             child: BaseLoader(),
//                           );
//                         },
//                         child: ListView.builder(
//                           controller: _scrollController,
//                           itemCount: state.hasReachedMax
//                               ? state.items.length
//                               : state.items.length + 1,
//                           itemBuilder: (context, index) {
//                             if (index >= state.items.length) {
//                               return const BaseLoader();
//                             }
//
//                             final item = state.items[index];
//                             List<Label> labels = [
//                               Label(
//                                 key: Constants.dateofcreation,
//                                 value: item.inputDate != null
//                                     ? Utils.timestampToDateConversion(
//                                     int.parse(item.inputDate ?? '0'),
//                                     Constants.twentyFourHourDateTimeFormat)
//                                     : '',
//                               ),
//                               Label(
//                                 key: Constants.founddate,
//                                 value: item.foundDate != null
//                                     ? Utils.timestampToDateConversion(
//                                     int.parse(item.foundDate ?? '0'),
//                                     Constants.twentyFourHourDateTimeFormat)
//                                     : '',
//                               ),
//                               Label(
//                                   key: Constants.region,
//                                   value: item.locationRegion?.name ?? ''),
//                               Label(
//                                   key: Constants.location,
//                                   value: item.location?.name ?? ''),
//                               Label(
//                                 key: Constants.createdby,
//                                 value:
//                                 '${item.entrySecurity?.firstName ?? ''} ${item.entrySecurity?.lastName ?? ''}',
//                               ),
//                             ];
//
//                             return Container(
//                               margin:
//                               const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(18),
//                                 border: Border.all(color: Colors.white.withOpacity(0.5)),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.white.withOpacity(0.1),
//                                     blurRadius: 12,
//                                     spreadRadius: 7,
//                                   ),
//                                 ],
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(18),
//                                 child: BackdropFilter(
//                                   filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//                                   child: Container(
//                                     color: Colors.white.withOpacity(0.05),
//                                     child: BaseListTileItem(
//                                       id: item.id,
//                                       labels: labels,
//                                       status: item.status,
//                                       isArticleFoundStatus: true,
//                                       isEventProtectionStatus: false,
//                                       onTap: (selectedIndex) {
//                                         showDialog(
//                                           context: context,
//                                           builder: (_) => BasePopUpItems(
//                                             id: item.id.toString(),
//                                             status: item.status,
//                                             slNo: item.slNo,
//                                             labels: labels,
//                                             isEventProtectionStatus: false,
//                                             isArticleFoundStatus: true,
//                                             isMasterGuard: false,
//                                           ),
//                                         );
//                                       },
//                                       onEditTap: (selectedIndex) {
//                                         getById(
//                                           state.extraProperties?.hasWritePermission ??
//                                               false,
//                                           item.id ?? 0,
//                                         );
//                                       },
//                                       showEditButton: item.status ==
//                                           ConstantsIntValue.articleFoundStatusFound ||
//                                           item.status ==
//                                               ConstantsIntValue
//                                                   .articleFoundStatusUnderSecurityCustody,
//                                       onViewTap: (selectedIndex) {
//                                         showDialog(
//                                           context: context,
//                                           builder: (_) => BasePopUpItems(
//                                             id: item.id.toString(),
//                                             slNo: item.slNo,
//                                             status: item.status,
//                                             labels: labels,
//                                             isEventProtectionStatus: false,
//                                             isArticleFoundStatus: true,
//                                             isMasterGuard: false,
//                                           ),
//                                         );
//                                       },
//                                       index: index,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//
//         );
//       },
//     );
//   }
//
//   getById(bool hasWritePermission, int id) async {
//     showLoadingDialog(context);
//     ArticleFoundModel model = await ArticleFoundServices().getById(id);
//     editDataLoading(model, hasWritePermission);
//   }
//
//   void editDataLoading(ArticleFoundModel? model, bool hasWritePermission) {
//     dismissLoadingDialog(context);
//     if (model != null) {
//       Navigator.pushNamed(context, articleFoundNewDetailsRoute, arguments: {
//         "model": model,
//         "title": Constants.editFound,
//         ConstantsArgument.extraProperties:
//         ExtraProperties(hasWritePermission: hasWritePermission),
//       });
//     }
//   }
//
//   void applySearchFilters(FilterCriteria model) {
//     filters = BaseFilterModel(filterCriteria: model);
//     BlocProvider.of<ArticleFoundBloc>(context).add(FetchArticleData(
//         startPos: 0,
//         maxPos: Constants.maxResults,
//         newSearch: true,
//         filters: filters));
//   }
//
//   void applyFilters(Filters model) {
//     filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
//     BlocProvider.of<ArticleFoundBloc>(context).add(FetchArticleData(
//         startPos: 0,
//         maxPos: Constants.maxResults,
//         newSearch: true,
//         filters: filters));
//     Navigator.pop(context);
//   }
// }
//
//
//
// // import 'dart:ui';
// // import 'package:flutter/material.dart';
//
// class GlassBottomNavExample extends StatefulWidget {
//   const GlassBottomNavExample({super.key});
//
//   @override
//   State<GlassBottomNavExample> createState() => _GlassBottomNavExampleState();
// }
//
// class _GlassBottomNavExampleState extends State<GlassBottomNavExample> {
//   int _selectedIndex = 0;
//
//   final List<IconData> icons = [
//     Icons.home_rounded,
//     Icons.search_rounded,
//     Icons.notifications_rounded,
//     Icons.person_rounded,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF071130),
//       extendBody: true, // to allow FAB overlap
//
//       // 🟣 Floating Action Button (centered circular)
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Container(
//         width: 68,
//         height: 68,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white.withOpacity(0.12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.white.withOpacity(0.25),
//               blurRadius: 20,
//               spreadRadius: 1,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: ClipOval(
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//             child: Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.white.withOpacity(0.3),
//                     Colors.white.withOpacity(0.1),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: IconButton(
//                 icon: const Icon(Icons.add, color: Colors.white, size: 32),
//                 onPressed: () {
//                   // FAB tap action
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       // 🧭 Bottom Navigation Bar
//       bottomNavigationBar: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           // curved background with notch
//           CustomPaint(
//             size: const Size(double.infinity, 90),
//             painter: _NavBarPainter(
//               backgroundColor: const Color(0xFF0A163F),
//             ),
//           ),
//
//           // icons row
//           SizedBox(
//             height: 90,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: List.generate(icons.length, (index) {
//                 return IconButton(
//                   onPressed: () => setState(() => _selectedIndex = index),
//                   icon: Icon(
//                     icons[index],
//                     color: _selectedIndex == index
//                         ? Colors.white
//                         : Colors.white.withOpacity(0.5),
//                     size: 28,
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//
//       body: const Center(
//         child: Text(
//           'Found List Screen',
//           style: TextStyle(color: Colors.white, fontSize: 22),
//         ),
//       ),
//     );
//   }
// }
//
// // 🎨 Custom curved background for bottom nav
// class _NavBarPainter extends CustomPainter {
//   final Color backgroundColor;
//   _NavBarPainter({required this.backgroundColor});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = backgroundColor
//       ..style = PaintingStyle.fill
//       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
//
//     final path = Path();
//     path.moveTo(0, 0);
//     path.lineTo(size.width * 0.35, 0);
//     path.quadraticBezierTo(
//         size.width * 0.5, 50, size.width * 0.65, 0); // notch curve
//     path.lineTo(size.width, 0);
//     path.lineTo(size.width, 90);
//     path.lineTo(0, 90);
//     path.close();
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

import 'dart:developer';
import 'dart:ui';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found/article_found_list/bloc/article_found_list_bloc.dart';
import 'package:db_atom/src/features/article_found/models/article_found_model.dart';
import 'package:db_atom/src/features/article_found/services/article_found_service.dart';

class ArticleFoundNewListView extends StatefulWidget {
  const ArticleFoundNewListView({super.key});

  @override
  State<ArticleFoundNewListView> createState() =>
      _ArticleFoundNewListViewState();
}

class _ArticleFoundNewListViewState extends State<ArticleFoundNewListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<ArticleFoundBloc>().add(const InitializeValuesAF());
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
      context.read<ArticleFoundBloc>().add(FetchArticleData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<ArticleFoundBloc>().add(const RefreshList());
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocConsumer<ArticleFoundBloc, ArticleFoundState>(
      listener: (context, state) {},
      builder: (context, state) {
        log('plus ${state.extraProperties?.hasWritePermission}');
        return Scaffold(
          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: true,
            scaffoldKey: scaffoldKey,
            context: context,
            displayMenu: state.displayMenu,
            list: true, // 🔥 only "+" button mode
            onAddPressed: () {
              Navigator.pushNamed(
                context,
                articleFoundNewDetailsRoute,
                arguments: {"title": Constants.createFound},
              );
            },
          ),
          // backgroundColor: const Color(0xFF071130),
          backgroundColor: AppColors.lavender,
          // backgroundColor: Colors.transparent,
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.foundListTitle,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName: 'exportFoundExcel',
            pdfAPIName: 'exportFoundPDF',
          ),
          body: Stack(
            children: [
              // 🌌 Background image
              // Positioned.fill(
              //   child: Image.asset(
              //     'assets/images/bc.png',
              //     fit: BoxFit.cover,
              //   ),
              // ),

              // 🌫️ Foreground content (blur + list)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0xFF6474C6),
                // optional overlay tint
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    BaseSearchWidget(
                      applySearchFilters: applySearchFilters,
                      applyFilters: applyFilters,
                      commonFilters: state.commonFilters ??
                          CommonFilters(statuses: [], regions: []),
                    ),

                    // if (state.status == FormStatus.loading) ...[
                    //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                    //   const BaseLoader(),
                    //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                    // ],
                    if (state.items.isEmptyOrNull &&
                        state.status != FormStatus.loading) ...[
                      CommonWidgets.verticalSpacerWidget(height * 0.1),
                      const NoRecordFoundWidget(),
                    ],

                    // 🧊 Glassmorphism List
                    Expanded(
                      child: CustomMaterialIndicator(
                        onRefresh: _onRefresh,
                        backgroundColor: Colors.transparent,
                        indicatorBuilder: (context, controller) {
                          return const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: BaseLoader(),
                          );
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: state.hasReachedMax
                              ? state.items.length
                              : state.items.length + 1,
                          itemBuilder: (context, index) {
                            if (index >= state.items.length) {
                              return const BaseLoader();
                            }

                            final item = state.items[index];
                            List<Label> labels = [
                              Label(
                                key: Constants.dateofcreation,
                                value: item.inputDate != null
                                    ? Utils.timestampToDateConversion(
                                        int.parse(item.inputDate ?? '0'),
                                        Constants.twentyFourHourDateTimeFormat)
                                    : '',
                              ),
                              Label(
                                key: Constants.founddate,
                                value: item.foundDate != null
                                    ? Utils.timestampToDateConversion(
                                        int.parse(item.foundDate ?? '0'),
                                        Constants.twentyFourHourDateTimeFormat)
                                    : '',
                              ),
                              Label(
                                  key: Constants.region,
                                  value: item.locationRegion?.name ?? ''),
                              Label(
                                  key: Constants.location,
                                  value: item.location?.name ?? ''),
                              Label(
                                key: Constants.createdby,
                                value:
                                    '${item.entrySecurity?.firstName ?? ''} ${item.entrySecurity?.lastName ?? ''}',
                              ),
                            ];

//                             return Container(
//                               margin:
//                               const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                               // decoration: BoxDecoration(
//                               //   borderRadius: BorderRadius.circular(18),
//                               //   border: Border.all(color: Colors.white.withOpacity(0.5)),
//                               //   boxShadow: [
//                               //     BoxShadow(
//                               //       color: Colors.white.withOpacity(0.1),
//                               //       blurRadius: 12,
//                               //       spreadRadius: 7,
//                               //     ),
//                               //   ],
//                               // ),
// //                               decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.circular(20),
// //                                 border: Border.all(
// //                                   color: Colors.white.withValues(alpha: 1.5),
// //                                   width: 1.5,
// //                                 ),
// //                                 gradient: LinearGradient(
// //                                   colors: [
// //                                     // const Color(0xFF6474C6).withValues(alpha: 0), // lavender-blue
// //
// //                                     Colors.white.withValues(alpha: 0), // subtle white glow
// //                                     const Color(0xFF6474C6).withValues(alpha: 0), // lavender-blue
// //                                     const Color(0xFFD6D6FF)
// //                                         .withValues(alpha: 0), // soft white-purple
// //                                     Colors.white.withValues(alpha: 0.8),
// //                                     // const Color(0xFF6474C6).withValues(alpha: 0), // lavender-blue
// //                                     // const Color(0xFF6474C6).withValues(alpha: 0), // lavender-blue
// // // white edge tint
// //                                   ],
// //                                   stops: const [0.0, 0.3, 0.7, 3],
// //                                   begin: Alignment.topLeft,
// //                                   end: Alignment.bottomRight,
// //                                 ),
// //                                 boxShadow: [
// //                                   BoxShadow(
// //                                     color: Colors.white.withValues(alpha: 0.0),
// //                                     blurRadius: 10,
// //                                     offset: const Offset(-3, -3), // white glow on top-left
// //                                   ),
// //                                   BoxShadow(
// //                                     color: AppColors.lavender.withValues(alpha: 2),
// //                                     blurRadius: 10,
// //                                     offset: const Offset(3, 3), // soft shadow bottom-right
// //                                   ),
// //                                 ],
// //                               ),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                   color: Colors.white.withValues(alpha: 1.5),
//                                   width: 1.5,
//                                 ),
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Colors.white.withValues(alpha: 0),
//                                     const Color(0xFF6474C6).withValues(alpha: 0),
//                                     const Color(0xFFD6D6FF).withValues(alpha: 0),
//                                     Colors.white.withValues(alpha: 0.5),
//                                   ],
//                                   stops: const [0.0, 0.3, 0.7, 1.0],
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                 ),
//                                 boxShadow: [
//                                   // existing soft dual shadows
//                                   BoxShadow(
//                                     color: Colors.white.withValues(alpha: 0.0),
//                                     blurRadius: 10,
//                                     offset: const Offset(-3, -3),
//                                   ),
//                                   BoxShadow(
//                                     color: AppColors.lavender.withValues(alpha: 2),
//                                     blurRadius: 10,
//                                     offset: const Offset(3, 3),
//                                   ),
//
//                                 ],
//                               ),
//
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(18),
//                                 child: BackdropFilter(
//                                   filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//                                   child: Container(
//                                     color: Colors.white.withOpacity(0.15),
//                                     child: BaseListTileItem(
//                                       id: item.id,
//                                       labels: labels,
//                                       status: item.status,
//                                       isArticleFoundStatus: true,
//                                       isEventProtectionStatus: false,
//                                       onTap: (selectedIndex) {
//                                         showDialog(
//                                           context: context,
//                                           builder: (_) => BasePopUpItems(
//                                             id: item.id.toString(),
//                                             status: item.status,
//                                             slNo: item.slNo,
//                                             labels: labels,
//                                             isEventProtectionStatus: false,
//                                             isArticleFoundStatus: true,
//                                             isMasterGuard: false,
//                                           ),
//                                         );
//                                       },
//                                       onEditTap: (selectedIndex) {
//                                         getById(
//                                           state.extraProperties?.hasWritePermission ??
//                                               false,
//                                           item.id ?? 0,
//                                         );
//                                       },
//                                       showEditButton: item.status ==
//                                           ConstantsIntValue.articleFoundStatusFound ||
//                                           item.status ==
//                                               ConstantsIntValue
//                                                   .articleFoundStatusUnderSecurityCustody,
//                                       onViewTap: (selectedIndex) {
//                                         showDialog(
//                                           context: context,
//                                           builder: (_) => BasePopUpItems(
//                                             id: item.id.toString(),
//                                             slNo: item.slNo,
//                                             status: item.status,
//                                             labels: labels,
//                                             isEventProtectionStatus: false,
//                                             isArticleFoundStatus: true,
//                                             isMasterGuard: false,
//                                           ),
//                                         );
//                                       },
//                                       index: index,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
                            return index >= state.items.length
                                ? const BaseLoader()
                                : Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF6474C6),
                                    Color(0xFF6474C6)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(20),
                              //   border: Border.all(
                              //     color:  Colors.white.withValues(alpha: 0.5), // soft pink border
                              //     width: 1.5,
                              //   ),
                              //   gradient: LinearGradient(
                              //     begin: Alignment.topLeft,
                              //     end: Alignment.bottomRight,
                              //     colors: [
                              //       const Color(0xFF6474C6).withValues(alpha: 0),
                              //       // const Color(0xFF6474C6).withValues(alpha: 0),
                              //       // const Color(0xFFD6D6FF).withValues(alpha: 0),
                              //       Colors.white.withValues(alpha: 0),
                              //       Colors.white.withValues(alpha: 0.5),// deep purple bottom-right
                              //     ],
                              //     stops: const [0.1, 0.9, 8.0],
                              //   ),
                              //   boxShadow: [
                              //     // soft glow around edges
                              //     BoxShadow(
                              //       color: const Color(0xFF6474C6).withOpacity(0.4),
                              //       blurRadius: 25,
                              //       spreadRadius: 2,
                              //       offset: const Offset(6, 6),
                              //     ),
                              //     BoxShadow(
                              //       color: Colors.white.withOpacity(0.15),
                              //       blurRadius: 20,
                              //       offset: const Offset(-6, -6),
                              //     ),
                              //   ],
                              // ),
                              // decoration: BoxDecoration(
                              //   gradient: LinearGradient(
                              //     colors: [
                              //       Color(0xFF6474C6).withOpacity(0.18),
                              //       Colors.transparent,
                              //       Color(0xFF6474C6).withOpacity(0.14)
                              //     ],
                              //     stops: [0.02, 0.35, 1],
                              //     begin: Alignment.topCenter,
                              //     end: Alignment.bottomCenter,
                              //   ),
                              //   borderRadius: BorderRadius.circular(27),
                              //   border: Border.all(
                              //     color: Colors.white.withOpacity(0.90),
                              //     width: 0.8,
                              //   ),
                              //   boxShadow: [
                              //     BoxShadow(
                              //       color: Color(0xFF6474C6).withOpacity(0.9),
                              //       blurRadius: 30,
                              //       offset: Offset(0, 2),
                              //     ),
                              //   ],
                              // ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                                  child: Container(
                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(18),
                                    //   gradient: LinearGradient(
                                    //     begin: Alignment.topLeft,
                                    //     end: Alignment.bottomRight,
                                    //     colors: [
                                    //       // Colors.white.withOpacity(0.1),
                                    //       const Color(0xFF6474C6).withValues(alpha: 0),
                                    //       // const Color(0xFFFFB6C1).withOpacity(0.15),
                                    //       const Color(0xFF6474C6).withOpacity(0.1),
                                    //       Colors.white.withOpacity(0.1)
                                    //     ],
                                    //   ),
                                    // ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.white.withValues(alpha: 0.2),
                                          Colors.transparent,
                                          Colors.white.withValues(alpha: 0.2),
                                          // Color(0xFF6474C6).withOpacity(0.14)
                                        ],
                                        stops: [0.02, 0.35, 1],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      borderRadius: BorderRadius.circular(27),
                                      border: Border.all(
                                        color: Colors.white
                                            .withValues(alpha: 0.80),
                                        width: 0.8,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF6474C6)
                                              .withValues(alpha: 0.09),
                                          blurRadius: 12,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: BaseListTileItem(
                                      id: item.id,
                                      labels: labels,
                                      status: item.status,
                                      isArticleFoundStatus: true,
                                      isEventProtectionStatus: false,
                                      onTap: (selectedIndex) {
                                        showDialog(
                                          context: context,
                                          builder: (_) => BasePopUpItems(
                                            id: item.id.toString(),
                                            status: item.status,
                                            slNo: item.slNo,
                                            labels: labels,
                                            isEventProtectionStatus: false,
                                            isArticleFoundStatus: true,
                                            isMasterGuard: false,
                                          ),
                                        );
                                      },
                                      onEditTap: (selectedIndex) {
                                        getById(
                                          state.extraProperties
                                                  ?.hasWritePermission ??
                                              false,
                                          item.id ?? 0,
                                        );
                                      },
                                      showEditButton: item.status ==
                                              ConstantsIntValue
                                                  .articleFoundStatusFound ||
                                          item.status ==
                                              ConstantsIntValue
                                                  .articleFoundStatusUnderSecurityCustody,
                                      onViewTap: (selectedIndex) {
                                        showDialog(
                                          context: context,
                                          builder: (_) => BasePopUpItems(
                                            id: item.id.toString(),
                                            slNo: item.slNo,
                                            status: item.status,
                                            labels: labels,
                                            isEventProtectionStatus: false,
                                            isArticleFoundStatus: true,
                                            isMasterGuard: false,
                                          ),
                                        );
                                      },
                                      index: index,
                                    ),
                                  ),
                                ),
                              ),
                            );
//
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);
    ArticleFoundModel model = await ArticleFoundServices().getById(id);
    editDataLoading(model, hasWritePermission);
  }

  void editDataLoading(ArticleFoundModel? model, bool hasWritePermission) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(context, articleFoundNewDetailsRoute, arguments: {
        "model": model,
        "title": Constants.editFound,
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      });
    }
  }

  void applySearchFilters(FilterCriteria model) {
    filters = BaseFilterModel(filterCriteria: model);
    BlocProvider.of<ArticleFoundBloc>(context).add(FetchArticleData(
        startPos: 0,
        maxPos: Constants.maxResults,
        newSearch: true,
        filters: filters));
  }

  void applyFilters(Filters model) {
    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
    BlocProvider.of<ArticleFoundBloc>(context).add(FetchArticleData(
        startPos: 0,
        maxPos: Constants.maxResults,
        newSearch: true,
        filters: filters));
    Navigator.pop(context);
  }
}

// import 'dart:ui';
// import 'package:flutter/material.dart';

class GlassBottomNavExample extends StatefulWidget {
  const GlassBottomNavExample({super.key});

  @override
  State<GlassBottomNavExample> createState() => _GlassBottomNavExampleState();
}

class _GlassBottomNavExampleState extends State<GlassBottomNavExample> {
  int _selectedIndex = 0;

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.search_rounded,
    Icons.notifications_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF071130),
      extendBody: true, // to allow FAB overlap

      // 🟣 Floating Action Button (centered circular)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.12),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.25),
              blurRadius: 20,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.3),
                    Colors.white.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white, size: 32),
                onPressed: () {
                  // FAB tap action
                },
              ),
            ),
          ),
        ),
      ),

      // 🧭 Bottom Navigation Bar
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // curved background with notch
          CustomPaint(
            size: const Size(double.infinity, 90),
            painter: _NavBarPainter(
              backgroundColor: const Color(0xFF0A163F),
            ),
          ),

          // icons row
          SizedBox(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(icons.length, (index) {
                return IconButton(
                  onPressed: () => setState(() => _selectedIndex = index),
                  icon: Icon(
                    icons[index],
                    color: _selectedIndex == index
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.5),
                    size: 28,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// 🎨 Custom curved background for bottom nav
class _NavBarPainter extends CustomPainter {
  final Color backgroundColor;
  _NavBarPainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.35, 0);
    path.quadraticBezierTo(
        size.width * 0.5, 50, size.width * 0.65, 0); // notch curve
    path.lineTo(size.width, 0);
    path.lineTo(size.width, 90);
    path.lineTo(0, 90);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
