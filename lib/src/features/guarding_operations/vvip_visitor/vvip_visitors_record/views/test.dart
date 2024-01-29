import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  const MultiSelectDropdown({super.key});

  @override
  MultiSelectDropdownState createState() => MultiSelectDropdownState();
}

class MultiSelectDropdownState extends State<MultiSelectDropdown> {
  final List<String> _selectedItems = [];
  final List<String> _customValues = [];
  final TextEditingController _customValueController = TextEditingController();

  final _items = List.generate(
    10,
        (index) => 'Item $index',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Select Dropdown'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: [
                    ..._selectedItems.map(
                          (item) => Chip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(item),
                            IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _selectedItems.remove(item);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    ..._customValues.map(
                          (customValue) => Chip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(customValue),
                            IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _customValues.remove(customValue);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Select Items',
                border: OutlineInputBorder(),
              ),
              value: null,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    if (!_selectedItems.contains(value) && !_customValues.contains(value)) {
                      _selectedItems.add(value);
                    }
                  });
                }
              },
              items: _items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _customValueController,
              decoration: const InputDecoration(
                labelText: 'Add Custom Value',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String customValue = _customValueController.text.trim();
                if (customValue.isNotEmpty && !_selectedItems.contains(customValue) && !_customValues.contains(customValue)) {
                  setState(() {
                    _customValues.add(customValue);
                    _customValueController.clear();
                  });
                }
              },
              child: const Text('Add Custom Value'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MultiSelectDropdown(),
  ));
}
