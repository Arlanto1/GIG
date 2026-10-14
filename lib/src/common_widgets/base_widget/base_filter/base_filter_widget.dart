// import '../../../../index.dart';
// import 'dart:ui';
//
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
//
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
//               margin: const EdgeInsets.only(left: 10, right: 1), //  SAME WIDTH AS DATE INPUT
//               height: 45,
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Colors.white,
//                     Colors.white,
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: Colors.black.withValues(alpha: 0.7),
//                   width: 1,
//                 ),
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
//               margin: const EdgeInsets.only(left: 5, right: 10), //  SAME WIDTH AS DATE INPUT
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
//
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
//     // 'From Date',
//     // 'To Date',
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
//       // fromDate = null;
//       // toDate = null;
//       filteredLocations = [];
//     });
//   }
//
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
//             unselectedWidgetColor: Colors.white, //  black deselected radio
//           ),
//           child: RadioListTile<Organisation>(
//             contentPadding: EdgeInsets.zero,
//             title: Text(
//               e.name ?? '',
//               style: const TextStyle(color: Colors.white),
//             ),
//             value: e,
//             groupValue: selected,
//             activeColor: Colors.white, //  white when selected
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
//       // case 'From Date':
//       //   return _buildDatePicker('From Date', fromDate, (val) => setState(() => fromDate = val));
//       // case 'To Date':
//       //   return _buildDatePicker('To Date', toDate, (val) => setState(() => toDate = val));
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
//         fillColor: Colors.transparent.withValues(alpha: 0.15),
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
//               decoration: const BoxDecoration(
//                 color: Colors.transparent,
//               ),
//             ),
//             BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.transparent.withValues(alpha: 0.2),
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
//                           Expanded(
//                             child: LayoutBuilder(
//                               builder: (context, constraints) {
//                                 return SingleChildScrollView(
//                                   padding: const EdgeInsets.all(16),
//                                   child: ConstrainedBox(
//                                     constraints: BoxConstraints(
//                                       minHeight: constraints.maxHeight,
//                                     ),
//                                     child: Container(
//                                       padding: const EdgeInsets.all(0),
//                                       decoration: BoxDecoration(
//                                         color: AppColors.newColor.withValues(alpha: 0.08),
//                                         borderRadius: BorderRadius.circular(16),
//                                         border: Border.all(
//                                           color: Colors.white.withValues(alpha: 0.3),
//                                         ),
//                                       ),
//                                       child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         children: [
//                                           _buildTabContent(),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     ),
//
//                     // Bottom buttons
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       decoration: BoxDecoration(
//                         color: AppColors.newColor.withValues(alpha: 0.1),
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
//                                 backgroundColor: AppColors.newColor.withValues(alpha: 0.5),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),   side: const BorderSide(
//                                   color: Colors.white,   //  WHITE BORDER
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
// //         ? widget.items.first
// //         : null;
// //     if (widget.initialValue != null) {
// //       selectedElement = widget.initialValue;
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Expanded(
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(18),
// //         child: BackdropFilter(
// //           filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
// //           child: Container(
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(18),
// //               color: Colors.white.withValues(alpha: 0.08), //  glass tint
// //               border: Border.all(
// //                 color: Colors.white.withValues(alpha: 0.35),
// //                 width: 1.2,
// //               ),
// //             ),
// //             padding: const EdgeInsets.symmetric(horizontal: 14),
// //             child: Theme(
// //               //  removes ugly default dropdown background
// //               data: Theme.of(context).copyWith(
// //                 //  DO NOT use white here
// //                 canvasColor: Colors.white,
// //                 splashColor: Colors.white,
// //                 highlightColor: Colors.white,
// //               ),
// //               child: DropdownButtonFormField<Organisation>(
// //                 initialValue: selectedElement,
// //                 isExpanded: false,
// //                 iconEnabledColor: Colors.white,
// //                 dropdownColor: AppColors.newColor3.withValues(alpha: 0.6),
// //                 hint: Text(
// //                   widget.label,
// //                   style: const TextStyle(
// //                     color: Colors.white70,
// //                     fontSize: 14,
// //                   ),
// //                 ),
// //                 style: const TextStyle(
// //                   color: Colors.white,
// //                   fontSize: 15,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //                 decoration: const InputDecoration(
// //                   border: InputBorder.none,
// //                   contentPadding: EdgeInsets.symmetric(vertical: 14),
// //                 ),
// //                 onChanged: (Organisation? newValue) {
// //                   if (widget.shouldUpdate ?? false) {
// //                     setState(() => selectedElement = newValue);
// //                   }
// //                   widget.onChange?.call(newValue);
// //                 },
// //                 items: widget.items.map((item) {
// //                   return DropdownMenuItem<Organisation>(
// //                     value: item,
// //                     child: Text(
// //                       item.name ?? '',
// //                       overflow: TextOverflow.ellipsis,
// //                       style: const TextStyle(
// //                         color: Colors.white,
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                   );
// //                 }).toList(),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// // }
// //
// class DropdownWidgetState extends State<DropdownWidget> {
//   Organisation? selectedElement;
//   OverlayEntry? _overlayEntry;
//   final LayerLink _layerLink = LayerLink();
//
//   @override
//   void initState() {
//     super.initState();
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
//   void dispose() {
//     _removeOverlay();
//     super.dispose();
//   }
//
//   void _removeOverlay() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }
//
//   void _showOverlay() {
//     final RenderBox renderBox = context.findRenderObject() as RenderBox;
//     final size = renderBox.size;
//
//     _overlayEntry = OverlayEntry(
//       builder: (context) => GestureDetector(
//         behavior: HitTestBehavior.translucent,
//         onTap: _removeOverlay, // tap outside to dismiss
//         child: Stack(
//           children: [
//             // invisible full screen barrier
//             Positioned.fill(child: Container(color: Colors.transparent)),
//             CompositedTransformFollower(
//               link: _layerLink,
//               showWhenUnlinked: false,
//               offset: Offset(0, size.height + 6), // appear just below field
//               child: Material(
//                 color: Colors.transparent,
//                 child: GestureDetector(
//                   onTap: () {}, // prevent tap-through
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(16),
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
//                       child: Container(
//                         width: size.width,
//                         constraints: const BoxConstraints(maxHeight: 250),
//                         decoration: BoxDecoration(
//                           color:  Colors.transparent,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(
//                             color: Colors.white.withValues(alpha: 0.55),
//                             width: 2,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: AppColors.newColor.withValues(alpha: 0.3),
//                               blurRadius: 20,
//                               offset: const Offset(0, 8),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             // X close button
//                             Align(
//                               alignment: Alignment.topRight,
//                               child: GestureDetector(
//                                 onTap: _removeOverlay,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       top: 10, right: 12),
//                                   child: Icon(
//                                     Icons.close,
//                                     color: Colors.white.withValues(alpha: 0.7),
//                                     size: 26,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             // Items
//                             Flexible(
//                               child: ListView.builder(
//                                 padding: const EdgeInsets.only(bottom: 8),
//                                 shrinkWrap: true,
//                                 itemCount: widget.items.length,
//                                 itemBuilder: (context, index) {
//                                   final item = widget.items[index];
//                                   final isSelected =
//                                       selectedElement?.id == item.id;
//                                   return InkWell(
//                                     onTap: () {
//                                       setState(() => selectedElement = item);
//                                       widget.onChange?.call(item);
//                                       _removeOverlay();
//                                     },
//                                     child: Container(
//                                       width: double.infinity,
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 20,
//                                         vertical: 14,
//                                       ),
//                                       child: Text(
//                                         item.name ?? '',
//                                         style: TextStyle(
//                                           color: isSelected
//                                               ? Colors.white
//                                               : Colors.white.withValues(
//                                               alpha: 0.85),
//                                           fontSize: 15,
//                                           fontWeight: isSelected
//                                               ? FontWeight.w600
//                                               : FontWeight.w400,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//     Overlay.of(context).insert(_overlayEntry!);
//   }
//
//   void _toggleOverlay() {
//     if (_overlayEntry != null) {
//       _removeOverlay();
//     } else {
//       _showOverlay();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: CompositedTransformTarget(
//         link: _layerLink,
//         child: GestureDetector(
//           onTap:  _toggleOverlay,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(18),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(18),
//                   color: Colors.white.withValues(alpha: 0.08),
//                   border: Border.all(
//                     color: Colors.white.withValues(alpha: 0.35),
//                     width: 1.2,
//                   ),
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 14, vertical: 14),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         selectedElement?.name ?? widget.label,
//                         style: TextStyle(
//                           color: selectedElement != null
//                               ? Colors.white
//                               : Colors.white70,
//                           fontSize: selectedElement != null ? 15 : 14,
//                           fontWeight: selectedElement != null
//                               ? FontWeight.w600
//                               : FontWeight.w400,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     Icon(
//                       _overlayEntry != null
//                           ? Icons.arrow_drop_up
//                           : Icons.arrow_drop_down,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import '../../../../index.dart';

