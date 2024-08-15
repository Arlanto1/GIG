import 'package:db_atom/index.dart';

class MultiSelectDropdown extends StatefulWidget {
  const MultiSelectDropdown({
    super.key,
    required this.briefingPoints,
    required this.selectedPoints,
    required this.onSelectedBriefingPointsChanged,
  });

  final List<String> briefingPoints;
  final List<String> selectedPoints;
  final Function(List<String>) onSelectedBriefingPointsChanged;

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  final TextEditingController _customValueController = TextEditingController();
  late List<String> _selectedPoints;

  @override
  void initState() {
    super.initState();
    _selectedPoints = List.from(widget.selectedPoints); // Copy of selected points to preserve state
  }

  void _removePoint(String point) {
    setState(() {
      _selectedPoints.remove(point);
      widget.onSelectedBriefingPointsChanged(_selectedPoints);
    });
  }

  void _addPoint(String point) {
    if (point.isNotEmpty && !_selectedPoints.contains(point)) {
      setState(() {
        _selectedPoints.add(point);
        widget.onSelectedBriefingPointsChanged(_selectedPoints);
        _customValueController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: [
          if (_selectedPoints.isNotEmpty) ...[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.geryLightBackground),
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Wrap(
                  spacing: 4.0,
                  runSpacing: 2.0,
                  children: _selectedPoints.map((point) => InkWell(
                    onTap: () => _removePoint(point),
                    child: Chip(
                      label: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 1.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(point),
                            const Icon(
                              Icons.clear,
                              size: 15,
                              color: AppColors.navigationSkyBlueColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ),
            CommonWidgets.verticalSpacerWidget(
                MediaQuery.of(context).size.height * 0.01),
          ],
          DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Select Items',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.navigationSkyBlueColor,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.navigationSkyBlueColor,
                ),
              ),
            ),
            value: null,
            onChanged: (value) {
              if (value != null) {
                _addPoint(value);
              }
            },
            items: widget.briefingPoints.map((point) {
              return DropdownMenuItem<String>(
                value: point,
                child: Text(point),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: 280,
                child: TextField(
                  controller: _customValueController,
                  decoration: InputDecoration(
                    fillColor: AppColors.enableTextFieldBackground,
                    filled: true,
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.geryLightBackground, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.geryLightBackground, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: 'Add Custom Briefing Point',
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.geryLightBackground, width: 1.0),borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              AppButton(
                width: 70,
                buttonText: 'Add',
                buttonTextKey: Keys.submitButton,
                onTap: () => _addPoint(_customValueController.text.trim()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
