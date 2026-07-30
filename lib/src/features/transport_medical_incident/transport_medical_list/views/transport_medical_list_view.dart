
import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/transport_medical_incident/models/transport_medical_incident_model.dart';
import 'package:db_atom/src/features/transport_medical_incident/services/transport_medical_service.dart';
import 'package:db_atom/src/features/transport_medical_incident/transport_medical_list/bloc/transport_medical_list_bloc.dart';

class TransportMedicalListView extends StatefulWidget {
  const TransportMedicalListView({
    super.key,
    required this.isTransport,
  });

final bool isTransport;
  @override
  State<TransportMedicalListView> createState() =>
      _TransportMedicalListViewState();
}

class _TransportMedicalListViewState extends State<TransportMedicalListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<TransportMedicalBloc>().add(
      const InitializeValuesTM(),
    );
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
      context.read<TransportMedicalBloc>().add(FetchTMData(
        startPos: pageNumber,
        maxPos: Constants.maxResults,
        newSearch: false,
        filters: filters,
      ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<TransportMedicalBloc>().add(
      const RefreshList(),
    );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    log('widget.isTransport${widget.isTransport}');

    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<TransportMedicalBloc, TransportMedicalState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.formError &&
            state.message != null &&
            state.message!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }

      },
      builder: (context, state) {
        log('state.extraProperties?.hasWritePermission ${state.extraProperties?.hasWritePermission}');

        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: (state.extraProperties?.hasWritePermission ??
                false) ,
            scaffoldKey: scaffoldKey,
            context: context,
            displayMenu: state.displayMenu,
            list: true, //  only "+" button mode
            onAddPressed: () {
              Navigator.popAndPushNamed(
                context,
                transportMedicalDetailsRoute,
                arguments: {
                   ConstantsArgument.title: widget.isTransport ? Constants.transportIncidentList : Constants.medicalEmergencyTitle,
                ConstantsArgument.isTransport: widget.isTransport },
              );
            },
          ),
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.isTransport ? Constants.transportIncidentList : Constants.medicalEmergencyTitle,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName: 'exportIMExcel',
            pdfAPIName: 'exportIMPdf',
          ),
          body:
          BlocBuilder<TransportMedicalBloc, TransportMedicalState>(
              builder: (context, state) {
                log('state.extraProperties?.hasWritePermission ${state.extraProperties?.hasWritePermission}');
                  return Stack(
                  children: [
                    //  Background
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

                    // Search Bar - positioned safely at the top
                    Positioned(
                      top: MediaQuery
                          .of(context)
                          .padding
                          .top + kToolbarHeight + -40, // below AppBar
                      left: 3,
                      right: 3,
                      child: BaseSearchWidget(
                        applySearchFilters: applySearchFilters,
                        applyFilters: applyFilters,
                        commonFilters: state.commonFilters ??
                            CommonFilters(
                              statuses: [],
                              regions: [],
                            ),
                      ),
                    ),



                    //  ListView - start immediately below search bar
                    Positioned(
                      top: MediaQuery
                          .of(context)
                          .padding
                          .top + kToolbarHeight + 10,
                      // search bar height ~64+padding
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child:  CustomMaterialIndicator(
                        onRefresh: () => _onRefresh(),
                        backgroundColor: Colors.white,
                        indicatorBuilder: (context, controller) {
                          return const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: BaseLoader(),
                          );
                        },
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
                            List<Label> labels = [];
                            if (index < state.items.length) {
                              labels.add(Label(
                                  key: state.labels?.locale.inputDate ??
                                      state.labels?.defaultLocale.inputDate ??
                                      Constants.dateofcreation,
                                  value: state.items[index].inputDate != null
                                      ? Utils.timestampToDateConversion(
                                      int.parse(
                                          state.items[index].inputDate ??
                                              '0'),
                                      Constants
                                          .twentyFourHourDateTimeFormat)
                                      : ''));
                              labels.add(
                                Label(
                                  key: state.labels?.locale.locationRegion ??
                                      state.labels?.defaultLocale
                                          .locationRegion ??
                                      Constants.region,
                                  value:
                                  state.items[index].locationRegion?.name ??
                                      '',
                                ),
                              );
                              labels.add(
                                Label(
                                  key: state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      Constants.location,
                                  value:
                                  state.items[index].location?.name ?? '',
                                ),
                              );
                              labels.add(Label(
                                  key: state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      Constants.createdby,
                                  value:
                                  '${state.items[index].entrySecurity?.firstName ?? ''} ${state.items[index].entrySecurity?.lastName ?? ''}'));
                              return index >= state.items.length
                                  ? const BaseLoader()
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
                                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
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
                                              child:BaseListTileItem(
                                                id: state.items[index].id,
                                                labels: labels,
                                                status: state.items[index].status,
                                                transportIncidentType:
                                                state.items[index].incidentType,
                                                isMasterGuard: false,
                                                isEventProtectionStatus: false,
                                                isTransportStatus: true,
                                                onTap: (selectedIndex) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext dialogContext) {
                                                      return BasePopUpItems(
                                                        id: state.items[selectedIndex].id
                                                            .toString(),
                                                        labels: labels,
                                                        slNo: state
                                                            .items[selectedIndex].slNo,
                                                        status: state
                                                            .items[selectedIndex].status,
                                                        transportIncidentType: state
                                                            .items[selectedIndex]
                                                            .incidentType,
                                                        isMasterGuard: false,
                                                        isEventProtectionStatus: false,
                                                        isTransportStatus: true,
                                                      );
                                                    },
                                                  );
                                                },
                                                showEditButton:
                                                state.items[index].status ==
                                                    ConstantsIntValue
                                                        .incidentCreatedStatus ||
                                                  state.items[index].status ==
                                                      ConstantsIntValue.transportIncidentOpenStatus,
                                                onEditTap: (selectedIndex) {
                                                  getById(
                                                      state.extraProperties
                                                          ?.hasWritePermission ??
                                                          false,
                                                      state.items[index]
                                                          .id ??
                                                          0);
                                                },
                                                onViewTap: (selectedIndex) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext dialogContext) {
                                                      return BasePopUpItems(
                                                        id: state.items[selectedIndex].id
                                                            .toString(),
                                                        labels: labels,
                                                        slNo: state
                                                            .items[selectedIndex].slNo,
                                                        status: state
                                                            .items[selectedIndex].status,
                                                        isMasterGuard: false,
                                                        isEventProtectionStatus: false,
                                                        isIncident: true,
                                                        transportIncidentType: state
                                                            .items[selectedIndex]
                                                            .incidentType,
                                                      );
                                                    },
                                                  );
                                                },
                                                index: index,
                                              )))) );
                            }

                            // Handle the case where index is out of bounds
                            return const Center(
                              child: SizedBox(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }),
        );
      },
    );
  }

  // getById(bool hasWritePermission,
  //     {required int id}) async {
  //   Navigator.pushNamed(
  //     context,
  //     transportMedicalDetailsRoute,
  //     arguments: {
  //       ConstantsArgument.title: widget.isTransport ? Constants.transportIncidentList : Constants.medicalEmergencyTitle,
  //       ConstantsArgument.id: id.toString(),
  //       ConstantsArgument.extraProperties:
  //       ExtraProperties(hasWritePermission: hasWritePermission),
  //       ConstantsArgument.isTransport : widget.isTransport
  //     },
  //   );
  // }
  getById(bool hasWritePermission,int id) async {
    showLoadingDialog(context);

    TransportMedicalModel model =
    await TransportMedicalServices().getTransportById(id.toString());

    editDataLoading(model, hasWritePermission);
  }

  void editDataLoading(
      TransportMedicalModel? model, bool hasWritePermission) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(context, transportMedicalDetailsRoute, arguments: {
        "model": model,
        "title": Constants.editDayPassManagementTitle,
        ConstantsArgument.extraProperties:
        ExtraProperties(hasWritePermission: hasWritePermission),
        ConstantsArgument.isTransport : widget.isTransport
      });
    }
  }


  void applySearchFilters(
      FilterCriteria model,
      ) {
    log('Applying Search Filters');

    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<TransportMedicalBloc>(context).add(
      FetchTMData(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
  }

  void applyFilters(
      Filters model,
      ) {
    log('Applying Filters');

    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
    log('id---filtersFun----${filters.filterCriteria!.filters!.id}---');

    BlocProvider.of<TransportMedicalBloc>(context).add(
      FetchTMData(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
