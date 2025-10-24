import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/arlanto_ai_chat_assistance/ai_chat_details/views/ai_chat_details_view.dart';

class AiChatListView extends StatefulWidget {
  const AiChatListView({super.key});

  @override
  State<AiChatListView> createState() => _AiChatListViewState();
}

class _AiChatListViewState extends State<AiChatListView> {
  // Sample chat history records
  final List<Map<String, dynamic>> _chatHistory = [
    {
      'title': 'General Inquiry',
      'lastMessage': 'Tell me a joke.',
      'messagesCount': 4,
      'date': DateTime.now().subtract(const Duration(days: 0)),
    },
    {
      'title': 'Support Chat',
      'lastMessage': 'How do I reset my password?',
      'messagesCount': 6,
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'title': 'AI Tips',
      'lastMessage': 'Give me tips to improve productivity.',
      'messagesCount': 3,
      'date': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'title': 'Atom Tips',
      'lastMessage': 'Give me tips to improve productivity.',
      'messagesCount': 3,
      'date': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'title': 'Atom Support',
      'lastMessage': 'Describe the full flow of Annual Power Shutdown module with all the functionality..',
      'messagesCount': 3,
      'date': DateTime.now().subtract(const Duration(days: 2)),
    },
  ];

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        isTitleCenter: true,
        title: "AI Chat Assistance",
        backgroundColour: Color(0xFF0C001C),
        backBtn: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
        ),
      ),
      floatingActionButton: Flutterfloatingbutton(
        backgroundColor: AppColors.navigationSkyBlueColor,
        foregroundColor: AppColors.backgroundWhiteColor,
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AiChatDetailsView(),
            ),
          ),
        },
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0C001C), Color(0xFF0C001C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: _chatHistory.length,
          itemBuilder: (context, index) {
            final record = _chatHistory[index];
            final bool isUser = record['isUser'] ?? false;

            final Color userColor = const Color(0xFF00FFF7);
            final Color botColor = Colors.white;
            final Color bubbleColor = isUser ? userColor : botColor;
            const Color mainNeon = Color(0xFF00FFF7);

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AiChatDetailsView(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  // decoration: BoxDecoration(
                  //   gradient: LinearGradient(
                  //     colors:
                  //     // isUser
                  //     //     ?
                  //         [
                  //       userColor.withOpacity(0.28),
                  //       userColor.withOpacity(0.11),
                  //     ],
                  //
                  //     //     : [
                  //     //   botColor.withOpacity(0.28),
                  //     //   botColor.withOpacity(0.11),
                  //     // ],
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //   ),
                  //   borderRadius: BorderRadius.circular(18),
                  //   border: Border.all(
                  //     color: bubbleColor.withOpacity(0.55),
                  //     width: 1.2,
                  //   ),
                  // ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        mainNeon.withOpacity(0.18),
                        Colors.transparent,
                        mainNeon.withOpacity(0.14)
                      ],
                      stops: [0.02, 0.35, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(27),
                    border: Border.all(
                      color: mainNeon.withOpacity(0.30),
                      width: 0.8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: mainNeon.withOpacity(0.09),
                        blurRadius: 12,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              record['title'],
                              style: TextStyle(
                                color: bubbleColor.withOpacity(0.89),
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                shadows: [
                                  Shadow(
                                    color: bubbleColor.withOpacity(0.20),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${record['lastMessage']} • ${record['messagesCount']} messages",
                              style: TextStyle(
                                color: bubbleColor.withOpacity(0.75),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        formatDate(record['date']),
                        style: TextStyle(
                          color: bubbleColor.withOpacity(0.54),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )


      ),
    );
  }
}
