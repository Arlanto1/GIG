// // import 'dart:developer';
// //
// // import 'package:db_atom/index.dart';
// // import 'package:db_atom/src/common_widgets/base_widget/base_filter/cubit/base_filter_cubit.dart';
// //
// // class BaseSearchWidget extends StatefulWidget {
// //   final Function(FilterCriteria) applySearchFilters;
// //   final Function(Filters) applyFilters;
// //   final CommonFilters commonFilters;
// //
// //   const BaseSearchWidget({
// //     super.key,
// //     required this.applySearchFilters,
// //     required this.applyFilters,
// //     required this.commonFilters,
// //   });
// //
// //   @override
// //   BaseSearchWidgetState createState() => BaseSearchWidgetState();
// // }
// //
// // class BaseSearchWidgetState extends State<BaseSearchWidget> {
// //   TextEditingController searchController = TextEditingController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final width = MediaQuery.of(context).size.width;
// //
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 8.0),
// //       child: Center( // 👈 centers the row horizontally
// //         child: SizedBox(
// //           width: width * 0.95, // 👈 reduce width (e.g. 85% of screen)
// //           child: Row(
// //             children: [
// //               Expanded(
// //                 child: Container(
// //                   height: 45,
// //                   decoration: BoxDecoration(
// //                     gradient: const LinearGradient(
// //                       begin: Alignment.topLeft,
// //                       end: Alignment.bottomRight,
// //                       colors: [
// //                         // Color(0xFF2C3E7E),
// //                         // Color(0xFF101D45),
// //                         // Color(0xFF101D45),
// //                         Colors.white,
// //                         Colors.white,
// //                         // Color(0xFF101D45),
// //
// //                         // Colors.white,
// //                         // Colors.white,
// //                       ],
// //                     ),
// //                     borderRadius: BorderRadius.circular(16),
// //                     border: Border.all(
// //                       color: Colors.black.withOpacity(0.7),
// //                       width: 1,
// //                     ),
// //                     boxShadow: [
// //                       // Outer glow
// //                       BoxShadow(
// //                         color: const Color(0xFF7DA2FF).withOpacity(0),
// //                         blurRadius: 2,
// //                         spreadRadius: 0,
// //                       ),
// //                     ],
// //                   ),
// //                   child: TextField(
// //                     controller: searchController,
// //                     style: const TextStyle(color: Colors.black),
// //                     decoration: InputDecoration(
// //                       hintText: 'Search...',
// //                       hintStyle:
// //                       TextStyle(color: Colors.black.withOpacity(0.7)),
// //                       contentPadding: const EdgeInsets.symmetric(
// //                           horizontal: 16, vertical: 10),
// //                       suffixIcon: InkWell(
// //                         onTap: () {
// //                           FilterCriteria filterCriteriaModel = FilterCriteria();
// //                           filterCriteriaModel.all = searchController.text;
// //                           widget.applySearchFilters(filterCriteriaModel);
// //                         },
// //                         child: Container(
// //                           margin: const EdgeInsets.all(6),
// //                           decoration: BoxDecoration(
// //                             color: Colors.white.withOpacity(0.1),
// //                             borderRadius: BorderRadius.circular(10),
// //                           ),
// //                           child: const Icon(
// //                             Icons.search,
// //                             color: Colors.black,
// //                             size: 22,
// //                           ),
// //                         ),
// //                       ),
// //                       border: InputBorder.none,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(width: 8),
// //               ShowFiltersWidget(
// //                 applyFilters: widget.applyFilters,
// //                 commonFilters: widget.commonFilters,
// //                 clearSearchController: () {
// //                   searchController.clear();
// //                 },
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class ShowFiltersWidget extends StatelessWidget {
// //   final Function(Filters) applyFilters;
// //   final CommonFilters commonFilters;
// //   final VoidCallback clearSearchController;
// //
// //   const ShowFiltersWidget({
// //     super.key,
// //     required this.applyFilters,
// //     required this.clearSearchController,
// //     required this.commonFilters,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       margin: const EdgeInsets.only(right: 1),
// //       decoration: BoxDecoration(
// //         gradient: const LinearGradient(
// //           begin: Alignment.topLeft,
// //           end: Alignment.bottomRight,
// //           colors: [
// //             Color(0xFF2C3E7E),
// //             Color(0xFF101D45),
// //             // Colors.white,
// //             // Colors.white,
// //             // Color(0xFF101D45),
// //           ],
// //         ),
// //         color:  Colors.white,
// //         borderRadius: BorderRadius.circular(14),
// //         border: Border.all(
// //           color: Colors.white.withOpacity(0.5),
// //           width: 1.3,
// //         ),
// //         boxShadow: [
// //           // Outer glow
// //           BoxShadow(
// //             color: const Color(0xFF7DA2FF).withOpacity(0.2),
// //             blurRadius: 0,
// //             spreadRadius: 2,
// //           ),
// //           // Subtle inner shadow
// //           // const BoxShadow(
// //           //   color: Colors.white,
// //           //   offset: Offset(0, 3),
// //           //   blurRadius: 2,
// //           // ),
// //         ],
// //       ),
// //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
// //       child: IntrinsicWidth(
// //         child: InkWell(
// //           borderRadius: BorderRadius.circular(12),
// //           onTap: () {
// //             clearSearchController();
// //             showFilters(context);
// //           },
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               // Icon(
// //               //   Icons.filter_alt,
// //               //   color: Colors.white,
// //               //   size: 30,
// //               // ),
// //               Image.asset(
// //                 'assets/images/filter1.png', // 🔹 your image path here
// //                 width: 28,
// //                 height: 28,
// //                 color: Colors.white,
// //                 // color: Colors.white, // optional tint
// //               ),
// //               // SizedBox(width: 6),
// //               // Text(
// //               //   'Filters',
// //               //   style: TextStyle(
// //               //     color: Colors.white,
// //               //     fontWeight: FontWeight.w600,
// //               //     letterSpacing: 0.5,
// //               //   ),
// //               // ),
// //               // Icon(
// //               //   Icons.arrow_drop_down_outlined,
// //               //   color: Colors.white,
// //               //   size: 22,
// //               // ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// //   void showFilters(BuildContext context) {
// //     showModalBottomSheet(
// //       isScrollControlled: true,
// //       context: context,
// //       builder: (BuildContext context) {
// //         return BlocProvider(
// //           create: (context) => BaseFilterCubit(), // Provide the BaseFilterCubit
// //           child: BaseFilterSheet(
// //             applyFilters: applyFilters,
// //             statuses: commonFilters.statuses ?? [],
// //             regions: commonFilters.regions ?? [],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
// //
// // class BaseFilterSheet extends StatefulWidget {
// //   final Function(Filters) applyFilters;
// //   final List<Organisation> statuses;
// //   final List<Organisation> regions;
// //
// //   const BaseFilterSheet({
// //     super.key,
// //     required this.applyFilters,
// //     required this.statuses,
// //     required this.regions,
// //   });
// //
// //   @override
// //   State<BaseFilterSheet> createState() => _BaseFilterSheetState();
// // }
// //
// // class _BaseFilterSheetState extends State<BaseFilterSheet> {
// //   @override
// //   void initState() {
// //     // BlocProvider.of<BaseFilterCubit>(context)
// //     //     .getRegionsOrLocationsByRegionId(id: widget.regions.first.id ?? 0);
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // TextEditingController idController = TextEditingController();
// //     // TextEditingController slNoController = TextEditingController();
// //     // TextEditingController createdByController = TextEditingController();
// //     TextEditingController fromDateController = TextEditingController();
// //     TextEditingController toDateController = TextEditingController();
// //     Organisation? selectedRegion = Organisation();
// //     Organisation? selectedLocation = Organisation();
// //     Organisation? selectedStatus = Organisation();
// //     Filters filtersModel = Filters();
// //     bool isInitial = true;
// //
// //     final size = MediaQuery.of(context).size;
// //     double height = size.height;
// //     double width = size.width;
// //     double textFieldWidth = width > 430 ? width * 0.29 : width * 0.45;
// //     return BlocConsumer<BaseFilterCubit, BaseFilterState>(
// //       listener: (context, state) {
// //       },
// //       builder: (context, state) {
// //         log('-state.status-builder---${state.status}-');
// //         if (state.status == FormStatus.loading) {
// //           // return BaseLoader();
// //         }
// //
// //         return Padding(
// //           padding: EdgeInsets.only(
// //             bottom: MediaQuery.of(context).viewInsets.bottom,
// //             left: 8,
// //             right: 8,
// //             top: 5,
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               const Text(
// //                 'Filters',
// //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //               ),
// //               const SizedBox(height: 16),
// //               Row(
// //                 children: [
// //                   /// ID
// //                   Column(
// //                     children: [
// //                       CommonWidgets.textDisplay(
// //                         Constants.id,
// //                         Styles.textStyleBlack14,
// //                         isMandatory: false,
// //                       ),
// //                       CommonWidgets.verticalSpacerWidget(height * 0.001),
// //                       SizedBox(
// //                         width: textFieldWidth,
// //                         child: FlutterInputField(
// //                           textInputType: TextInputType.number,
// //                           textFormKey: Keys.idKey,
// //                           initialValue: '${filtersModel.id ?? ''}',
// //                           // controller: idController,
// //                           hintText: '',
// //                           isEnable: true,
// //                           isDisableColor: false,
// //                           onChange: (String value) {
// //                             filtersModel.id = int.tryParse(value);
// //                           },
// //                           validateTextField: (String? user) {},
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   CommonWidgets.horizontalSpacerWidget(height * 0.01),
// //
// //                   /// Created By
// //                   Column(
// //                     children: [
// //                       CommonWidgets.textDisplay(
// //                         Constants.createdby,
// //                         Styles.textStyleBlack14,
// //                         isMandatory: false,
// //                       ),
// //                       CommonWidgets.verticalSpacerWidget(height * 0.001),
// //                       SizedBox(
// //                         width: textFieldWidth,
// //                         child: FlutterInputField(
// //                           textInputType: TextInputType.text,
// //                           textFormKey: Keys.slNoKey,
// //                           initialValue: filtersModel.createdBy ?? '',
// //                           // controller: createdByController,
// //                           hintText: '',
// //                           isEnable: true,
// //                           isDisableColor: false,
// //                           onChange: (String value) {
// //                             filtersModel.createdBy = value;
// //                           },
// //                           validateTextField: (String? user) {},
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //               CommonWidgets.verticalSpacerWidget(height * 0.01),
// //               Row(
// //                 children: [
// //                   /// From Date
// //                   Column(
// //                     children: [
// //                       CommonWidgets.textDisplay(
// //                         Constants.fromDate,
// //                         Styles.textStyleBlack14,
// //                         isMandatory: false,
// //                       ),
// //                       Align(
// //                         alignment: Alignment.centerLeft,
// //                         child: SizedBox(
// //                           width: textFieldWidth,
// //                           child: BaseDate().datePickerWidgetLoading(
// //                             textController: fromDateController,
// //                             onlyDate: true,
// //                             onChange: (String value) {},
// //                             context: context,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //
// //                   /// To Date
// //                   Column(
// //                     children: [
// //                       CommonWidgets.textDisplay(
// //                         Constants.toDate,
// //                         Styles.textStyleBlack14,
// //                         isMandatory: false,
// //                       ),
// //                       Align(
// //                         alignment: Alignment.centerLeft,
// //                         child: SizedBox(
// //                           width: textFieldWidth,
// //                           child: BaseDate().datePickerWidgetLoading(
// //                             textController: toDateController,
// //                             onlyDate: true,
// //                             onChange: (String value) {},
// //                             context: context,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //               CommonWidgets.verticalSpacerWidget(height * 0.01),
// //
// //               Row(
// //                 children: [
// //                   DropdownWidget(
// //                     label: 'Select Region',
// //                     items: widget.regions,
// //                     isInitial: isInitial,
// //                     onChange: (value) async {
// //                       selectedRegion = value;
// //                       log('---onChange-region-----');
// //                       BlocProvider.of<BaseFilterCubit>(context)
// //                           .getRegionsOrLocationsByRegionId(
// //                               id: selectedRegion?.id ?? 0);
// //                     },
// //                   ),
// //                   const SizedBox(
// //                     width: 5,
// //                   ),
// //                   DropdownWidget(
// //                     label: 'Select Location',
// //                     items: state.locations,
// //                     onChange: (value) {
// //                       selectedLocation = value;
// //                     },
// //                   )
// //                 ],
// //               ),
// //
// //               CommonWidgets.verticalSpacerWidget(height * 0.01),
// //               Row(
// //                 children: [
// //                   DropdownWidget(
// //                     label: 'Select Status',
// //                     items: widget.statuses,
// //                     onChange: (value) {
// //                       selectedStatus = value;
// //                     },
// //                   ),
// //                   const SizedBox(
// //                     width: 5,
// //                   ),
// //                 ],
// //               ),
// //               // Add more filter fields as needed
// //               const SizedBox(height: 16),
// //
// //               /// Search
// //               ElevatedButton(
// //                 onPressed: () {
// //                   log('Applying Filters---onPressed---');
// //                   // filtersModel.id = int.tryParse(idController.text);
// //                   // filtersModel.createdBy = createdByController.text;
// //                   // filtersModel.slNo = int.tryParse(slNoController.text);
// //                   if (!fromDateController.text.isEmptyOrNull) {
// //                     filtersModel.fromDate =
// //                         Utils().formatTime(fromDateController.text);
// //                   }
// //                   if (!toDateController.text.isEmptyOrNull) {
// //                     filtersModel.toDate =
// //                         Utils().formatTime(toDateController.text);
// //                   }
// //                   filtersModel.status = selectedStatus?.id;
// //                   filtersModel.regionId = selectedRegion?.id;
// //                   filtersModel.locationId = selectedLocation?.id;
// //                   widget.applyFilters(filtersModel);
// //                 },
// //                 style: ButtonStyle(
// //                   foregroundColor: MaterialStateProperty.all<Color>(
// //                       AppColors.navigationSkyBlueColor),
// //                   // Change the text color here
// //                 ),
// //                 child: const Text('Search'),
// //               ),
// //               const SizedBox(height: 40),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
// //
// // class DropdownWidget extends StatefulWidget {
// //   final List<Organisation> items;
// //   final void Function(Organisation?)? onChange;
// //   final String label;
// //   final bool? isInitial;
// //   final Organisation? initialValue; // in case value is not updating in the UI
// //   final bool? shouldUpdate; // New parameter to control update
// //
// //   const DropdownWidget({
// //     super.key,
// //     required this.items,
// //     required this.onChange,
// //     required this.label,
// //     this.shouldUpdate, // Required parameter
// //     this.isInitial,
// //     this.initialValue,
// //   });
// //
// //   @override
// //   DropdownWidgetState createState() => DropdownWidgetState();
// // }
// //
// // class DropdownWidgetState extends State<DropdownWidget> {
// //   Organisation? selectedElement;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// // // Initialize selectedElement with the first item if isInitial is false
// //     selectedElement = widget.isInitial ?? true
// //         ? null
// //         : widget.items.isNotEmpty
// //             ? widget.items.first
// //             : null;
// //     if (widget.initialValue != null) {
// //       selectedElement = widget.initialValue;
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Expanded(
// //       child: DropdownButtonFormField<Organisation>(
// //         value: selectedElement,
// //         hint: Text(widget.label),
// //         // onChanged: widget.onChange,
// //         onChanged: (Organisation? newValue) {
// //           if (widget.shouldUpdate ?? false) {
// //             setState(() {
// //               selectedElement = newValue;
// //             });
// //           }
// //           if (widget.onChange != null) {
// //             widget.onChange!(newValue);
// //           }
// //         },
// //         items: widget.items.map((item) {
// //           return DropdownMenuItem<Organisation>(
// //             value: item,
// //             child: Text(item.name ?? ''),
// //           );
// //         }).toList(),
// //         decoration: const InputDecoration(
// //           focusedBorder: UnderlineInputBorder(
// //             borderSide: BorderSide(
// //               color: AppColors.navigationSkyBlueColor,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:intl/intl.dart';
//
// import '../../../../index.dart';
//
// import 'dart:ui';
//
// class BaseSearchWidget extends StatefulWidget {
//   final Function(FilterCriteria) applySearchFilters;
//   final Function(Filters) applyFilters;
//   final CommonFilters commonFilters;
//
//   const BaseSearchWidget({
//     super.key,
//     required this.applySearchFilters,
//     required this.applyFilters,
//     required this.commonFilters,
//   });
//
//   @override
//   State<BaseSearchWidget> createState() => _BaseSearchWidgetState();
// }
//
// class _BaseSearchWidgetState extends State<BaseSearchWidget> {
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               margin: const EdgeInsets.only(left: 10, right: 1), // 👈 SAME WIDTH AS DATE INPUT
//               height: 45,
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     // Color(0xFF2C3E7E),
//                     // Color(0xFF101D45),
//                     // Color(0xFF101D45),
//                     Colors.white,
//                     Colors.white,
//                     // Color(0xFF101D45),
//
//                     // Colors.white,
//                     // Colors.white,
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: Colors.black.withValues(alpha: 0.7),
//                   width: 1,
//                 ),
//                 boxShadow: [
//                   // Outer glow
//                   BoxShadow(
//                     color: AppColors.newColor3.withValues(alpha: 9),
//                     blurRadius: 2,
//                     spreadRadius: 0,
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 controller: searchController,
//                 style: const TextStyle(color: Colors.black),
//                 decoration: InputDecoration(
//                   hintText: 'Search...',
//                   hintStyle:
//                   TextStyle(color: Colors.black.withValues(alpha: 0.7)),
//                   contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 16, vertical: 10),
//                   suffixIcon: InkWell(
//                     onTap: () {
//                       FilterCriteria filterCriteriaModel = FilterCriteria();
//                       filterCriteriaModel.all = searchController.text;
//                       widget.applySearchFilters(filterCriteriaModel);
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withValues(alpha: 0.1),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Icon(
//                         Icons.search,
//                         color: Colors.black,
//                         size: 22,
//                       ),
//                     ),
//                   ),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 5),
//           GestureDetector(
//             onTap: () => _showRightFilterDrawer(context),
//             child: Container(
//               margin: const EdgeInsets.only(left: 5, right: 10), // 👈 SAME WIDTH AS DATE INPUT
//               height: 40,
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.white),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: const Icon(Icons.tune, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // void _showRightFilterDrawer(BuildContext context) {
//   //   showGeneralDialog(
//   //     context: context,
//   //     barrierDismissible: true,
//   //     barrierLabel: '',
//   //     transitionDuration: const Duration(milliseconds: 300),
//   //     pageBuilder: (context, animation1, animation2) {
//   //       return Align(
//   //         alignment: Alignment.centerRight,
//   //         child: Material(
//   //           // color: Colors.transparent,
//   //           color: AppColors.lavender,
//   //           child: SizedBox(
//   //             width: MediaQuery.of(context).size.width * 0.85,
//   //             child: FilterDrawerWidget(
//   //               applyFilters: widget.applyFilters,
//   //               commonFilters: widget.commonFilters,
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //     transitionBuilder: (context, animation1, animation2, child) {
//   //       return SlideTransition(
//   //         position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation1),
//   //         child: child,
//   //       );
//   //     },
//   //   );
//   // }
//   void _showRightFilterDrawer(BuildContext context) {
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: '',
//       transitionDuration: const Duration(milliseconds: 300),
//       barrierColor: Colors.black.withValues(alpha: 0.1), // faint overlay
//       pageBuilder: (context, animation1, animation2) {
//         return Align(
//           alignment: Alignment.centerRight,
//           child: Material(
//             color: Colors.transparent,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 bottomLeft: Radius.circular(20),
//               ),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.85,
//                   decoration: BoxDecoration(
//                     color: AppColors.newColor.withValues(alpha: 0.15),
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       bottomLeft: Radius.circular(20),
//                     ),
//                     border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColors.newColor.withValues(alpha: 0.1),
//                         blurRadius: 25,
//                         spreadRadius: 5,
//                         offset: const Offset(-5, 5),
//                       ),
//                     ],
//                   ),
//                   child: FilterDrawerWidget(
//                     applyFilters: widget.applyFilters,
//                     commonFilters: widget.commonFilters,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//       transitionBuilder: (context, animation1, animation2, child) {
//         return SlideTransition(
//           position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
//               .animate(CurvedAnimation(parent: animation1, curve: Curves.easeOutCubic)),
//           child: child,
//         );
//       },
//     );
//   }
//
// }
//
// class FilterDrawerWidget extends StatefulWidget {
//   final Function(Filters) applyFilters;
//   final CommonFilters commonFilters;
//
//   const FilterDrawerWidget({
//     super.key,
//     required this.applyFilters,
//     required this.commonFilters,
//   });
//
//   @override
//   State<FilterDrawerWidget> createState() => _FilterDrawerWidgetState();
// }
//
// class _FilterDrawerWidgetState extends State<FilterDrawerWidget> {
//   int? selectedTabIndex = 0;
//   final TextEditingController idController = TextEditingController();
//   final TextEditingController createdByController = TextEditingController();
//
//   Organisation? selectedRegion;
//   Organisation? selectedLocation;
//   Organisation? selectedStatus;
//   DateTime? fromDate;
//   DateTime? toDate;
//   List<Organisation> filteredLocations = [];
//
//   final List<String> tabs = [
//     'ID',
//     'Created By',
//     'From Date',
//     'To Date',
//     'Region',
//     'Location',
//     'Status',
//   ];
//
//   void clearFilters() {
//     setState(() {
//       idController.clear();
//       createdByController.clear();
//       selectedRegion = null;
//       selectedLocation = null;
//       selectedStatus = null;
//       fromDate = null;
//       toDate = null;
//       filteredLocations = [];
//     });
//   }
//
//   Widget _buildDatePicker(String label, DateTime? value, Function(DateTime?) onChanged) {
//     return ListTile(
//       title: Text(label, style: const TextStyle(color: Colors.white)),
//       subtitle: Text(
//         value != null ? DateFormat('yyyy-MM-dd').format(value) : 'Select date',
//         style: const TextStyle(color: Colors.white),
//       ),
//       onTap: () async {
//         final picked = await showDatePicker(
//           context: context,
//           initialDate: value ?? DateTime.now(),
//           firstDate: DateTime(2000),
//           lastDate: DateTime(2100),
//         );
//         if (picked != null) onChanged(picked);
//       },
//     );
//   }
//
//   // Widget _buildRadioList(List<Organisation>? list, Organisation? selected, Function(Organisation) onSelect) {
//   //   if (list == null || list.isEmpty) return const Text('No data', style: TextStyle(color: Colors.white));
//   //   return Column(
//   //     children: list.map((e) {
//   //       return RadioListTile<Organisation>(
//   //         contentPadding: EdgeInsets.zero,
//   //         title: Text(e.name ?? '', style: const TextStyle(color: Colors.white)),
//   //         value: e,
//   //         groupValue: selected,
//   //         activeColor: Colors.white,
//   //         onChanged: (val) {
//   //           if (val != null) onSelect(val);
//   //         },
//   //       );
//   //     }).toList(),
//   //   );
//   // }
//   Widget _buildRadioList(
//       List<Organisation>? list,
//       Organisation? selected,
//       Function(Organisation) onSelect,
//       ) {
//     if (list == null || list.isEmpty) {
//       return const Text(
//         'No data',
//         style: TextStyle(color: Colors.white),
//       );
//     }
//
//     return Column(
//       children: list.map((e) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             unselectedWidgetColor: Colors.white, // 👈 black deselected radio
//           ),
//           child: RadioListTile<Organisation>(
//             contentPadding: EdgeInsets.zero,
//             title: Text(
//               e.name ?? '',
//               style: const TextStyle(color: Colors.white),
//             ),
//             value: e,
//             groupValue: selected,
//             activeColor: Colors.white, // 👈 white when selected
//             onChanged: (val) {
//               if (val != null) onSelect(val);
//             },
//           ),
//         );
//       }).toList(),
//     );
//
//   }
//
//
//   Widget _buildTabContent() {
//     switch (tabs[selectedTabIndex!]) {
//       case 'ID':
//         return _buildGlassTextField('Enter ID', idController, TextInputType.number);
//       case 'Created By':
//         return _buildGlassTextField('Enter Created By', createdByController, TextInputType.text);
//       case 'From Date':
//         return _buildDatePicker('From Date', fromDate, (val) => setState(() => fromDate = val));
//       case 'To Date':
//         return _buildDatePicker('To Date', toDate, (val) => setState(() => toDate = val));
//       case 'Region':
//         return _buildRadioList(widget.commonFilters.regions, selectedRegion, (val) async {
//           setState(() {
//             selectedRegion = val;
//             selectedLocation = null;
//             filteredLocations = [];
//           });
//           CommonServices commonServices = CommonServices();
//           List<Organisation> locations = await commonServices.getRegionsOrLocationsByRegionId(id: selectedRegion?.id ?? 0);
//           setState(() => filteredLocations = locations);
//         });
//       case 'Location':
//         return _buildRadioList(filteredLocations, selectedLocation, (val) => setState(() => selectedLocation = val));
//       case 'Status':
//         return _buildRadioList(widget.commonFilters.statuses, selectedStatus, (val) => setState(() => selectedStatus = val));
//       default:
//         return const SizedBox();
//     }
//   }
//
//   Widget _buildGlassTextField(String label, TextEditingController controller, TextInputType type) {
//     return TextField(
//       controller: controller,
//       keyboardType: type,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(color: Colors.white),
//         filled: true,
//         fillColor: AppColors.newColor.withValues(alpha: 0.15),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.4)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.4)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.7)),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.newColor3.withValues(alpha: 0.7),
//                     AppColors.newColor3.withValues(alpha: 0.4),
//                     // const Color(0xFF071130).withOpacity(0.1),
//                     // const Color(0xFF071130).withOpacity(0.1),
//
//                     // AppColors.lavender.withOpacity(0.1),
//                     // Colors.black.withOpacity(0.01),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//             ),
//             BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: AppColors.newColor3.withValues(alpha: 0.2),
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
//                 ),
//                 child: Column(
//                   children: [
//                     // Header
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           const Center(
//                             child: Text(
//                               'Filters',
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             right: 0,
//                             child: IconButton(
//                               icon: const Icon(Icons.close, color: Colors.white),
//                               onPressed: () => Navigator.pop(context),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Container(height: 1, color: Colors.white.withOpacity(0.3)),
//                     const Divider(
//                       color: AppColors.white,
//                       thickness: 0.3,
//                     ),
//                     // Main body
//                     Expanded(
//                       child: Row(
//                         children: [
//                           // Left tabs
//                           Container(
//                             width: 130,
//                             decoration: BoxDecoration(
//                               color: AppColors.newColor.withValues(alpha: 0.08),
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 bottomLeft: Radius.circular(20),
//                               ),
//                             ),
//                             child: ListView.builder(
//                               itemCount: tabs.length,
//                               itemBuilder: (context, index) {
//                                 final isSelected = selectedTabIndex == index;
//                                 return InkWell(
//                                   onTap: () => setState(() => selectedTabIndex = index),
//                                   child: AnimatedContainer(
//                                     duration: const Duration(milliseconds: 250),
//                                     padding: const EdgeInsets.all(20),
//                                     decoration: BoxDecoration(
//                                       color: isSelected
//                                           ? Colors.white.withValues(alpha: 0.35)
//                                           : Colors.transparent,
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Text(
//                                       tabs[index],
//                                       style: TextStyle(
//                                         fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
//                                         fontSize: 16,
//                                         color: isSelected ? Colors.black : Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//
//                           // Right tab content
//                           Expanded(
//                             child: LayoutBuilder(
//                               builder: (context, constraints) {
//                                 return SingleChildScrollView(
//                                   padding: const EdgeInsets.all(16),
//                                   child: ConstrainedBox(
//                                     constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                                     child: IntrinsicHeight(
//                                       child: Container(
//                                         padding: const EdgeInsets.all(20),
//                                         decoration: BoxDecoration(
//                                           color: AppColors.newColor3.withValues(alpha: 0.08),
//                                           borderRadius: BorderRadius.circular(16),
//                                           border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [_buildTabContent()],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     // Bottom buttons
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       decoration: BoxDecoration(
//                         color: AppColors.newColor3.withValues(alpha: 0.99),
//                         border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.3))),
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: OutlinedButton(
//                               style: OutlinedButton.styleFrom(
//                                 side: BorderSide(color: Colors.white.withValues(alpha: 0.7)),
//                                 foregroundColor: Colors.white,
//                                 backgroundColor: Colors.white.withValues(alpha: 0.05),
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                               ),
//                               onPressed: clearFilters,
//                               child: const Text('Clear All'),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF071130).withValues(alpha: 0.5),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),   side: const BorderSide(
//                                   color: Colors.white,   // 👈 WHITE BORDER
//                                   width: 0.65,            // adjust thickness
//                                 ),),
//                                 // shadowColor: const Color(0xFF071130),
//                                 elevation: 8,
//                               ),
//                               onPressed: () {
//                                 final filters = Filters(
//                                   id: int.tryParse(idController.text),
//                                   createdBy: createdByController.text,
//                                   fromDate: fromDate?.toString(),
//                                   toDate: toDate?.toString(),
//                                   regionId: selectedRegion?.id,
//                                   locationId: selectedLocation?.id,
//                                   status: selectedStatus?.id,
//                                 );
//                                 widget.applyFilters(filters);
//                               },
//                               child: const Text('Apply'),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DropdownWidget extends StatefulWidget {
//   final List<Organisation> items;
//   final void Function(Organisation?)? onChange;
//   final String label;
//   final bool? isInitial;
//   final Organisation? initialValue; // in case value is not updating in the UI
//   final bool? shouldUpdate; // New parameter to control update
//
//   const DropdownWidget({
//     super.key,
//     required this.items,
//     required this.onChange,
//     required this.label,
//     this.shouldUpdate, // Required parameter
//     this.isInitial,
//     this.initialValue,
//   });
//
//   @override
//   DropdownWidgetState createState() => DropdownWidgetState();
// }
//
// class DropdownWidgetState extends State<DropdownWidget> {
//   Organisation? selectedElement;
//
//   @override
//   void initState() {
//     super.initState();
// // Initialize selectedElement with the first item if isInitial is false
//     selectedElement = widget.isInitial ?? true
//         ? null
//         : widget.items.isNotEmpty
//         ? widget.items.first
//         : null;
//     if (widget.initialValue != null) {
//       selectedElement = widget.initialValue;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // return Expanded(
//     //   child: DropdownButtonFormField<Organisation>(
//     //     initialValue: selectedElement,
//     //     hint: Text(widget.label),
//     //     // onChanged: widget.onChange,
//     //     onChanged: (Organisation? newValue) {
//     //       if (widget.shouldUpdate ?? false) {
//     //         setState(() {
//     //           selectedElement = newValue;
//     //         });
//     //       }
//     //       if (widget.onChange != null) {
//     //         widget.onChange!(newValue);
//     //       }
//     //     },
//     //     items: widget.items.map((item) {
//     //       return DropdownMenuItem<Organisation>(
//     //         value: item,
//     //         child: Text(item.name ?? ''),
//     //       );
//     //     }).toList(),
//     //     decoration: const InputDecoration(
//     //       focusedBorder: UnderlineInputBorder(
//     //         borderSide: BorderSide(
//     //           color: AppColors.navigationSkyBlueColor,
//     //         ),
//     //       ),
//     //     ),
//     //
//     //   ),
//     // );
//     return Expanded(
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white.withValues(alpha: 0.12), // Frosted white tint
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(
//             color: Colors.white.withValues(alpha: 0.25),
//             width: 1.2,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.white.withValues(alpha: 0.15),
//               blurRadius: 12,
//               spreadRadius: 1,
//               offset: const Offset(0, 4),
//             ),
//           ],
//           // Glass blur
//           backgroundBlendMode: BlendMode.overlay,
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(18),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: DropdownButtonFormField<Organisation>(
//                 value: selectedElement,
//                 hint: Text(
//                   widget.label,
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 dropdownColor: Colors.white.withValues(alpha: 0.1), // glass dropdown
//                 iconEnabledColor: Colors.white,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 onChanged: (Organisation? newValue) {
//                   if (widget.shouldUpdate ?? false) {
//                     setState(() {
//                       selectedElement = newValue;
//                     });
//                   }
//                   widget.onChange?.call(newValue);
//                 },
//                 items: widget.items.map((item) {
//                   return DropdownMenuItem<Organisation>(
//                     value: item,
//                     child: Text(
//                       item.name ?? '',
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   );
//                 }).toList(),
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//
//   }
// }
//

// import 'dart:developer';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/common_widgets/base_widget/base_filter/cubit/base_filter_cubit.dart';
//
// class BaseSearchWidget extends StatefulWidget {
//   final Function(FilterCriteria) applySearchFilters;
//   final Function(Filters) applyFilters;
//   final CommonFilters commonFilters;
//
//   const BaseSearchWidget({
//     super.key,
//     required this.applySearchFilters,
//     required this.applyFilters,
//     required this.commonFilters,
//   });
//
//   @override
//   BaseSearchWidgetState createState() => BaseSearchWidgetState();
// }
//
// class BaseSearchWidgetState extends State<BaseSearchWidget> {
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Center( // 👈 centers the row horizontally
//         child: SizedBox(
//           width: width * 0.95, // 👈 reduce width (e.g. 85% of screen)
//           child: Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 45,
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         // Color(0xFF2C3E7E),
//                         // Color(0xFF101D45),
//                         // Color(0xFF101D45),
//                         Colors.white,
//                         Colors.white,
//                         // Color(0xFF101D45),
//
//                         // Colors.white,
//                         // Colors.white,
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(
//                       color: Colors.black.withOpacity(0.7),
//                       width: 1,
//                     ),
//                     boxShadow: [
//                       // Outer glow
//                       BoxShadow(
//                         color: const Color(0xFF7DA2FF).withOpacity(0),
//                         blurRadius: 2,
//                         spreadRadius: 0,
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     controller: searchController,
//                     style: const TextStyle(color: Colors.black),
//                     decoration: InputDecoration(
//                       hintText: 'Search...',
//                       hintStyle:
//                       TextStyle(color: Colors.black.withOpacity(0.7)),
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 10),
//                       suffixIcon: InkWell(
//                         onTap: () {
//                           FilterCriteria filterCriteriaModel = FilterCriteria();
//                           filterCriteriaModel.all = searchController.text;
//                           widget.applySearchFilters(filterCriteriaModel);
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.all(6),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: const Icon(
//                             Icons.search,
//                             color: Colors.black,
//                             size: 22,
//                           ),
//                         ),
//                       ),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               ShowFiltersWidget(
//                 applyFilters: widget.applyFilters,
//                 commonFilters: widget.commonFilters,
//                 clearSearchController: () {
//                   searchController.clear();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ShowFiltersWidget extends StatelessWidget {
//   final Function(Filters) applyFilters;
//   final CommonFilters commonFilters;
//   final VoidCallback clearSearchController;
//
//   const ShowFiltersWidget({
//     super.key,
//     required this.applyFilters,
//     required this.clearSearchController,
//     required this.commonFilters,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(right: 1),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFF2C3E7E),
//             Color(0xFF101D45),
//             // Colors.white,
//             // Colors.white,
//             // Color(0xFF101D45),
//           ],
//         ),
//         color:  Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//           color: Colors.white.withOpacity(0.5),
//           width: 1.3,
//         ),
//         boxShadow: [
//           // Outer glow
//           BoxShadow(
//             color: const Color(0xFF7DA2FF).withOpacity(0.2),
//             blurRadius: 0,
//             spreadRadius: 2,
//           ),
//           // Subtle inner shadow
//           // const BoxShadow(
//           //   color: Colors.white,
//           //   offset: Offset(0, 3),
//           //   blurRadius: 2,
//           // ),
//         ],
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//       child: IntrinsicWidth(
//         child: InkWell(
//           borderRadius: BorderRadius.circular(12),
//           onTap: () {
//             clearSearchController();
//             showFilters(context);
//           },
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Icon(
//               //   Icons.filter_alt,
//               //   color: Colors.white,
//               //   size: 30,
//               // ),
//               Image.asset(
//                 'assets/images/filter1.png', // 🔹 your image path here
//                 width: 28,
//                 height: 28,
//                 color: Colors.white,
//                 // color: Colors.white, // optional tint
//               ),
//               // SizedBox(width: 6),
//               // Text(
//               //   'Filters',
//               //   style: TextStyle(
//               //     color: Colors.white,
//               //     fontWeight: FontWeight.w600,
//               //     letterSpacing: 0.5,
//               //   ),
//               // ),
//               // Icon(
//               //   Icons.arrow_drop_down_outlined,
//               //   color: Colors.white,
//               //   size: 22,
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   void showFilters(BuildContext context) {
//     showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext context) {
//         return BlocProvider(
//           create: (context) => BaseFilterCubit(), // Provide the BaseFilterCubit
//           child: BaseFilterSheet(
//             applyFilters: applyFilters,
//             statuses: commonFilters.statuses ?? [],
//             regions: commonFilters.regions ?? [],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class BaseFilterSheet extends StatefulWidget {
//   final Function(Filters) applyFilters;
//   final List<Organisation> statuses;
//   final List<Organisation> regions;
//
//   const BaseFilterSheet({
//     super.key,
//     required this.applyFilters,
//     required this.statuses,
//     required this.regions,
//   });
//
//   @override
//   State<BaseFilterSheet> createState() => _BaseFilterSheetState();
// }
//
// class _BaseFilterSheetState extends State<BaseFilterSheet> {
//   @override
//   void initState() {
//     // BlocProvider.of<BaseFilterCubit>(context)
//     //     .getRegionsOrLocationsByRegionId(id: widget.regions.first.id ?? 0);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TextEditingController idController = TextEditingController();
//     // TextEditingController slNoController = TextEditingController();
//     // TextEditingController createdByController = TextEditingController();
//     TextEditingController fromDateController = TextEditingController();
//     TextEditingController toDateController = TextEditingController();
//     Organisation? selectedRegion = Organisation();
//     Organisation? selectedLocation = Organisation();
//     Organisation? selectedStatus = Organisation();
//     Filters filtersModel = Filters();
//     bool isInitial = true;
//
//     final size = MediaQuery.of(context).size;
//     double height = size.height;
//     double width = size.width;
//     double textFieldWidth = width > 430 ? width * 0.29 : width * 0.45;
//     return BlocConsumer<BaseFilterCubit, BaseFilterState>(
//       listener: (context, state) {
//       },
//       builder: (context, state) {
//         log('-state.status-builder---${state.status}-');
//         if (state.status == FormStatus.loading) {
//           // return BaseLoader();
//         }
//
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//             left: 8,
//             right: 8,
//             top: 5,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Filters',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   /// ID
//                   Column(
//                     children: [
//                       CommonWidgets.textDisplay(
//                         Constants.id,
//                         Styles.textStyleBlack14,
//                         isMandatory: false,
//                       ),
//                       CommonWidgets.verticalSpacerWidget(height * 0.001),
//                       SizedBox(
//                         width: textFieldWidth,
//                         child: FlutterInputField(
//                           textInputType: TextInputType.number,
//                           textFormKey: Keys.idKey,
//                           initialValue: '${filtersModel.id ?? ''}',
//                           // controller: idController,
//                           hintText: '',
//                           isEnable: true,
//                           isDisableColor: false,
//                           onChange: (String value) {
//                             filtersModel.id = int.tryParse(value);
//                           },
//                           validateTextField: (String? user) {},
//                         ),
//                       ),
//                     ],
//                   ),
//                   CommonWidgets.horizontalSpacerWidget(height * 0.01),
//
//                   /// Created By
//                   Column(
//                     children: [
//                       CommonWidgets.textDisplay(
//                         Constants.createdby,
//                         Styles.textStyleBlack14,
//                         isMandatory: false,
//                       ),
//                       CommonWidgets.verticalSpacerWidget(height * 0.001),
//                       SizedBox(
//                         width: textFieldWidth,
//                         child: FlutterInputField(
//                           textInputType: TextInputType.text,
//                           textFormKey: Keys.slNoKey,
//                           initialValue: filtersModel.createdBy ?? '',
//                           // controller: createdByController,
//                           hintText: '',
//                           isEnable: true,
//                           isDisableColor: false,
//                           onChange: (String value) {
//                             filtersModel.createdBy = value;
//                           },
//                           validateTextField: (String? user) {},
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               CommonWidgets.verticalSpacerWidget(height * 0.01),
//               Row(
//                 children: [
//                   /// From Date
//                   Column(
//                     children: [
//                       CommonWidgets.textDisplay(
//                         Constants.fromDate,
//                         Styles.textStyleBlack14,
//                         isMandatory: false,
//                       ),
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: SizedBox(
//                           width: textFieldWidth,
//                           child: BaseDate().datePickerWidgetLoading(
//                             textController: fromDateController,
//                             onlyDate: true,
//                             onChange: (String value) {},
//                             context: context,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   /// To Date
//                   Column(
//                     children: [
//                       CommonWidgets.textDisplay(
//                         Constants.toDate,
//                         Styles.textStyleBlack14,
//                         isMandatory: false,
//                       ),
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: SizedBox(
//                           width: textFieldWidth,
//                           child: BaseDate().datePickerWidgetLoading(
//                             textController: toDateController,
//                             onlyDate: true,
//                             onChange: (String value) {},
//                             context: context,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//               Row(
//                 children: [
//                   DropdownWidget(
//                     label: 'Select Region',
//                     items: widget.regions,
//                     isInitial: isInitial,
//                     onChange: (value) async {
//                       selectedRegion = value;
//                       log('---onChange-region-----');
//                       BlocProvider.of<BaseFilterCubit>(context)
//                           .getRegionsOrLocationsByRegionId(
//                               id: selectedRegion?.id ?? 0);
//                     },
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   DropdownWidget(
//                     label: 'Select Location',
//                     items: state.locations,
//                     onChange: (value) {
//                       selectedLocation = value;
//                     },
//                   )
//                 ],
//               ),
//
//               CommonWidgets.verticalSpacerWidget(height * 0.01),
//               Row(
//                 children: [
//                   DropdownWidget(
//                     label: 'Select Status',
//                     items: widget.statuses,
//                     onChange: (value) {
//                       selectedStatus = value;
//                     },
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                 ],
//               ),
//               // Add more filter fields as needed
//               const SizedBox(height: 16),
//
//               /// Search
//               ElevatedButton(
//                 onPressed: () {
//                   log('Applying Filters---onPressed---');
//                   // filtersModel.id = int.tryParse(idController.text);
//                   // filtersModel.createdBy = createdByController.text;
//                   // filtersModel.slNo = int.tryParse(slNoController.text);
//                   if (!fromDateController.text.isEmptyOrNull) {
//                     filtersModel.fromDate =
//                         Utils().formatTime(fromDateController.text);
//                   }
//                   if (!toDateController.text.isEmptyOrNull) {
//                     filtersModel.toDate =
//                         Utils().formatTime(toDateController.text);
//                   }
//                   filtersModel.status = selectedStatus?.id;
//                   filtersModel.regionId = selectedRegion?.id;
//                   filtersModel.locationId = selectedLocation?.id;
//                   widget.applyFilters(filtersModel);
//                 },
//                 style: ButtonStyle(
//                   foregroundColor: MaterialStateProperty.all<Color>(
//                       AppColors.navigationSkyBlueColor),
//                   // Change the text color here
//                 ),
//                 child: const Text('Search'),
//               ),
//               const SizedBox(height: 40),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class DropdownWidget extends StatefulWidget {
//   final List<Organisation> items;
//   final void Function(Organisation?)? onChange;
//   final String label;
//   final bool? isInitial;
//   final Organisation? initialValue; // in case value is not updating in the UI
//   final bool? shouldUpdate; // New parameter to control update
//
//   const DropdownWidget({
//     super.key,
//     required this.items,
//     required this.onChange,
//     required this.label,
//     this.shouldUpdate, // Required parameter
//     this.isInitial,
//     this.initialValue,
//   });
//
//   @override
//   DropdownWidgetState createState() => DropdownWidgetState();
// }
//
// class DropdownWidgetState extends State<DropdownWidget> {
//   Organisation? selectedElement;
//
//   @override
//   void initState() {
//     super.initState();
// // Initialize selectedElement with the first item if isInitial is false
//     selectedElement = widget.isInitial ?? true
//         ? null
//         : widget.items.isNotEmpty
//             ? widget.items.first
//             : null;
//     if (widget.initialValue != null) {
//       selectedElement = widget.initialValue;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: DropdownButtonFormField<Organisation>(
//         value: selectedElement,
//         hint: Text(widget.label),
//         // onChanged: widget.onChange,
//         onChanged: (Organisation? newValue) {
//           if (widget.shouldUpdate ?? false) {
//             setState(() {
//               selectedElement = newValue;
//             });
//           }
//           if (widget.onChange != null) {
//             widget.onChange!(newValue);
//           }
//         },
//         items: widget.items.map((item) {
//           return DropdownMenuItem<Organisation>(
//             value: item,
//             child: Text(item.name ?? ''),
//           );
//         }).toList(),
//         decoration: const InputDecoration(
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(
//               color: AppColors.navigationSkyBlueColor,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:intl/intl.dart';

import '../../../../index.dart';

import 'dart:ui';

class BaseSearchWidget extends StatefulWidget {
  final Function(FilterCriteria) applySearchFilters;
  final Function(Filters) applyFilters;
  final CommonFilters commonFilters;

  const BaseSearchWidget({
    super.key,
    required this.applySearchFilters,
    required this.applyFilters,
    required this.commonFilters,
  });

  @override
  State<BaseSearchWidget> createState() => _BaseSearchWidgetState();
}

class _BaseSearchWidgetState extends State<BaseSearchWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 1), // 👈 SAME WIDTH AS DATE INPUT
              height: 45,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    // Color(0xFF2C3E7E),
                    // Color(0xFF101D45),
                    // Color(0xFF101D45),
                    Colors.white,
                    Colors.white,
                    // Color(0xFF101D45),

                    // Colors.white,
                    // Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.7),
                  width: 1,
                ),
                // boxShadow: [
                // Outer glow
                // BoxShadow(
                //   color: AppColors.newColor3.withValues(alpha: 9),
                //   blurRadius: 2,
                //   spreadRadius: 0,
                // ),
                // ],
              ),
              child: TextField(
                controller: searchController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle:
                  TextStyle(color: Colors.black.withValues(alpha: 0.7)),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  suffixIcon: InkWell(
                    onTap: () {
                      FilterCriteria filterCriteriaModel = FilterCriteria();
                      filterCriteriaModel.all = searchController.text;
                      widget.applySearchFilters(filterCriteriaModel);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 22,
                      ),
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () => _showRightFilterDrawer(context),
            child: Container(
              margin: const EdgeInsets.only(left: 5, right: 10), // 👈 SAME WIDTH AS DATE INPUT
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(Icons.tune, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // void _showRightFilterDrawer(BuildContext context) {
  //   showGeneralDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     barrierLabel: '',
  //     transitionDuration: const Duration(milliseconds: 300),
  //     pageBuilder: (context, animation1, animation2) {
  //       return Align(
  //         alignment: Alignment.centerRight,
  //         child: Material(
  //           // color: Colors.transparent,
  //           color: AppColors.lavender,
  //           child: SizedBox(
  //             width: MediaQuery.of(context).size.width * 0.85,
  //             child: FilterDrawerWidget(
  //               applyFilters: widget.applyFilters,
  //               commonFilters: widget.commonFilters,
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //     transitionBuilder: (context, animation1, animation2, child) {
  //       return SlideTransition(
  //         position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation1),
  //         child: child,
  //       );
  //     },
  //   );
  // }
  void _showRightFilterDrawer(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      barrierColor: Colors.black.withValues(alpha: 0.1), // faint overlay
      pageBuilder: (context, animation1, animation2) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    color: AppColors.newColor.withValues(alpha: 0.15),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.newColor.withValues(alpha: 0.1),
                        blurRadius: 25,
                        spreadRadius: 5,
                        offset: const Offset(-5, 5),
                      ),
                    ],
                  ),
                  child: FilterDrawerWidget(
                    applyFilters: widget.applyFilters,
                    commonFilters: widget.commonFilters,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .animate(CurvedAnimation(parent: animation1, curve: Curves.easeOutCubic)),
          child: child,
        );
      },
    );
  }

}

class FilterDrawerWidget extends StatefulWidget {
  final Function(Filters) applyFilters;
  final CommonFilters commonFilters;

  const FilterDrawerWidget({
    super.key,
    required this.applyFilters,
    required this.commonFilters,
  });

  @override
  State<FilterDrawerWidget> createState() => _FilterDrawerWidgetState();
}

class _FilterDrawerWidgetState extends State<FilterDrawerWidget> {
  int? selectedTabIndex = 0;
  final TextEditingController idController = TextEditingController();
  final TextEditingController createdByController = TextEditingController();

  Organisation? selectedRegion;
  Organisation? selectedLocation;
  Organisation? selectedStatus;
  DateTime? fromDate;
  DateTime? toDate;
  List<Organisation> filteredLocations = [];

  final List<String> tabs = [
    'ID',
    'Created By',
    'From Date',
    'To Date',
    'Region',
    'Location',
    'Status',
  ];

  void clearFilters() {
    setState(() {
      idController.clear();
      createdByController.clear();
      selectedRegion = null;
      selectedLocation = null;
      selectedStatus = null;
      fromDate = null;
      toDate = null;
      filteredLocations = [];
    });
  }

  Widget _buildDatePicker(String label, DateTime? value, Function(DateTime?) onChanged) {
    return ListTile(
      title: Text(label, style: const TextStyle(color: Colors.white)),
      subtitle: Text(
        value != null ? DateFormat('yyyy-MM-dd').format(value) : 'Select date',
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) onChanged(picked);
      },
    );
  }

  // Widget _buildRadioList(List<Organisation>? list, Organisation? selected, Function(Organisation) onSelect) {
  //   if (list == null || list.isEmpty) return const Text('No data', style: TextStyle(color: Colors.white));
  //   return Column(
  //     children: list.map((e) {
  //       return RadioListTile<Organisation>(
  //         contentPadding: EdgeInsets.zero,
  //         title: Text(e.name ?? '', style: const TextStyle(color: Colors.white)),
  //         value: e,
  //         groupValue: selected,
  //         activeColor: Colors.white,
  //         onChanged: (val) {
  //           if (val != null) onSelect(val);
  //         },
  //       );
  //     }).toList(),
  //   );
  // }
  Widget _buildRadioList(
      List<Organisation>? list,
      Organisation? selected,
      Function(Organisation) onSelect,
      ) {
    if (list == null || list.isEmpty) {
      return const Text(
        'No data',
        style: TextStyle(color: Colors.white),
      );
    }

    return Column(
      children: list.map((e) {
        return Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.white, // 👈 black deselected radio
          ),
          child: RadioListTile<Organisation>(
            contentPadding: EdgeInsets.zero,
            title: Text(
              e.name ?? '',
              style: const TextStyle(color: Colors.white),
            ),
            value: e,
            groupValue: selected,
            activeColor: Colors.white, // 👈 white when selected
            onChanged: (val) {
              if (val != null) onSelect(val);
            },
          ),
        );
      }).toList(),
    );

  }


  Widget _buildTabContent() {
    switch (tabs[selectedTabIndex!]) {
      case 'ID':
        return _buildGlassTextField('Enter ID', idController, TextInputType.number);
      case 'Created By':
        return _buildGlassTextField('Enter Created By', createdByController, TextInputType.text);
      case 'From Date':
        return _buildDatePicker('From Date', fromDate, (val) => setState(() => fromDate = val));
      case 'To Date':
        return _buildDatePicker('To Date', toDate, (val) => setState(() => toDate = val));
      case 'Region':
        return _buildRadioList(widget.commonFilters.regions, selectedRegion, (val) async {
          setState(() {
            selectedRegion = val;
            selectedLocation = null;
            filteredLocations = [];
          });
          CommonServices commonServices = CommonServices();
          List<Organisation> locations = await commonServices.getRegionsOrLocationsByRegionId(id: selectedRegion?.id ?? 0);
          setState(() => filteredLocations = locations);
        });
      case 'Location':
        return _buildRadioList(filteredLocations, selectedLocation, (val) => setState(() => selectedLocation = val));
      case 'Status':
        return _buildRadioList(widget.commonFilters.statuses, selectedStatus, (val) => setState(() => selectedStatus = val));
      default:
        return const SizedBox();
    }
  }

  Widget _buildGlassTextField(String label, TextEditingController controller, TextInputType type) {
    return TextField(
      controller: controller,
      keyboardType: type,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: AppColors.newColor.withValues(alpha: 0.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.7)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.newColor.withValues(alpha: 0.7),
                    AppColors.newColor.withValues(alpha: 0.4),
                    // const Color(0xFF071130).withOpacity(0.1),
                    // const Color(0xFF071130).withOpacity(0.1),

                    // AppColors.lavender.withOpacity(0.1),
                    // Colors.black.withOpacity(0.01),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.newColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Center(
                            child: Text(
                              'Filters',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.close, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(height: 1, color: Colors.white.withOpacity(0.3)),
                    const Divider(
                      color: AppColors.white,
                      thickness: 0.3,
                    ),
                    // Main body
                    Expanded(
                      child: Row(
                        children: [
                          // Left tabs
                          Container(
                            width: 130,
                            decoration: BoxDecoration(
                              color: AppColors.newColor.withValues(alpha: 0.08),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: ListView.builder(
                              itemCount: tabs.length,
                              itemBuilder: (context, index) {
                                final isSelected = selectedTabIndex == index;
                                return InkWell(
                                  onTap: () => setState(() => selectedTabIndex = index),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.white.withValues(alpha: 0.35)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      tabs[index],
                                      style: TextStyle(
                                        fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                                        fontSize: 16,
                                        color: isSelected ? Colors.black : Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // Right tab content
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return SingleChildScrollView(
                                  padding: const EdgeInsets.all(16),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                                    child: IntrinsicHeight(
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: AppColors.newColor.withValues(alpha: 0.08),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [_buildTabContent()],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Bottom buttons
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.newColor.withValues(alpha: 0.99),
                        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.3))),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.white.withValues(alpha: 0.7)),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.white.withValues(alpha: 0.05),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: clearFilters,
                              child: const Text('Clear All'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.fedexColor.withValues(alpha: 0.5),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),   side: const BorderSide(
                                  color: Colors.white,   // 👈 WHITE BORDER
                                  width: 0.65,            // adjust thickness
                                ),),
                                // shadowColor: const Color(0xFF071130),
                                elevation: 8,
                              ),
                              onPressed: () {
                                final filters = Filters(
                                  id: int.tryParse(idController.text),
                                  createdBy: createdByController.text,
                                  fromDate: fromDate?.toString(),
                                  toDate: toDate?.toString(),
                                  regionId: selectedRegion?.id,
                                  locationId: selectedLocation?.id,
                                  status: selectedStatus?.id,
                                );
                                widget.applyFilters(filters);
                              },
                              child: const Text('Apply'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownWidget extends StatefulWidget {
  final List<Organisation> items;
  final void Function(Organisation?)? onChange;
  final String label;
  final bool? isInitial;
  final Organisation? initialValue; // in case value is not updating in the UI
  final bool? shouldUpdate; // New parameter to control update

  const DropdownWidget({
    super.key,
    required this.items,
    required this.onChange,
    required this.label,
    this.shouldUpdate, // Required parameter
    this.isInitial,
    this.initialValue,
  });

  @override
  DropdownWidgetState createState() => DropdownWidgetState();
}

class DropdownWidgetState extends State<DropdownWidget> {
  Organisation? selectedElement;

  @override
  void initState() {
    super.initState();
// Initialize selectedElement with the first item if isInitial is false
    selectedElement = widget.isInitial ?? true
        ? null
        : widget.items.isNotEmpty
        ? widget.items.first
        : null;
    if (widget.initialValue != null) {
      selectedElement = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Expanded(
    //   child: DropdownButtonFormField<Organisation>(
    //     initialValue: selectedElement,
    //     hint: Text(widget.label),
    //     // onChanged: widget.onChange,
    //     onChanged: (Organisation? newValue) {
    //       if (widget.shouldUpdate ?? false) {
    //         setState(() {
    //           selectedElement = newValue;
    //         });
    //       }
    //       if (widget.onChange != null) {
    //         widget.onChange!(newValue);
    //       }
    //     },
    //     items: widget.items.map((item) {
    //       return DropdownMenuItem<Organisation>(
    //         value: item,
    //         child: Text(item.name ?? ''),
    //       );
    //     }).toList(),
    //     decoration: const InputDecoration(
    //       focusedBorder: UnderlineInputBorder(
    //         borderSide: BorderSide(
    //           color: AppColors.navigationSkyBlueColor,
    //         ),
    //       ),
    //     ),
    //
    //   ),
    // );
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12), // Frosted white tint
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.25),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.15),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
          // Glass blur
          backgroundBlendMode: BlendMode.overlay,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonFormField<Organisation>(
                value: selectedElement,
                hint: Text(
                  widget.label,
                  style: const TextStyle(color: Colors.white),
                ),
                dropdownColor: Colors.white.withValues(alpha: 0.1), // glass dropdown
                iconEnabledColor: Colors.white,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                onChanged: (Organisation? newValue) {
                  if (widget.shouldUpdate ?? false) {
                    setState(() {
                      selectedElement = newValue;
                    });
                  }
                  widget.onChange?.call(newValue);
                },
                items: widget.items.map((item) {
                  return DropdownMenuItem<Organisation>(
                    value: item,
                    child: Text(
                      item.name ?? '',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
}

