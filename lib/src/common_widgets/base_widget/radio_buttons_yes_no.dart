import 'package:db_atom/index.dart';


class RadioButtonsYesNo extends StatelessWidget {
  const RadioButtonsYesNo({
    super.key,
    required this.status,
    required this.selectedValue,
    required this.onChangedYes,
    required this.onChangedNo,
    this.isEvent
  });

  final int status;
  final int? selectedValue;
  final Function(int?)? onChangedYes;
  final Function(int?)? onChangedNo;
  final bool? isEvent;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = status == -1 || status == 10;

    return Theme(
      data: Theme.of(context).copyWith(
        // controls border ring color for unselected radios
        unselectedWidgetColor: isDisabled ? Colors.red : Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio<int>(
            value: 1,
            groupValue: selectedValue,
            onChanged: onChangedYes, // parent already handles disabling
            fillColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey; // fill when disabled
                }
                if (states.contains(WidgetState.selected)) {
                  return isDisabled ? Colors.grey : Colors.white;
                }
                return isDisabled ? Colors.grey : Colors.white;
              },
            ),
          ),
          Text(
            isEvent == true ? 'Internal': Constants.yes,
            style: isDisabled
                ? Styles.textStyleBlack14.copyWith(color: Colors.grey)
                : Styles.textStyleWhite14,
          ),
          Radio<int>(
            value: 0,
            groupValue: selectedValue,
            onChanged: onChangedNo,
            fillColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey;
                }
                if (states.contains(WidgetState.selected)) {
                  return isDisabled ? Colors.grey : Colors.white;
                }
                return isDisabled ? Colors.grey : Colors.white;
              },
            ),
          ),
          Text(
            isEvent == true ? 'External': Constants.no,
            style: isDisabled
                ? Styles.textStyleBlack14.copyWith(color: Colors.grey)
                : Styles.textStyleWhite14,
          ),
        ],
      ),
    );
  }


}
