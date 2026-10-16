import 'dart:developer';
import 'dart:ui';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/training_module/models/requestModel/training_module_request.dart';
import 'package:db_atom/src/features/training_module/services/training_module_service.dart';
import 'package:db_atom/src/features/training_module/training_module_list/bloc/training_module_list_bloc.dart';

class ClassRoomTrainingListView extends StatefulWidget {
  const ClassRoomTrainingListView({super.key});

  @override
  State<ClassRoomTrainingListView> createState() =>
      _ClassRoomTrainingListViewState();
}

class _ClassRoomTrainingListViewState extends State<ClassRoomTrainingListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<TrainingModuleListBloc>().add(const InitializeValuesTraining());
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      pageNumber = pageNumber + 20;
      context.read<TrainingModuleListBloc>().add(FetchTrainingData(
        startPos: pageNumber,
        maxPos: Constants.maxResults,
        filters: filters,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocConsumer<TrainingModuleListBloc, TrainingModuleListState>(
      listener: (context, state) {},
      builder: (context, state) {
        log('plus ${state.extraProperties?.hasWritePermission}');
        return Scaffold(
          backgroundColor: Colors.white,
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: false,
            scaffoldKey: scaffoldKey,
            context: context,
            displayMenu: state.displayMenu,
            list: true, // 🔥 only "+" button mode
            onAddPressed: () {
              // Navigator.pushNamed(
              //   context,
              //   articleFoundNewDetailsRoute,
              //   arguments: {"title": Constants.createFound},
              // );
            },
          ),
          // backgroundColor: const Color(0xFF071130),
          // backgroundColor: AppColors.newColor,
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.classroomTraining,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName: 'exportFoundExcel',
            pdfAPIName: 'exportFoundPDF',
          ),
          body: BlocBuilder<TrainingModuleListBloc, TrainingModuleListState>(
            builder: (context, state) {
              return Stack(
                children: [
                  // // 🔹 Background
                  // Positioned.fill(
                  //   child: Image.asset(
                  //     'assets/images/bg2.png',
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  // Positioned.fill(
                  //   child: ClipRect(
                  //     child: BackdropFilter(
                  //       filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                  //       child: Container(
                  //         color: Colors.black.withValues(alpha: 0.2),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // 🔹 ListView - start immediately below search bar
                  Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    bottom: 0,
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.only(bottom: 100),
                        itemCount: state.hasReachedMax
                            ? state.items.length
                            : state.items.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.items.length) {
                            if (state.status == FormStatus.loading ) {
                              return const Center(child: BaseLoader());
                            }
                            return const SizedBox();
                          }

                          final item = state.items[index];
                          List<Label> labels = [
                            Label(
                              key: Constants.title,
                              value:
                              item.title??'',
                            ),
                            Label(
                              key: Constants.dateofcreation,
                              value: item.creationDate != null
                                  ? Utils.timestampToDateConversion(
                                  int.parse(item.creationDate ?? '0'),
                                  Constants.twentyFourHourDateTimeFormat)
                                  : '',
                            ),
                            Label(
                              key: Constants.creatorName,
                              value:
                              item.creatorName??'',
                            ),
                            Label(
                              key: Constants.creatorEmail,
                              value:
                              item.creatorEmail??'',
                            ),
                            Label(
                              key: Constants.trainingType,
                              value:
                              item.trainingType??'',
                            ),
                            Label(
                              key: Constants.status,
                              value:
                              item.status??'',
                            ),
                          ];

                          return index >= state.items.length
                              ? const SizedBox()
                              : Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  // Color(0xFF6474C6),
                                  // Color(0xFF6474C6),
                                  Colors.transparent,
                                  Colors.transparent,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: BackdropFilter(
                                filter:
                                ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                                child: Container(
                                  decoration:
                                  BoxDecoration(
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
                                      color: Colors.white
                                          .withValues(alpha: 0.6),
                                      width: 0.7,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white
                                            .withValues(alpha: 0.0),
                                        blurRadius: 12,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: BaseListTileItem(
                                    id: item.id,
                                    labels: labels,
                                    onTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (_) => BasePopUpItems(
                                          id: item.id.toString(),
                                          status: item.status.toIntOrNull(),
                                          labels: labels,
                                        ),
                                      );
                                    },
                                    onEditTap: (selectedIndex) {
                                      getById(
                                        state.extraProperties
                                            ?.hasWritePermission ??
                                            false,
                                        item.id ?? 0,
                                      );
                                    },
                                    showEditButton: false,
                                    onViewTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (_) => BasePopUpItems(
                                          id: item.id.toString(),
                                          status: item.status.toIntOrNull(),
                                          labels: labels,
                                          isEventProtectionStatus: false,
                                          isMasterGuard: false,
                                        ),
                                      );
                                    },
                                    index: index,
                                  ),
                                ),
                              ),
                            ),
                          );
//
                        },
                    ),
                  ),
                ],
              );
            },
          ),
        );

      },
    );
  }

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);
    TrainingModel model = await TrainingModuleServices().getClassRoomTrainingById(id.toString());
    editDataLoading(model, hasWritePermission);
  }

  void editDataLoading(TrainingModel? model, bool hasWritePermission) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(context, trainingListCardRoute, arguments: {
        "model": model,
        "title": Constants.editFound,
        ConstantsArgument.extraProperties:
        ExtraProperties(hasWritePermission: hasWritePermission),
      });
    }
  }
}
