// // import 'dart:developer';
// //
// // import 'package:db_atom/index.dart';
// // import 'package:flutter_tts/flutter_tts.dart';
// // import 'package:speech_to_text/speech_to_text.dart' as stt;
// //
// // class AiChatDetailsView extends StatefulWidget {
// //   const AiChatDetailsView({super.key});
// //
// //   @override
// //   State<AiChatDetailsView> createState() => _AiChatDetailsViewState();
// // }
// //
// // class _AiChatDetailsViewState extends State<AiChatDetailsView> {
// //   final stt.SpeechToText _speech = stt.SpeechToText();
// //   final FlutterTts _flutterTts = FlutterTts();
// //   final TextEditingController _controller = TextEditingController();
// //
// //   bool _available = false;
// //   bool _isListening = false;
// //
// //   // Changed: store both text and sender
// //   final List<Map<String, String>> _messages = [];
// //   String generateBotReply(String userInput) {
// //     // Later, replace this with actual AI logic or API call
// //     return "\"$userInput\"";
// //   }
// //
// //
// //   @override
// //   // void initState() {
// //   //   super.initState();
// //   //   initSpeech();
// //   //   initTts();
// //   //
// //   //   // Test voice on launch
// //   //   WidgetsBinding.instance.addPostFrameCallback((_) {
// //   //     _flutterTts.speak("TTS test: voice output is working.");
// //   //     log('voice');
// //   //   });
// //   //
// //   // }
// //   @override
// //   void initState() {
// //     super.initState();
// //     initSpeech();
// //     initTts();
// //     _flutterTts.setSharedInstance(true); // optional but helps on some devices
// //     // Wait for plugin registration to finish
// //     WidgetsBinding.instance.addPostFrameCallback((_) async {
// //       await Future.delayed(const Duration(milliseconds: 300));
// //       await _flutterTts.speak("TTS test: voice output is working.");
// //       log('voice initialized');
// //     });
// //   }
// //
// //
// //   void initTts() {
// //     _flutterTts.setLanguage("en-US");
// //     _flutterTts.setPitch(1.0);
// //     _flutterTts.setSpeechRate(0.5);
// //     _flutterTts.awaitSpeakCompletion(true);
// //
// //     _flutterTts.setStartHandler(() {
// //       log("✅ TTS started");
// //     });
// //
// //     _flutterTts.setCompletionHandler(() {
// //       log("✅ TTS completed");
// //     });
// //
// //     _flutterTts.setErrorHandler((msg) {
// //       log("❌ TTS error: $msg");
// //     });
// //   }
// //
// //   Future<void> safeStopTts() async {
// //     try {
// //       await _flutterTts.stop();
// //     } catch (e) {
// //       log("⚠️ FlutterTTS stop error: $e");
// //     }
// //   }
// //
// //
// //   Future<void> initSpeech() async {
// //     _available = await _speech.initialize(
// //       onStatus: (status) {
// //         debugPrint("Status: $status");
// //         setState(() {
// //           _isListening = status == 'listening';
// //         });
// //       },
// //       onError: (error) => debugPrint("Error: $error"),
// //     );
// //     setState(() {});
// //   }
// //   void listen() async {
// //     if (!_available) return;
// //
// //     // Stop any current TTS
// //     await safeStopTts();
// //
// //     // Start listening
// //      await _speech.listen(
// //       onResult: (result) async {
// //         if (result.finalResult && result.recognizedWords.isNotEmpty) {
// //           final userInput = result.recognizedWords;
// //           final botReply = generateBotReply(userInput);
// //
// //           setState(() {
// //             _messages.add({'text': userInput, 'sender': 'user'});
// //             _messages.add({'text': botReply, 'sender': 'bot'});
// //           });
// //
// //           log("🗣️ User: $userInput");
// //           log("🤖 Bot: $botReply");
// //
// //           await _speech.stop();
// //           await Future.delayed(const Duration(milliseconds: 500));
// //           await _flutterTts.speak(botReply);
// //         }
// //       },
// //       // listenFor: const Duration(seconds: 10),
// //       pauseFor: const Duration(seconds: 2),
// //     );
// //   }
// //
// //   void sendMessage(String text) async {
// //     if (text.trim().isEmpty) return;
// //
// //     final userInput = text.trim();
// //     final botReply = generateBotReply(userInput);
// //
// //     setState(() {
// //       _messages.add({
// //         'text': userInput,
// //         'sender': 'user',
// //       });
// //       _messages.add({
// //         'text': botReply,
// //         'sender': 'bot',
// //       });
// //       _controller.clear();
// //     });
// //
// //     await safeStopTts();
// //     await _flutterTts.speak(botReply);
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppHeader(
// //         title: "AI Chat Assistance",
// //         isTitleCenter: true,
// //         backBtn: IconButton(
// //           onPressed: () => Navigator.pop(context),
// //           icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
// //         ),
// //       ),
// //       body: Container(
// //         // ✅ Full background image
// //         decoration: const BoxDecoration(
// //           image: DecorationImage(
// //             image: AssetImage('assets/images/ai.png'),
// //             opacity: 1,
// //             fit: BoxFit.cover, // Makes it fill the entire background
// //           ),
// //         ),
// //         child: Column(
// //           children: [
// //             Expanded(
// //               child: Stack(
// //                 children: [
// //                   // Optional: keep a faint center image overlay if you want
// //                   // Center(
// //                   //   child: Opacity(
// //                   //     opacity: 0.03,
// //                   //     child: Image.asset(
// //                   //       'assets/images/ai_chat_background.png',
// //                   //       width: 250,
// //                   //       height: 250,
// //                   //     ),
// //                   //   ),
// //                   // ),
// //                   ListView.builder(
// //                     padding: const EdgeInsets.all(12),
// //                     itemCount: _messages.length,
// //                     itemBuilder: (context, index) {
// //                       final message = _messages[index];
// //                       final isUser = message['sender'] == 'user';
// //                       return Align(
// //                         alignment: isUser
// //                             ? Alignment.centerRight
// //                             : Alignment.centerLeft,
// //                         child: Container(
// //                           padding: const EdgeInsets.symmetric(
// //                             vertical: 14,
// //                             horizontal: 14,
// //                           ),
// //                           margin: const EdgeInsets.symmetric(vertical: 6),
// //                           decoration: BoxDecoration(
// //                             color: isUser
// //                                 ? AppColors.black
// //                             :AppColors.chatDarkThemeColor,
// //                             // :Colors.lightBlueAccent,
// //                                 // : Colors.grey.shade300.withOpacity(0.9),
// //                             borderRadius: BorderRadius.circular(12),
// //                           ),
// //                           child: Text(
// //                             message['text'] ?? '',
// //                             style: TextStyle(
// //                               color: isUser ? Colors.white : Colors.white,
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.fromLTRB(22, 22, 12, 34),
// //               child: Row(
// //                 children: [
// //                   Expanded(
// //                     child: Container(
// //                       height: 60,
// //                       padding: const EdgeInsets.symmetric(horizontal: 18),
// //                       decoration: BoxDecoration(
// //                         color: AppColors.navigationSkyBlueColor,
// //                         borderRadius: BorderRadius.circular(20),
// //                         boxShadow: const [
// //                           BoxShadow(
// //                             spreadRadius: -10,
// //                             blurRadius: 20,
// //                           ),
// //                         ],
// //                       ),
// //                       child: Row(
// //                         children: [
// //                           const Icon(Icons.message_outlined, color: Colors.grey),
// //                           const SizedBox(width: 12),
// //                           Expanded(
// //                             child: TextField(
// //                               controller: _controller,
// //                               style: const TextStyle(
// //                                 color: Colors.white, // ✅ makes the entered text white
// //                               ),
// //                               decoration: const InputDecoration(
// //                                 hintText: "Type your Query...",
// //                                 border: InputBorder.none,
// //                               ),
// //                               onSubmitted: sendMessage,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(width: 10),
// //                   GestureDetector(
// //                     onTap: () => sendMessage(_controller.text),
// //                     child: Container(
// //                       decoration: const BoxDecoration(
// //                         color: AppColors.navigationSkyBlueColor,
// //                         shape: BoxShape.circle,
// //                       ),
// //                       padding: const EdgeInsets.all(12),
// //                       child: const Icon(Icons.send, color: Colors.white),
// //                     ),
// //                   ),
// //                   const SizedBox(width: 10),
// //                   GestureDetector(
// //                     onTap: listen,
// //                     child: Container(
// //                       decoration: BoxDecoration(
// //                         color: _isListening
// //                             ? Colors.green
// //                             : AppColors.navigationSkyBlueColor,
// //                         shape: BoxShape.circle,
// //                       ),
// //                       padding: const EdgeInsets.all(12),
// //                       child: const Icon(
// //                         Icons.mic,
// //                         color: Colors.white,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// // }
//
// import 'dart:developer';
// import 'dart:ui';
//
// import 'package:db_atom/index.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
//
// class AiChatDetailsView extends StatefulWidget {
//   const AiChatDetailsView({super.key});
//
//   @override
//   State<AiChatDetailsView> createState() => _AiChatDetailsViewState();
// }
//
// class _AiChatDetailsViewState extends State<AiChatDetailsView> {
//   final stt.SpeechToText _speech = stt.SpeechToText();
//   final FlutterTts _flutterTts = FlutterTts();
//   final TextEditingController _controller = TextEditingController();
//
//   bool _available = false;
//   bool _isListening = false;
//
//   final List<Map<String, String>> _messages = [];
//
//   String generateBotReply(String userInput) {
//     return "\"$userInput\"";
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     initSpeech();
//     initTts();
//     _flutterTts.setSharedInstance(true);
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await Future.delayed(const Duration(milliseconds: 300));
//       await _flutterTts.speak("TTS test: voice output is working.");
//       log('voice initialized');
//     });
//   }
//
//   void initTts() {
//     _flutterTts.setLanguage("en-US");
//     _flutterTts.setPitch(1.0);
//     _flutterTts.setSpeechRate(0.5);
//     _flutterTts.awaitSpeakCompletion(true);
//
//     _flutterTts.setStartHandler(() {
//       log("✅ TTS started");
//     });
//
//     _flutterTts.setCompletionHandler(() {
//       log("✅ TTS completed");
//     });
//
//     _flutterTts.setErrorHandler((msg) {
//       log("❌ TTS error: $msg");
//     });
//   }
//
//   Future<void> safeStopTts() async {
//     try {
//       await _flutterTts.stop();
//     } catch (e) {
//       log("⚠️ FlutterTTS stop error: $e");
//     }
//   }
//
//   Future<void> initSpeech() async {
//     _available = await _speech.initialize(
//       onStatus: (status) {
//         debugPrint("Status: $status");
//         setState(() {
//           _isListening = status == 'listening';
//         });
//       },
//       onError: (error) => debugPrint("Error: $error"),
//     );
//     setState(() {});
//   }
//
//   void listen() async {
//     if (!_available) return;
//
//     await safeStopTts();
//
//     await _speech.listen(
//       onResult: (result) async {
//         if (result.finalResult && result.recognizedWords.isNotEmpty) {
//           final userInput = result.recognizedWords;
//           final botReply = generateBotReply(userInput);
//
//           setState(() {
//             _messages.add({'text': userInput, 'sender': 'user'});
//             _messages.add({'text': botReply, 'sender': 'bot'});
//           });
//
//           log("🗣️ User: $userInput");
//           log("🤖 Bot: $botReply");
//
//           await _speech.stop();
//           await Future.delayed(const Duration(milliseconds: 500));
//           await _flutterTts.speak(botReply);
//         }
//       },
//       pauseFor: const Duration(seconds: 2),
//     );
//   }
//
//   void sendMessage(String text) async {
//     if (text.trim().isEmpty) return;
//
//     final userInput = text.trim();
//     final botReply = generateBotReply(userInput);
//
//     setState(() {
//       _messages.add({
//         'text': userInput,
//         'sender': 'user',
//       });
//       _messages.add({
//         'text': botReply,
//         'sender': 'bot',
//       });
//       _controller.clear();
//     });
//
//     await safeStopTts();
//     await _flutterTts.speak(botReply);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppHeader(
//         title: "AI Chat Assistance",
//         isTitleCenter: true,
//         backBtn: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
//         ),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/ai.png'),
//             opacity: 1,
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               child: Stack(
//                 children: [
//                   // 🎨 Glassmorphism overlay
//                   BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                     child: Container(
//                       color: Colors.black.withOpacity(0.2),
//                     ),
//                   ),
//                   ListView.builder(
//                     padding: const EdgeInsets.all(12),
//                     itemCount: _messages.length,
//                     itemBuilder: (context, index) {
//                       final message = _messages[index];
//                       final isUser = message['sender'] == 'user';
//                       return Align(
//                         alignment: isUser
//                             ? Alignment.centerRight
//                             : Alignment.centerLeft,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 14,
//                             horizontal: 14,
//                           ),
//                           margin: const EdgeInsets.symmetric(vertical: 6),
//                           decoration: BoxDecoration(
//                             color: isUser
//                                 ? AppColors.white
//                                 : Colors.grey,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                               color: Colors.white,
//                               width: 1,
//                             ),
//                           ),
//                           child: Text(
//                             message['text'] ?? '',
//                             style: const TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(22, 22, 12, 34),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       height: 60,
//                       padding: const EdgeInsets.symmetric(horizontal: 18),
//                       decoration: BoxDecoration(
//                         color: AppColors.navigationSkyBlueColor.withOpacity(0.6),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.3),
//                           width: 1.5,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             spreadRadius: -10,
//                             blurRadius: 20,
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           const Icon(Icons.message_outlined, color: Colors.grey),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: TextField(
//                               controller: _controller,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                               ),
//                               decoration: const InputDecoration(
//                                 hintText: "Type your Query...",
//                                 border: InputBorder.none,
//                               ),
//                               onSubmitted: sendMessage,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   GestureDetector(
//                     onTap: () => sendMessage(_controller.text),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: AppColors.navigationSkyBlueColor.withOpacity(0.6),
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.3),
//                           width: 1.5,
//                         ),
//                       ),
//                       padding: const EdgeInsets.all(12),
//                       child: const Icon(Icons.send, color: Colors.white),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   GestureDetector(
//                     onTap: listen,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: _isListening
//                             ? Colors.green.withOpacity(0.6)
//                             : AppColors.navigationSkyBlueColor.withOpacity(0.6),
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.3),
//                           width: 1.5,
//                         ),
//                       ),
//                       padding: const EdgeInsets.all(12),
//                       child: const Icon(
//                         Icons.mic,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';


import 'dart:ui';
import 'package:flutter/material.dart';

class AiChatDetailsView extends StatefulWidget {
  const AiChatDetailsView({Key? key}) : super(key: key);

  @override
  State<AiChatDetailsView> createState() => _AiChatDetailsViewState();
}

// Custom painter for bubble tail
class BubbleTailPainter extends CustomPainter {
  final Color color;
  final bool isUser;
  BubbleTailPainter(this.color, this.isUser);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.55)
      ..style = PaintingStyle.fill;
    final path = Path();
    if (isUser) {
      // Draw right tail
      path.moveTo(0, 0);
      path.quadraticBezierTo(size.width * 0.55, size.height * 0.65, size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
    } else {
      // Draw left tail
      path.moveTo(size.width, 0);
      path.quadraticBezierTo(size.width * 0.45, size.height * 0.65, 0, size.height);
      path.lineTo(size.width, size.height);
      path.close();
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BubbleTailPainter oldDelegate) => false;
}

// Glassy neon chat bubble with tail
class GlassBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  const GlassBubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final Color userColor = const Color(0xFF00FFF7);
    final Color botColor = const Color(0xFF00D9FF);

    final bubbleColor = isUser ? userColor : botColor;
    // return Row(
    //   mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.end,
    //   children: [
    //     if (!isUser) ...[
    //       // CustomPaint(
    //       //   painter: BubbleTailPainter(bubbleColor, false),
    //       //   size: Size(13, 18),
    //       // ),
    //       const SizedBox(width: 6),
    //       Icon(Icons.android, color: botColor, size: 28), // Robot icon
    //       const SizedBox(width: 8),
    //     ],
    //     Flexible(
    //       child: ClipRRect(
    //         borderRadius: BorderRadius.circular(18),
    //         child: BackdropFilter(
    //           filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
    //           child: Container(
    //             margin: const EdgeInsets.symmetric(vertical: 4),
    //             padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 14),
    //             decoration: BoxDecoration(
    //               gradient: LinearGradient(
    //                 colors: isUser
    //                     ? [
    //                   userColor.withOpacity(0.28),
    //                   userColor.withOpacity(0.11)
    //                 ]
    //                     : [
    //                   botColor.withOpacity(0.28),
    //                   botColor.withOpacity(0.11)
    //                 ],
    //                 begin: Alignment.topLeft,
    //                 end: Alignment.bottomRight,
    //               ),
    //               borderRadius: BorderRadius.circular(18),
    //               border: Border.all(
    //                 color: bubbleColor.withOpacity(0.55),
    //                 width: 1.2,
    //               ),
    //             ),
    //             child: Text(
    //               text,
    //               style: TextStyle(
    //                 color: bubbleColor.withOpacity(0.89),
    //                 fontSize: 17,
    //                 fontWeight: FontWeight.w500,
    //                 shadows: [
    //                   Shadow(
    //                     color: bubbleColor.withOpacity(0.20),
    //                     blurRadius: 8,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //     if (isUser) ...[
    //       const SizedBox(width: 8),
    //       Icon(Icons.person, color: userColor, size: 28), // User icon
    //       const SizedBox(width: 6),
    //       // CustomPaint(
    //       //   painter: BubbleTailPainter(bubbleColor, true),
    //       //   size: Size(13, 18),
    //       // ),
    //     ],
    //   ],
    // );
    return Row(
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isUser)
          CustomPaint(
            painter: BubbleTailPainter(bubbleColor, false),
            size: Size(13, 18),
          ),
        Flexible(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isUser
                        ? [
                      userColor.withOpacity(0.28),
                      userColor.withOpacity(0.11)
                    ]
                        : [
                      botColor.withOpacity(0.28),
                      botColor.withOpacity(0.11)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: bubbleColor.withOpacity(0.55),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (!isUser) ...[
                      Icon(Icons.android, color: botColor, size: 24),
                      const SizedBox(width: 8),
                    ],
                    Flexible(
                      child: Text(
                        text,
                        style: TextStyle(
                          color: bubbleColor.withOpacity(0.89),
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                              color: bubbleColor.withOpacity(0.20),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isUser) ...[
                      const SizedBox(width: 8),
                      Icon(Icons.person, color: userColor, size: 24),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isUser)
          CustomPaint(
            painter: BubbleTailPainter(bubbleColor, true),
            size: Size(13, 18),
          ),
      ],
    );

  }
}

class _AiChatDetailsViewState extends State<AiChatDetailsView> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  String generateBotReply(String userInput) {
    return "\"$userInput\"";
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    final userInput = text.trim();
    final botReply = generateBotReply(userInput);
    setState(() {
      _messages.add({'text': userInput, 'sender': 'user'});
      _messages.add({'text': botReply, 'sender': 'bot'});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color mainNeon = Color(0xFF00FFF7);
    const Color avatarGlow = Color(0xFF1BFFFF);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // backBtn: IconButton(
        //   onPressed: () => Navigator.pop(context),
        //   icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
        // ),
        elevation: 0,
        // leading: const Icon(Icons.arrow_back_ios_new_outlined, color: mainNeon),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [avatarGlow, Colors.transparent],
                  center: Alignment.center,
                  radius: 0.7,
                ),
              ),
              child: Icon(Icons.chat, color: mainNeon, size: 28),
            ),
            const SizedBox(width: 14),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Chat Assistance',
                    style: TextStyle(
                      color: mainNeon,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    )),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Neon swirling BG layer
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xCC001E4D), Color(0xFF0C001C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          IgnorePointer(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
              child: Container(
                color: Colors.black.withOpacity(0.35),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isUser = message['sender'] == 'user';

                    return Align(
                      alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: GlassBubble(
                        text: message['text'] ?? '',
                        isUser: isUser,
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 28, left: 16, right: 16, top: 2),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                    width: 1.4,
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
                  children: [
                    Icon(Icons.search, color: mainNeon.withOpacity(0.68)),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: mainNeon),
                        decoration: InputDecoration(
                          hintText: "Write your query...",
                          hintStyle: TextStyle(
                              color: mainNeon.withOpacity(0.47),
                              fontSize: 15),
                          border: InputBorder.none,
                        ),
                        onSubmitted: sendMessage,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => sendMessage(_controller.text),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.send,
                            color: mainNeon.withOpacity(0.83), size: 28),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class AiChatDetailsView extends StatefulWidget {
//   const AiChatDetailsView({Key? key}) : super(key: key);
//
//   @override
//   State<AiChatDetailsView> createState() => _AiChatDetailsViewState();
// }
//
// class _AiChatDetailsViewState extends State<AiChatDetailsView> {
//   final TextEditingController _controller = TextEditingController();
//   final List<Map<String, String>> _messages = [];
//
//   String generateBotReply(String userInput) {
//     return "\"$userInput\"";
//   }
//
//   void sendMessage(String text) {
//     if (text.trim().isEmpty) return;
//     final userInput = text.trim();
//     final botReply = generateBotReply(userInput);
//     setState(() {
//       _messages.add({'text': userInput, 'sender': 'user'});
//       _messages.add({'text': botReply, 'sender': 'bot'});
//       _controller.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const Color mainNeon = Color(0xFF00FFF7);
//     const Color avatarGlow = Color(0xFF1BFFFF);
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: const Icon(Icons.arrow_back_ios_new_outlined, color: mainNeon),
//         title: Row(
//           children: [
//             Container(
//               width: 40,
//               height: 40,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: RadialGradient(
//                   colors: [avatarGlow, Colors.transparent],
//                   center: Alignment.center,
//                   radius: 0.7,
//                 ),
//               ),
//               child: Icon(Icons.chat, color: mainNeon, size: 28),
//             ),
//             const SizedBox(width: 14),
//             const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('AI Chat Assistance',
//                     style: TextStyle(
//                       color: mainNeon,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 19,
//                     )),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: Stack(
//         children: [
//           // Neon swirling BG layer
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xCC001E4D), Color(0xFF0C001C)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             // decoration: const BoxDecoration(
//             //   image: DecorationImage(
//             //     image: AssetImage('assets/images/ai.png'),
//             //     // opacity: 0.8,
//             //     fit: BoxFit.cover,
//             //   ),
//             // ),
//           ),
//           // Subtle moving glow overlay
//           IgnorePointer(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
//               child: Container(
//                 color: Colors.black.withOpacity(0.35),
//               ),
//             ),
//           ),
//           Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.all(24),
//                   itemCount: _messages.length,
//                   itemBuilder: (context, index) {
//                     final message = _messages[index];
//                     final isUser = message['sender'] == 'user';
//
//                     return Align(
//                       alignment:
//                       isUser ? Alignment.centerRight : Alignment.centerLeft,
//                       child:
//                       Container(
//                         margin: EdgeInsets.only(bottom: 28, left: 16, right: 16, top: 2),
//                         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               mainNeon.withOpacity(0.18),
//                               Colors.transparent,
//                               mainNeon.withOpacity(0.14)
//                             ],
//                             stops: [0.02, 0.35, 1],
//                             begin: Alignment.centerLeft,
//                             end: Alignment.bottomCenter,
//                           ),
//                           borderRadius: BorderRadius.circular(27),
//                           border: Border.all(
//                             color: mainNeon.withOpacity(0.30),
//                             width: 1.4,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: mainNeon.withOpacity(0.09),
//                               blurRadius: 12,
//                               offset: Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Text(
//                           message['text'] ?? '',
//                           style: TextStyle(
//                             color: isUser
//                                 ? mainNeon.withOpacity(0.98)
//                                 : Colors.white.withOpacity(0.97),
//                             fontSize: 17.2,
//                             fontWeight: FontWeight.w500,
//                             shadows: [
//                               Shadow(
//                                 color: mainNeon.withOpacity(isUser ? 0.1 : 0),
//                                 blurRadius: 2,
//                               ),
//                             ],
//                           ),
//                         ),
//                         ),
//
//                     );
//                   },
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 28, left: 16, right: 16, top: 2),
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       mainNeon.withOpacity(0.18),
//                       Colors.transparent,
//                       mainNeon.withOpacity(0.14)
//                     ],
//                     stops: [0.02, 0.35, 1],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                   borderRadius: BorderRadius.circular(27),
//                   border: Border.all(
//                     color: mainNeon.withOpacity(0.30),
//                     width: 1.4,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: mainNeon.withOpacity(0.09),
//                       blurRadius: 12,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.search, color: mainNeon.withOpacity(0.68)),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: TextField(
//                         controller: _controller,
//                         style: const TextStyle(color: mainNeon),
//                         decoration: InputDecoration(
//                           hintText: "Write your query...",
//                           hintStyle: TextStyle(
//                               color: mainNeon.withOpacity(0.47),
//                               fontSize: 15),
//                           border: InputBorder.none,
//                         ),
//                         onSubmitted: sendMessage,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     GestureDetector(
//                       onTap: () => sendMessage(_controller.text),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.transparent,
//                           borderRadius: BorderRadius.circular(18),
//                         ),
//                         padding: EdgeInsets.all(6),
//                         child: Icon(Icons.send,
//                             color: mainNeon.withOpacity(0.83), size: 28),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
