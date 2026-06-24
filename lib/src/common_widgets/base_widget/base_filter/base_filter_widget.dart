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
              margin: const EdgeInsets.only(left: 10, right: 1), //  SAME WIDTH AS DATE INPUT
              height: 45,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.7),
                  width: 1,
                ),
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
              margin: const EdgeInsets.only(left: 5, right: 10), //  SAME WIDTH AS DATE INPUT
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(5),
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
    // 'From Date',
    // 'To Date',
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
      // fromDate = null;
      // toDate = null;
      filteredLocations = [];
    });
  }

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
            unselectedWidgetColor: Colors.white, //  black deselected radio
          ),
          child: RadioListTile<Organisation>(
            contentPadding: EdgeInsets.zero,
            title: Text(
              e.name ?? '',
              style: const TextStyle(color: Colors.white),
            ),
            value: e,
            groupValue: selected,
            activeColor: Colors.white, //  white when selected
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
      // case 'From Date':
      //   return _buildDatePicker('From Date', fromDate, (val) => setState(() => fromDate = val));
      // case 'To Date':
      //   return _buildDatePicker('To Date', toDate, (val) => setState(() => toDate = val));
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
        fillColor: Colors.transparent.withValues(alpha: 0.15),
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
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent.withValues(alpha: 0.2),
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

                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return SingleChildScrollView(
                                  padding: const EdgeInsets.all(16),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: constraints.maxHeight,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        color: AppColors.newColor.withValues(alpha: 0.08),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.white.withValues(alpha: 0.3),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          _buildTabContent(),
                                        ],
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
                        color: AppColors.newColor.withValues(alpha: 0.1),
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
                                backgroundColor: AppColors.newColor.withValues(alpha: 0.5),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),   side: const BorderSide(
                                  color: Colors.white,   //  WHITE BORDER
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
//     return Expanded(
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(18),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(18),
//               color: Colors.white.withValues(alpha: 0.08), //  glass tint
//               border: Border.all(
//                 color: Colors.white.withValues(alpha: 0.35),
//                 width: 1.2,
//               ),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 14),
//             child: Theme(
//               //  removes ugly default dropdown background
//               data: Theme.of(context).copyWith(
//                 //  DO NOT use white here
//                 canvasColor: Colors.white,
//                 splashColor: Colors.white,
//                 highlightColor: Colors.white,
//               ),
//               child: DropdownButtonFormField<Organisation>(
//                 initialValue: selectedElement,
//                 isExpanded: false,
//                 iconEnabledColor: Colors.white,
//                 dropdownColor: AppColors.newColor3.withValues(alpha: 0.6),
//                 hint: Text(
//                   widget.label,
//                   style: const TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(vertical: 14),
//                 ),
//                 onChanged: (Organisation? newValue) {
//                   if (widget.shouldUpdate ?? false) {
//                     setState(() => selectedElement = newValue);
//                   }
//                   widget.onChange?.call(newValue);
//                 },
//                 items: widget.items.map((item) {
//                   return DropdownMenuItem<Organisation>(
//                     value: item,
//                     child: Text(
//                       item.name ?? '',
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }
//
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

  void _showOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _removeOverlay, // tap outside to dismiss
        child: Stack(
          children: [
            // invisible full screen barrier
            Positioned.fill(child: Container(color: Colors.transparent)),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 6), // appear just below field
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {}, // prevent tap-through
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        width: size.width,
                        constraints: const BoxConstraints(maxHeight: 250),
                        decoration: BoxDecoration(
                          color:  Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.55),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.newColor.withValues(alpha: 0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // X close button
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: _removeOverlay,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 12),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white.withValues(alpha: 0.7),
                                    size: 26,
                                  ),
                                ),
                              ),
                            ),
                            // Items
                            Flexible(
                              child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 8),
                                shrinkWrap: true,
                                itemCount: widget.items.length,
                                itemBuilder: (context, index) {
                                  final item = widget.items[index];
                                  final isSelected =
                                      selectedElement?.id == item.id;
                                  return InkWell(
                                    onTap: () {
                                      setState(() => selectedElement = item);
                                      widget.onChange?.call(item);
                                      _removeOverlay();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 14,
                                      ),
                                      child: Text(
                                        item.name ?? '',
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.white.withValues(
                                              alpha: 0.85),
                                          fontSize: 15,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
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
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _toggleOverlay() {
    if (_overlayEntry != null) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CompositedTransformTarget(
        link: _layerLink,
        child: GestureDetector(
          onTap:  _toggleOverlay,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white.withValues(alpha: 0.08),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                    width: 1.2,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedElement?.name ?? widget.label,
                        style: TextStyle(
                          color: selectedElement != null
                              ? Colors.white
                              : Colors.white70,
                          fontSize: selectedElement != null ? 15 : 14,
                          fontWeight: selectedElement != null
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      _overlayEntry != null
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}