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
    // return ListView.builder(
    //   itemCount: dutyPosts.length,
    //   physics: const NeverScrollableScrollPhysics(),
    //   shrinkWrap: true,
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       title: Text(dutyPosts[index].name ?? ''),
    //       trailing: const Icon(Icons.arrow_right),
    //       onTap: () {
    //         log('-dutyPosts[index].id--${dutyPosts[index].id}---');
    //         log('-dutyPosts[index].id--${dutyPosts[index].name}---');
    //         onTap(dutyPosts[index].id, dutyPosts[index].dutyPostNameId,
    //             dutyPosts[index]);
    //       },
    //     );
    //   },
    // );
    return ListView.builder(
      itemCount: dutyPosts.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = dutyPosts[index];

        return GestureDetector(
          onTap: () {
            onTap(item.id, item.dutyPostNameId, item);
          },
          child: Container(
            margin: const EdgeInsets.only(
                bottom: 14, left: 20, right: 20), // 👈 SAME WIDTH AS DATE INPUT
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            // decoration: BoxDecoration(
            //   gradient: const LinearGradient(
            //     colors: [
            //       Color(0xFF6E80E8),
            //       Color(0xFF7D8FEF),
            //     ],
            //   ),
            //   borderRadius: BorderRadius.circular(40),
            //   border: Border.all(color: Colors.white.withOpacity(0.4)),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.black.withOpacity(0.1),
            //       blurRadius: 6,
            //       offset: const Offset(0, 3),
            //     )
            //   ],
            // ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.09),
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.09),
                ],
                stops: const [0.02, 0.35, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(27),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.60),
                width: 0.7,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.0),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // const Icon(Icons.calendar_today, color: Colors.white, size: 22),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item.name ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios,
                    color: Colors.white, size: 18),
              ],
            ),
          ),
        );
      },
    );
  }
}
