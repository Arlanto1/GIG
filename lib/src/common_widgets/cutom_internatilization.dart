import 'package:db_atom/index.dart';

class ArticleDialog extends StatelessWidget {
  final List<Label> labels;
  final String title;

  const ArticleDialog({
    super.key,
    required this.labels,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Dialog(
      child: Container(
        height: height / 2.5,
        width: width - 40,
        padding: const EdgeInsets.all(20.0),
        decoration: const ShapeDecoration(
          color: AppColors.backgroundWhitecolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.navigationSkybluecolor),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: labels.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      labels[index].key,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    onTap: () async {
                      SharedPrefs.setLanguageCode(labels[index].value);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            ListTile(
              title: const Text('Dismiss',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.blue)),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
