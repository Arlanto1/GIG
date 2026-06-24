import 'dart:developer';
import 'dart:ui';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/training_module/training_items_list/bloc/training_items_bloc.dart';

class TrainingItemsListView extends StatefulWidget {
  final String id;

  const TrainingItemsListView({
    super.key,
    required this.id,
  });

  @override
  State<TrainingItemsListView> createState() => _TrainingItemsListViewState();
}

class _TrainingItemsListViewState extends State<TrainingItemsListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context
        .read<TrainingItemsBloc>()
        .add(InitializeValuesTrainingItems(id: widget.id));
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
      context.read<TrainingItemsBloc>().add(FetchTrainingItemsData(
            id: widget.id,
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            // filters: filters,
          ));
    }
  }

  String _getFileExtension(String filename) {
    const videoExtensions = ['.mp4', '.mov', '.avi', '.mkv', '.webm', '.flv', '.wmv'];
    const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp', '.svg'];
    const docExtensions = ['.doc', '.docx'];
    const excelExtensions = ['.xls', '.xlsx', '.csv'];
    const pptExtensions = ['.ppt', '.pptx'];
    const pdfExtensions = ['.pdf'];

    final lower = filename.toLowerCase();

    if (videoExtensions.any((ext) => lower.endsWith(ext))) {
      return videoExtensions.firstWhere((ext) => lower.endsWith(ext));
    } else if (imageExtensions.any((ext) => lower.endsWith(ext))) {
      return imageExtensions.firstWhere((ext) => lower.endsWith(ext));
    } else if (docExtensions.any((ext) => lower.endsWith(ext))) {
      return docExtensions.firstWhere((ext) => lower.endsWith(ext));
    } else if (excelExtensions.any((ext) => lower.endsWith(ext))) {
      return excelExtensions.firstWhere((ext) => lower.endsWith(ext));
    } else if (pptExtensions.any((ext) => lower.endsWith(ext))) {
      return pptExtensions.firstWhere((ext) => lower.endsWith(ext));
    } else if (pdfExtensions.any((ext) => lower.endsWith(ext))) {
      return pdfExtensions.firstWhere((ext) => lower.endsWith(ext));
    }

    // Fallback: extract extension from filename directly
    final dotIndex = filename.lastIndexOf('.');
    return dotIndex != -1 ? filename.substring(dotIndex) : '';
  }
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocConsumer<TrainingItemsBloc, TrainingItemsState>(
      listener: (context, state) {},
      builder: (context, state) {
        log('plus ${state.extraProperties?.hasWritePermission}');
        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: false,
            scaffoldKey: scaffoldKey,
            context: context,
            displayMenu: state.displayMenu,
            list: true,
            // 🔥 only "+" button mode
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
            title: Constants.trainingItems,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            // excelAPIName: 'exportFoundExcel',
            // pdfAPIName: 'exportFoundPDF',
          ),
          body: BlocBuilder<TrainingItemsBloc, TrainingItemsState>(
            builder: (context, state) {
              return Stack(
                children: [
                  // 🔹 Background
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/bg2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                  ),

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
                          if (state.status == FormStatus.loading ||
                              state.status == FormStatus.initial) {
                            return const Center(child: BaseLoader());
                          }
                          return const SizedBox();
                        }

                        final item = state.items[index];
                        List<Label> labels = [
                          Label(
                            key: Constants.title,
                            value: item.title ?? '',
                          ),
                          // Label(
                          //   key: Constants.dateofcreation,
                          //   value: item.creationDate != null
                          //       ? Utils.timestampToDateConversion(
                          //       int.parse(item.creationDate ?? '0'),
                          //       Constants.twentyFourHourDateTimeFormat)
                          //       : '',
                          // ),
                          Label(
                            key: Constants.currentSession,
                            value:
                            'Current: Session ${item.sessionNumber}',
                          ),
                          Label(
                            key: Constants.trainerName,
                            value:
                            item.trainerName,
                          ),
                          Label(
                            key: Constants.entity,
                            value:
                            item.entity,
                          ),
                          Label(
                            key: Constants.status,
                            value: item.status,
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
                                    filter: ImageFilter.blur(
                                        sigmaX: 18, sigmaY: 18),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white
                                                .withValues(alpha: 0.09),
                                            Colors.transparent,
                                            Colors.white
                                                .withValues(alpha: 0.09),
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
                                        showLaunchButton: true,
                                        // onLaunchTap: (selectedIndex) {
                                        //   DownloadImage()
                                        //       .exportMaterialPdf(context, 'material_${item.id}.$_isVideo', '/getMateriaItem/${item.id}');
                                        // },

                                        onLaunchTap: (selectedIndex) {
                                          final ext = _getFileExtension(item.trainingMaterial);
                                          DownloadImage()
                                              .exportMaterialPdf(context, 'material_${item.id}$ext', '/getMaterialItem/${item.id}');
                                        },
                                        // onEditTap: (selectedIndex) {
                                        //   getById(
                                        //     state.extraProperties
                                        //         ?.hasWritePermission ??
                                        //         false,
                                        //     item.id ?? 0,
                                        //   );
                                        // },
                                        showEditButton: false,
                                        onViewTap: (selectedIndex) {
                                          showDialog(
                                            context: context,
                                            builder: (_) => BasePopUpItems(
                                              id: item.id.toString(),
                                              status: item.status.toIntOrNull(),
                                              labels: labels,
                                              isEventProtectionStatus: false,
                                              isArticleFoundStatus: true,
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
}
