import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/training_module/models/requestModel/training_module_request.dart';
import '../training_genInfo/cubits/training_genInfo_cubit.dart';

class TrainingListCardView extends StatefulWidget {
  final String title;
  final TrainingModel? model;

  const TrainingListCardView({
    super.key,
    required this.title,
    required this.model,
  });

  @override
  State<TrainingListCardView> createState() => _TrainingListCardView();
}

class _TrainingListCardView extends State<TrainingListCardView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: "Classroom Training",
        showPopUp: false,
        showSaveButton: false,
        showSubmitButton: false,
        showDisLikeButton: false,
        showLikeButton: false,
      ),
      body: BlocConsumer<TrainingGenInfoCubit, TrainingGenInfoState>(
        listener: (context, state) {
          Utils().formError(state, context);
          Utils().errorAndLogout(state, context);

          if (state.status == FormStatus.success) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              /// 🔹 BACKGROUND IMAGE
              Positioned.fill(
                child: Image.asset(
                  'assets/images/bg2.png',
                  fit: BoxFit.cover,
                ),
              ),

              /// 🔹 OPTIONAL DARK / GLASS OVERLAY (recommended for readability)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 120,
                    sigmaY: 120,
                  ),
                  child: Container(
                    color: Colors.black
                        .withValues(alpha: 0.25), // tint for readability
                  ),
                ),
              ),

              SafeArea(
                child:

                /// 🔹 MAIN CONTENT
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            _rowCard(
                              label: Constants.generalInfo,
                              onTap: ()  async {
                                // TrainingModel model= await TrainingModuleServices().getClassRoomTrainingById(widget.model!.id.toString());
                                Navigator.pushNamed(
                                  context,
                                  trainingGenInfoDetailsRoute,
                                  arguments: {
                                    "title": Constants.generalInfo,
                                    // "model": model,
                                    "model": widget.model,
                                  },
                                );

                              },
                            ),

                            _rowCard(
                              label: Constants.trainingItems,
                              onTap: ()  {
                                Navigator.pushNamed(context, trainingItemsListRoute,
                                  arguments: {
                                  "id": '${widget.model!.id}',
                                  },);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// ************ NEW FULL-WIDTH ROW CARD ************
  Widget _rowCard({
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 90,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.09),
              Colors.transparent,
              Colors.white.withValues(alpha: 0.09),
              // Color(0xFF6474C6).withOpacity(0.14)
            ],
            stops: const [0.02, 0.35, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(27),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.6),
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
            Expanded(
              child: Text(
                label,
                style: Styles.textStyleWhite16,
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
