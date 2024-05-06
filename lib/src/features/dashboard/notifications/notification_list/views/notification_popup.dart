import 'package:db_atom/index.dart';

class NotificationPopUpItems extends StatefulWidget {
  final List<Label>? labels;

  @override
  State<NotificationPopUpItems> createState() => _NotificationPopUpItemsState();

  const NotificationPopUpItems({
    super.key,
    this.labels,
  });
}

class _NotificationPopUpItemsState extends State<NotificationPopUpItems> {
  final bool isBasePopUpField = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const ShapeDecoration(
            color: AppColors.backgroundWhiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            )),
        // color: Colors.white,
        height: height / 3.8,
        width: width - 30,
        child:
            // Row(
            //  children: [
            SingleChildScrollView(
          child: Column(
            children: getChildren(context, widget.labels),
          ),
        ),
      ),
    );
  }

  List<Widget> getChildren(BuildContext context, List<Label>? labels) {
    List<Widget> widgets = [];

    widgets = [
      Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(AppIcon.closeicon) //Icon(Icons.cancel)
            ),
      ),
      const Row(
        children: [
          Text(
            'Incoming Material Record Added.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Utils().textHandling(
            'Material Movement Inward has 5 Records and \n Material Movement Outward has 8 records.',
            '',
          ),
        ],
      ),
    ];
    for (Label label in labels ?? []) {
      if (label.value == 'null' ||
          label.value.isEmpty ||
          isBasePopUpField == true) {
        continue;
      }
      widgets.add(CommonWidgets.verticalSpacerWidget(5));
      widgets.add(
        Row(
          children: [
            Utils().textHandling('${label.key} : ', label.value),
          ],
        ),
      );
    }
    widgets.add(CommonWidgets.verticalSpacerWidget(20));
    widgets.add(
      AppButton(
        
        width: 100,
        backgroundColor: Colors.white,
        key: const Key(Keys.cancelButton),
        buttonText: Constants.open,
        buttonTextKey: Keys.cancelButton,
        onTap: () {
          //Navigator.pop(context);
          Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
              arguments: {"isInward": true});
        },
      ),
    );
    return widgets;
  }
}
