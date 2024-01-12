import 'package:db_atom/index.dart';

class BaseLocationDropdown {
  Widget locationWidgetDisplay({
    required BuildContext context,
    required Locations locations,
    required String selectedLocationName,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            // print(state.getLocationsResponse);
            return CustomExpansionListTexts(
              locationList: locations,
              onTap: onTap,
            );
          },
        );
        // }
      },
      child: SelectedTileValueWidget(name: selectedLocationName),
    );
  }
}
