import 'package:db_atom/index.dart';

class BaseLocationDropdown {
  Widget locationWidgetDisplay({
    required BuildContext context,
    required Locations locations,
    required String selectedLocationName,
    required Function onTap,
    bool isEnabled = true,
  }) {
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.7, // Adjust opacity based on isEnabled
      child: GestureDetector(
        onTap: isEnabled
            ? () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return CustomExpansionListTexts(
                      locationList: locations,
                      onTap: onTap,
                    );
                  },
                );
              }
            : null, // Set onTap to null if isEnabled is false
        child: SelectedTileValueWidget(name: selectedLocationName),
      ),
    );
  }
}
