import 'dart:developer';

import 'package:db_atom/index.dart';

class DutyPostListWidget extends StatelessWidget {
  final List<DutyPostModel> dutyPosts;
  final Function(int? id, int? dutyPostNameId, DutyPostModel dutyPostModel)
      onTap;

  const DutyPostListWidget({
    super.key,
    required this.dutyPosts,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dutyPosts.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(dutyPosts[index].name ?? ''),
          trailing: const Icon(Icons.arrow_right),
          onTap: () {
            log('-dutyPosts[index].id--${dutyPosts[index].id}---');
            log('-dutyPosts[index].id--${dutyPosts[index].name}---');
            onTap(dutyPosts[index].id, dutyPosts[index].dutyPostNameId,
                dutyPosts[index]);
          },
        );
      },
    );
  }
}