/// Shared visual theme for the search bar, filter drawer and dropdown.
class _Ui {
  static const Color navy = Color(0xFF1A0B6B);
  static const Color navyDark = Color(0xFF0B0545);
  static const Color gold = Color(0xFFD4A98A);
  static const Color goldLight = Color(0xFFE9CDB6);
  static const Color bodyBg = Color(0xFFF4F3FB);
  static const Color cardBorder = Color(0xFFE6E3F5);

  static const LinearGradient navyGradient = LinearGradient(
    colors: [navy, navyDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const TextStyle itemStyle = TextStyle(
    color: navy,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: navy.withValues(alpha: 0.08),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
}

// ---------------------------------------------------------------------------
// Search bar + filter button
// ---------------------------------------------------------------------------

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
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    final filterCriteriaModel = FilterCriteria();
    filterCriteriaModel.all = searchController.text;
    widget.applySearchFilters(filterCriteriaModel);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 1),
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _Ui.gold, width: 1.2),
                boxShadow: _Ui.softShadow,
              ),
              child: TextField(
                controller: searchController,
                style: const TextStyle(
                  color: _Ui.navy,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: _Ui.navy.withValues(alpha: 0.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  suffixIcon: InkWell(
                    onTap: _onSearch,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: _Ui.navyGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 20,
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
              margin: const EdgeInsets.only(left: 5, right: 10),
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                gradient: _Ui.navyGradient,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _Ui.gold, width: 1.2),
              ),
              child: const Icon(Icons.tune, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showRightFilterDrawer(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      barrierColor: Colors.black.withValues(alpha: 0.35),
      pageBuilder: (context, animation1, animation2) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                bottomLeft: Radius.circular(28),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: FilterDrawerWidget(
                  applyFilters: widget.applyFilters,
                  commonFilters: widget.commonFilters,
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation1, curve: Curves.easeOutCubic),
          ),
          child: child,
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Filter drawer
// ---------------------------------------------------------------------------

class _FilterTab {
  final String title;
  final IconData icon;
  final String subtitle;

  const _FilterTab(this.title, this.icon, this.subtitle);
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
  int selectedTabIndex = 0;
  final TextEditingController idController = TextEditingController();
  final TextEditingController createdByController = TextEditingController();

  Organisation? selectedRegion;
  Organisation? selectedLocation;
  Organisation? selectedStatus;
  DateTime? fromDate;
  DateTime? toDate;
  List<Organisation> filteredLocations = [];

  final List<_FilterTab> tabs = const [
    _FilterTab('ID', Icons.tag_rounded, 'Find a record by its ID'),
    _FilterTab('Created By', Icons.person_outline_rounded, 'Who created it'),
    _FilterTab('Region', Icons.public_rounded, 'Pick a region'),
    _FilterTab('Location', Icons.location_on_outlined, 'Pick a location'),
    _FilterTab('Status', Icons.track_changes, 'Choose a status'),
  ];

  _FilterTab get _currentTab => tabs[selectedTabIndex];

  @override
  void dispose() {
    idController.dispose();
    createdByController.dispose();
    super.dispose();
  }

  // ---------- Filter state helpers ----------

  String? _valueOf(String tab) {
    switch (tab) {
      case 'ID':
        final v = idController.text.trim();
        return v.isEmpty ? null : v;
      case 'Created By':
        final v = createdByController.text.trim();
        return v.isEmpty ? null : v;
      case 'Region':
        return selectedRegion?.name;
      case 'Location':
        return selectedLocation?.name;
      case 'Status':
        return selectedStatus?.name;
    }
    return null;
  }

  List<MapEntry<_FilterTab, String>> get _activeEntries {
    final entries = <MapEntry<_FilterTab, String>>[];
    for (final tab in tabs) {
      final value = _valueOf(tab.title);
      if (value != null) entries.add(MapEntry(tab, value));
    }
    return entries;
  }

  void _clearTab(String tab) {
    setState(() {
      switch (tab) {
        case 'ID':
          idController.clear();
          break;
        case 'Created By':
          createdByController.clear();
          break;
        case 'Region':
          selectedRegion = null;
          selectedLocation = null;
          filteredLocations = [];
          break;
        case 'Location':
          selectedLocation = null;
          break;
        case 'Status':
          selectedStatus = null;
          break;
      }
    });
  }

  void clearFilters() {
    setState(() {
      idController.clear();
      createdByController.clear();
      selectedRegion = null;
      selectedLocation = null;
      selectedStatus = null;
      filteredLocations = [];
    });
  }

  void _onApply() {
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
  }

  // ---------- Header ----------

  Widget _buildHeader(int activeCount) {
    return ClipRect(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          20,
          MediaQuery.of(context).padding.top + 16,
          16,
          18,
        ),
        decoration: const BoxDecoration(gradient: _Ui.navyGradient),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // decorative circles
            Positioned(
              right: -50,
              top: -60,
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),
            Positioned(
              right: 40,
              bottom: -50,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _Ui.gold.withValues(alpha: 0.12),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [_Ui.goldLight, _Ui.gold],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _Ui.gold.withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.tune, color: Colors.white),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REFINE',
                        style: TextStyle(
                          color: _Ui.gold,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        'Filters',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                if (activeCount > 0) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _Ui.gold,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$activeCount active',
                      style: const TextStyle(
                        color: _Ui.navyDark,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Left tab rail ----------

  Widget _buildTabRail() {
    return Container(
      width: 106,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: _Ui.cardBorder)),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = selectedTabIndex == index;
          final hasValue = _valueOf(tab.title) != null;

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => setState(() => selectedTabIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.fromLTRB(6, 12, 6, 10),
                decoration: BoxDecoration(
                  gradient: isSelected ? _Ui.navyGradient : null,
                  color: isSelected ? null : _Ui.bodyBg,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isSelected ? _Ui.gold : _Ui.cardBorder,
                    width: isSelected ? 1.2 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: _Ui.navy.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ]
                      : null,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              gradient: isSelected
                                  ? const LinearGradient(
                                colors: [_Ui.goldLight, _Ui.gold],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                                  : null,
                              color: isSelected ? null : Colors.white,
                              border: isSelected
                                  ? null
                                  : Border.all(color: _Ui.cardBorder),
                            ),
                            child: Icon(
                              tab.icon,
                              size: 20,
                              color: isSelected ? Colors.white : _Ui.navy,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            tab.title,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w700,
                              color: isSelected ? Colors.white : _Ui.navy,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // "has a value" dot
                    if (hasValue)
                      Positioned(
                        right: 0,
                        top: -4,
                        child: Container(
                          width: 11,
                          height: 11,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _Ui.gold,
                            border: Border.all(
                              color: isSelected ? _Ui.navy : Colors.white,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------- Right content panel ----------

  Widget _buildContentPanel() {
    final active = _activeEntries;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(),
          const SizedBox(height: 14),
          _buildTabContent(),
          if (active.isNotEmpty) ...[
            const SizedBox(height: 22),
            _buildActiveChips(active),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    final tab = _currentTab;
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: _Ui.navyGradient,
          ),
          child: Icon(tab.icon, color: _Ui.goldLight, size: 19),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter by ${tab.title}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _Ui.navy,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                tab.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _Ui.navy.withValues(alpha: 0.55),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActiveChips(List<MapEntry<_FilterTab, String>> active) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 14,
              decoration: BoxDecoration(
                color: _Ui.gold,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'SELECTED',
              style: TextStyle(
                color: _Ui.gold,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: active.map((entry) {
            return Container(
              padding: const EdgeInsets.fromLTRB(12, 7, 8, 7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _Ui.gold),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 120),
                    child: Text(
                      '${entry.key.title}: ${entry.value}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _Ui.navy,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => _clearTab(entry.key.title),
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: _Ui.navy,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTabContent() {
    switch (_currentTab.title) {
      case 'ID':
        return _buildTextField('Enter ID', idController, TextInputType.number);
      case 'Created By':
        return _buildTextField(
          'Enter Created By',
          createdByController,
          TextInputType.text,
        );
      case 'Region':
        return _buildOptionList(
          widget.commonFilters.regions,
          selectedRegion,
              (val) async {
            setState(() {
              selectedRegion = val;
              selectedLocation = null;
              filteredLocations = [];
            });
            final commonServices = CommonServices();
            final List<Organisation> locations =
            await commonServices.getRegionsOrLocationsByRegionId(
              id: selectedRegion?.id ?? 0,
            );
            setState(() => filteredLocations = locations);
          },
        );
      case 'Location':
        return _buildOptionList(
          filteredLocations,
          selectedLocation,
              (val) => setState(() => selectedLocation = val),
          emptyMessage: selectedRegion == null
              ? 'Select a region first'
              : 'No data',
        );
      case 'Status':
        return _buildOptionList(
          widget.commonFilters.statuses,
          selectedStatus,
              (val) => setState(() => selectedStatus = val),
        );
      default:
        return const SizedBox();
    }
  }

  // ---------- Inputs ----------

  Widget _buildTextField(
      String label,
      TextEditingController controller,
      TextInputType type,
      ) {
    OutlineInputBorder border(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: _Ui.softShadow,
      ),
      child: TextField(
        controller: controller,
        keyboardType: type,
        style: _Ui.itemStyle,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: _Ui.navy.withValues(alpha: 0.6)),
          floatingLabelStyle: const TextStyle(color: _Ui.navy),
          prefixIcon: Icon(_currentTab.icon, color: _Ui.gold, size: 22),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
            icon: Icon(
              Icons.cancel_rounded,
              color: _Ui.navy.withValues(alpha: 0.35),
              size: 20,
            ),
            onPressed: () => setState(controller.clear),
          ),
          filled: true,
          fillColor: Colors.white,
          border: border(_Ui.cardBorder),
          enabledBorder: border(_Ui.cardBorder),
          focusedBorder: border(_Ui.navy, 1.4),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _Ui.cardBorder),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _Ui.gold.withValues(alpha: 0.18),
            ),
            child: const Icon(
              Icons.inbox_outlined,
              color: _Ui.gold,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: _Ui.itemStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionList(
      List<Organisation>? list,
      Organisation? selected,
      Function(Organisation) onSelect, {
        String emptyMessage = 'No data',
      }) {
    if (list == null || list.isEmpty) {
      return _buildEmptyState(emptyMessage);
    }

    return Column(
      children: list.map((e) {
        final isSelected = selected == e;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Material(
            color: isSelected ? _Ui.navy.withValues(alpha: 0.06) : Colors.white,
            elevation: isSelected ? 0 : 1.5,
            shadowColor: _Ui.navy.withValues(alpha: 0.12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: isSelected ? _Ui.navy : _Ui.cardBorder,
                width: isSelected ? 1.4 : 1,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => onSelect(e),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        gradient: isSelected ? _Ui.navyGradient : null,
                        color: isSelected ? null : _Ui.bodyBg,
                      ),
                      child: Icon(
                        _currentTab.icon,
                        size: 18,
                        color: isSelected ? _Ui.goldLight : _Ui.navy,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        e.name ?? '',
                        style: _Ui.itemStyle.copyWith(
                          fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      isSelected
                          ? Icons.check_circle_rounded
                          : Icons.circle_outlined,
                      color: isSelected
                          ? _Ui.navy
                          : _Ui.navy.withValues(alpha: 0.25),
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ---------- Bottom buttons ----------

  Widget _buildFooter(int activeCount) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: _Ui.cardBorder)),
        boxShadow: [
          BoxShadow(
            color: _Ui.navy.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: _Ui.navy),
                  foregroundColor: _Ui.navy,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: clearFilters,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text(
                  'Clear All',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: _buildApplyButton(activeCount)),
          ],
        ),
      ),
    );
  }

  Widget _buildApplyButton(int activeCount) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: _Ui.navyGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _Ui.gold, width: 1),
        boxShadow: [
          BoxShadow(
            color: _Ui.navy.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _onApply,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_rounded, color: _Ui.goldLight, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Apply',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                if (activeCount > 0) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _Ui.gold,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$activeCount',
                      style: const TextStyle(
                        color: _Ui.navyDark,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeCount = _activeEntries.length;

    return Scaffold(
      backgroundColor: _Ui.bodyBg,
      body: Column(
        children: [
          _buildHeader(activeCount),

          // gold divider line
          Container(
            height: 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_Ui.gold, _Ui.goldLight, _Ui.gold],
              ),
            ),
          ),

          // Main body
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTabRail(),
                Expanded(child: _buildContentPanel()),
              ],
            ),
          ),

          _buildFooter(activeCount),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Dropdown
// ---------------------------------------------------------------------------

class DropdownWidget extends StatefulWidget {
  final List<Organisation> items;
  final void Function(Organisation?)? onChange;
  final String label;
  final bool? isInitial;
  final Organisation? initialValue; // in case value is not updating in the UI
  final bool? shouldUpdate;

  const DropdownWidget({
    super.key,
    required this.items,
    required this.onChange,
    required this.label,
    this.shouldUpdate,
    this.isInitial,
    this.initialValue,
  });

  @override
  DropdownWidgetState createState() => DropdownWidgetState();
}

class DropdownWidgetState extends State<DropdownWidget> {
  Organisation? selectedElement;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
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
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // Removes the overlay and refreshes the arrow icon.
  void _closeOverlay() {
    _removeOverlay();
    if (mounted) setState(() {});
  }

  void _showOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _closeOverlay, // tap outside to dismiss
        child: Stack(
          children: [
            Positioned.fill(child: Container(color: Colors.transparent)),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 6), // just below the field
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {}, // prevent tap-through
                  child: Container(
                    width: size.width,
                    constraints: const BoxConstraints(maxHeight: 260),
                    decoration: BoxDecoration(
                      color: _Ui.bodyBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _Ui.cardBorder),
                      boxShadow: [
                        BoxShadow(
                          color: _Ui.navy.withValues(alpha: 0.18),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header with close button
                          Container(
                            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                            decoration: const BoxDecoration(
                              gradient: _Ui.navyGradient,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.label,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  onPressed: _closeOverlay,
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 2,
                            color: _Ui.gold,
                          ),
                          // Items
                          Flexible(
                            child: ListView.separated(
                              padding: const EdgeInsets.all(10),
                              shrinkWrap: true,
                              itemCount: widget.items.length,
                              separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final item = widget.items[index];
                                final isSelected =
                                    selectedElement?.id == item.id;
                                return Material(
                                  color: isSelected
                                      ? _Ui.navy.withValues(alpha: 0.06)
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    side: BorderSide(
                                      color: isSelected
                                          ? _Ui.navy
                                          : _Ui.cardBorder,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() => selectedElement = item);
                                      widget.onChange?.call(item);
                                      _closeOverlay();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      child: Text(
                                        item.name ?? '',
                                        style: TextStyle(
                                          color: _Ui.navy,
                                          fontSize: 15,
                                          fontWeight: isSelected
                                              ? FontWeight.w800
                                              : FontWeight.w600,
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _toggleOverlay() {
    if (_overlayEntry != null) {
      _closeOverlay();
    } else {
      _showOverlay();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = selectedElement != null;

    return Expanded(
      child: CompositedTransformTarget(
        link: _layerLink,
        child: GestureDetector(
          onTap: _toggleOverlay,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _Ui.gold, width: 1.2),
              boxShadow: _Ui.softShadow,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedElement?.name ?? widget.label,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: hasValue
                          ? _Ui.navy
                          : _Ui.navy.withValues(alpha: 0.5),
                      fontSize: hasValue ? 15 : 14,
                      fontWeight: hasValue ? FontWeight.w700 : FontWeight.w400,
                    ),
                  ),
                ),
                Icon(
                  _overlayEntry != null
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: _Ui.navy,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}