import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/vvip_visitor/models/vvip_visitor_response_model.dart';
import 'package:db_atom/src/features/guarding_operations/vvip_visitor/services/vvip_visitor_services.dart';
import 'package:db_atom/src/features/guarding_operations/vvip_visitor/vvip_visitors/bloc/vvip_visitors_bloc.dart';

class VVIPVisitorsView extends StatefulWidget {
  final VIVPVisitorModel? model;

  const VVIPVisitorsView({
    super.key,
    this.model,
  });

  @override
  State<VVIPVisitorsView> createState() => _VVIPVisitorsViewState();
}

class _VVIPVisitorsViewState extends State<VVIPVisitorsView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
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
      context
          .read<VVIPVisitorsBloc>()
          .add(FetchData(startPos: pageNumber, maxPos: 20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton:
            widget.model?.status != 0 || widget.model?.status != null
                ? Flutterfloatingbutton(
                    backgroundColor: AppColors.navigationSkybluecolor,
                    foregroundColor: AppColors.backgroundWhitecolor,
                    onPressed: () => {
                      Navigator.pushNamed(context, vipVisitorsDetailsRoute,
                          arguments: {
                            "title": Constants.vvipVisitors,
                          })
                    },
                  )
                : null,
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.vvipVisitors,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
          excelAPIName: 'exportVipExcel',
          pdfAPIName: 'exportVipPDF',
        ),
        body: BlocBuilder<VVIPVisitorsBloc, VVIPVisitorsState>(
            builder: (context, state) {
          if (state.status == FormStatus.initial) {
            return const BaseLoader();
          }
          if (state.items.isEmptyOrNull) {
            return const NoRecordFoundWidget();
          }
          return Container(
            margin: allMargin16,
            decoration: const ShapeDecoration(
                color: AppColors.backgroundWhitecolor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                )),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.items.length
                  : state.items.length + 1,
              itemBuilder: (context, index) {
                List<Label> labels = [];
                if (index < state.items.length) {
                  labels.add(Label(
                      key: state.labels?.locale.entrySecurity ??
                          state.labels?.defaultLocale.entrySecurity ??
                          'Created By',
                      value: state.items[index].entrySecurity?.name ?? ''));
                  labels.add(Label(
                      key: state.labels?.locale.location ??
                          state.labels?.defaultLocale.location ??
                          'Location',
                      value: state.items[index].location?.name ?? ''));
                  labels.add(Label(
                      key: state.labels?.locale.slNo ??
                          state.labels?.defaultLocale.slNo ??
                          'SL No',
                      value: state.items[index].slNo ?? ''));
                  labels.add(Label(
                      key: state.labels?.locale.inputDate ??
                          state.labels?.defaultLocale.inputDate ??
                          'Date of Creation',
                      value: state.items[index].inputDate != null
                          ? Utils.timestamptoDateConversion(
                              int.parse(state.items[index].inputDate ?? '0'),
                              Constants.dateFormat)
                          : ''));
                }
                return index >= state.items.length
                    ? const BaseLoader()
                    : BaseListTileItem(
                        id: state.items[index].id,
                        labels: labels,
                        status: state.items[index].status,
                        isVipStatus: true,
                        isEventProtectionStatus: false,
                        onTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.items[selectedIndex].id.toString(),
                                labels: labels,
                                status: state.items[selectedIndex].status,
                                isVipStatus: true,
                                isEventProtectionStatus: false,
                                isMasterGuard: false,
                              );
                            },
                          );
                        },
                        onEditTap: (selectedIndex) {
                          getById(state.items[index].id ?? 0);
                        },
                        onViewTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.items[selectedIndex].id.toString(),
                                labels: labels,
                                status: state.items[selectedIndex].status,
                                isVipStatus: true,
                                isEventProtectionStatus: false,
                                isMasterGuard: false,
                              );
                            },
                          );
                        },
                        index: index,
                      );
              },
            ),
          );
        }));
  }

  getById(int id) async {
    showLoadingDialog(context);

    VIVPVisitorModel model = await VVIPVisitorServices().getGVipById(id);

    editDataLoading(model);
  }

  void editDataLoading(VIVPVisitorModel? model) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(
        context,
        vipVisitorsDetailsRoute,
        arguments: {
          "model": model,
          "title": Constants.vvipVisitors,
        },
      );
    }
  }
}
