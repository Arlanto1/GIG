import 'dart:ui';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/arlanto_ai_chat_assistance/models/ai_chat_model.dart';
import 'package:db_atom/src/features/arlanto_ai_chat_assistance/services/ai_chat_service.dart';
import '../cubits/ai_chat_details_cubit.dart';

class AiChatDetailsView extends StatefulWidget {
  final AiChatModel? model;
  final String title;
  const AiChatDetailsView({super.key, this.model, required this.title,});

  @override
  State<AiChatDetailsView> createState() => _AiChatDetailsViewState();
}

class _AiChatDetailsViewState extends State<AiChatDetailsView> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color mainNeon = Color(0xFF00FFF7);
    const Color avatarGlow = Color(0xFF1BFFFF);

    return BlocProvider(
      create: (_) => AiChatDetailsCubit(service: AiChatService()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        //     onPressed: () {
        //       Navigator.pushNamed(context, aiChatListRoute);
        //     },
        //   ),
        //   elevation: 0,
        //   title: Row(
        //     children: [
        //       Container(
        //         width: 40,
        //         height: 40,
        //         decoration: const BoxDecoration(
        //           shape: BoxShape.circle,
        //           gradient: RadialGradient(
        //             colors: [avatarGlow, Colors.transparent],
        //             center: Alignment.center,
        //             radius: 0.7,
        //           ),
        //         ),
        //         child: const Icon(Icons.chat, color: mainNeon, size: 28),
        //       ),
        //       const SizedBox(width: 14),
        //       const Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'Atom Chat Assistance',
        //             style: TextStyle(
        //               color: mainNeon,
        //               fontWeight: FontWeight.bold,
        //               fontSize: 19,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: widget.title,
          showPopUp: false,
          showSaveButton: false,
          showSubmitButton:
         false,
          showLikeButton: false,
          showDisLikeButton: false,
          showCustomIcon: true,
            onTapCustomIcon : ()=>  Navigator.pushNamed(context, aiChatListRoute),
        ),
        body: Stack(
          children: [
            // Background gradient
            Container(
              decoration:  const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xCC001E4D), Color(0xFF0C001C)],
                  // colors: [AppColors.newColor, AppColors.newColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            IgnorePointer(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
                child: Container(color: Colors.black.withOpacity(0.35)),
              ),
            ),
            BlocBuilder<AiChatDetailsCubit, AiChatDetailsState>(
              builder: (context, state) {
                // Scroll to bottom after each build
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });

                return Column(
                  children: [
                    // Chat messages
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(24),
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final msg = state.messages[index];
                          return Align(
                            alignment: msg.isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: GlassBubble(
                              text: msg.message,
                              isUser: msg.isUser,
                            ),
                          );
                        },
                      ),
                    ),

                    // Bot thinking animation
                    if (state.isLoading)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: RobotThinkingAnimation(),
                      ),

                    // Input field
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 28, left: 16, right: 16, top: 2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            mainNeon.withOpacity(0.18),
                            Colors.transparent,
                            mainNeon.withOpacity(0.14)
                          ],
                          stops: const [0.02, 0.35, 1],
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
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              style: const TextStyle(color: mainNeon),
                              decoration: InputDecoration(
                                hintText: "Write your query...",
                                hintStyle: TextStyle(
                                  color: mainNeon.withOpacity(0.47),
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                              ),
                              onSubmitted: (text) {
                                context
                                    .read<AiChatDetailsCubit>()
                                    .sendMessage(text);
                                _controller.clear();
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<AiChatDetailsCubit>()
                                  .sendMessage(_controller.text);
                              _controller.clear();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.all(6),
                              child: Icon(
                                Icons.send,
                                color: mainNeon.withOpacity(0.83),
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Error message
                    if (state.error != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Error: ${state.error}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



class BubbleTailPainter extends CustomPainter {
  final Color color;
  final bool isUser;
  BubbleTailPainter(this.color, this.isUser);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.55)
      ..style = PaintingStyle.fill;
    final path = Path();
    if (isUser) {
      path.moveTo(0, 0);
      path.quadraticBezierTo(size.width * 0.55, size.height * 0.65, size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
    } else {
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

class GlassBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  const GlassBubble({required this.text, required this.isUser, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color userColor = const Color(0xFF00FFF7);
    final Color botColor = const Color(0xFF00D9FF);
    final bubbleColor = isUser ? userColor : botColor;

    return Row(

      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        // if (!isUser)
        //   CustomPaint(
        //     painter: BubbleTailPainter(bubbleColor, false),
        //     size: const Size(13, 18),
        //   ),
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
                        ? [userColor.withValues(alpha: 0.28), userColor.withValues(alpha: 0.11)]
                        : [botColor.withValues(alpha: 0.28), botColor.withValues(alpha:0.11)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: bubbleColor.withValues(alpha: 0.55),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!isUser) ...[
                      Icon(Icons.android, color: botColor, size: 24),
                      const SizedBox(width: 8),
                    ],
                    Flexible(
                      child: Text(
                        text,
                        style: TextStyle(
                          color: bubbleColor.withValues(alpha: 0.89),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(color: bubbleColor.withValues(alpha: 0.20), blurRadius: 8),
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
        // if (isUser)
        //   CustomPaint(
        //     painter: BubbleTailPainter(bubbleColor, true),
        //     size: const Size(13, 18),
        //   ),
      ],
    );
  }
}


class RobotThinkingAnimation extends StatefulWidget {
  const RobotThinkingAnimation({super.key});

  @override
  State<RobotThinkingAnimation> createState() => _RobotThinkingAnimationState();
}

class _RobotThinkingAnimationState extends State<RobotThinkingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulse1;
  late Animation<double> _pulse2;
  late Animation<double> _pulse3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    _pulse1 = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeInOut)),
    );
    _pulse2 = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.6, curve: Curves.easeInOut)),
    );
    _pulse3 = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.8, curve: Curves.easeInOut)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _pulseCircle(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          child: child,
        );
      },
      child: Container(
        width: 12,
        height: 12,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: const BoxDecoration(
          color: Colors.cyanAccent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Thinking",
            style: TextStyle(
              color: Colors.cyanAccent,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          _pulseCircle(_pulse1),
          _pulseCircle(_pulse2),
          _pulseCircle(_pulse3),
        ],
      ),
    );
  }
}


