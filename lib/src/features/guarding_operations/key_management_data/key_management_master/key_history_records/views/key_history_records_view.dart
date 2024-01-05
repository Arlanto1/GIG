// import 'dart:developer';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/contact_details/services/contact_details_services.dart';
//
// import '../bloc/key_history_record_bloc.dart' as kh;
// import 'add_key_history_pop_up.dart';
//
// class KeyHistoryRecordsView extends StatefulWidget {
//   const KeyHistoryRecordsView({
//     super.key,
//     required this.id,
//     required this.title,
//     required this.type,
//     required this.rankType,
//   });
//
//   final int id;
//   final String title;
//   final int type;
//   final String rankType;
//
//   @override
//   State<KeyHistoryRecordsView> createState() => _KeyHistoryRecordsViewState();
// }
//
// class _KeyHistoryRecordsViewState extends State<KeyHistoryRecordsView> {
//   late final ScrollController _scrollController;
//   int pageNumber = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<kh.KeyHistoryRecordBloc>().add(
//           const kh.InitializeValues(),
//         );
//     _scrollController = ScrollController()..addListener(_onScroll);
//   }
//
//   @override
//   void dispose() {
//     _scrollController
//       ..removeListener(_onScroll)
//       ..dispose();
//     super.dispose();
//   }
//
//   void _onScroll() {
//     if (!_scrollController.hasClients) return;
//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final currentScroll = _scrollController.position.pixels;
//     if (currentScroll == maxScroll) {
//       pageNumber = pageNumber + 20;
//       context.read<kh.KeyHistoryRecordBloc>().add(kh.FetchData(
//           id: widget.id, type: widget.type, startPos: pageNumber, maxPos: 20));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<kh.KeyHistoryRecordBloc, kh.KeyHistoryRecordState>(
//         listener: (context, state) {
//       // TODO: implement listener
//     }, builder: (context, state) {
//       return Scaffold(
//         backgroundColor: AppColors.cardBgColor,
//         floatingActionButton: Flutterfloatingbutton(
//           backgroundColor: AppColors.navigationSkybluecolor,
//           foregroundColor: AppColors.backgroundWhitecolor,
//           onPressed: () {
//             showAddContactPopUp(
//                 context: context,
//                 contact: ContactRecord(
//                   contactId: widget.id,
//                   email: '',
//                   contactNo: '',
//                   rank: Organisation(),
//                   type: widget.type,
//                 ),
//                 users: state.ranks,
//                 rankType: widget.rankType);
//           },
//         ),
//         appBar: BaseAppBar().buildAppHeader(
//           context: context,
//           title: widget.title,
//           showPopUp: true,
//           showSaveButton: false,
//           showSubmitButton: false,
//           excelAPIName: 'exportMMExcel',
//           pdfAPIName: 'exportMMPDF',
//         ),
//         body: getBody(state),
//       );
//     });
//   }
//
//   getBody(kh.KeyHistoryRecordState state) {
//     if (state.status == FormStatus.initial ||
//         state.status == FormStatus.loading) {
//       return const BaseLoader();
//     }
//
//     if (state.items.isEmptyOrNull) {
//       return const NoRecordFoundWidget();
//     }
//     return Container(
//       margin: allMargin16,
//       decoration: const ShapeDecoration(
//           color: AppColors.backgroundWhitecolor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
//           )),
//       child: ListView.builder(
//         controller: _scrollController,
//         itemCount:
//             state.hasReachedMax ? state.items?.length : state.items!.length + 1,
//         itemBuilder: (context, index) {
//           List<Label> labels = [];
//           if (index < state.items!.length) {
//             labels.add(
//               Label(
//                 key: 'Email',
//                 value: state.items![index].doorName ?? '',
//               ),
//             );
//             labels.add(
//               Label(
//                 key: 'Rank',
//                 value: state.items![index].doorName ?? '',
//               ),
//             );
//             labels.add(
//               Label(
//                 key: 'Contact No',
//                 value: state.items![index].doorName ?? '',
//               ),
//             );
//             return index >= state.items!.length
//                 ? const BaseLoader()
//                 : BaseListTileItem(
//                     id: state.items?[index].id,
//                     labels: labels,
//                     onTap: (selectedIndex) {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext dialogContext) {
//                           return BasePopUpItems(
//                             id: state.items?[selectedIndex].id.toString(),
//                             labels: labels,
//                           );
//                         },
//                       );
//                     },
//                     onEditTap: (selectedIndex) async {
//                       ContactRecord contactsModel =
//                           await ContactDetailsServices()
//                               .getCdById(state.items?[index].id ?? 0);
//
//                       log('--state.users--llen--${state.ranks.length}---');
//
//                       showAddContactPopUp(
//                           context: context,
//                           contact: contactsModel,
//                           users: state.ranks,
//                           rankType: widget.rankType);
//                       getDetails(state.items?[index].id ?? 0);
//                     },
//                     onViewTap: (selectedIndex) {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext dialogContext) {
//                           return BasePopUpItems(
//                             id: state.items?[selectedIndex].id.toString(),
//                             labels: labels,
//                           );
//                         },
//                       );
//                     },
//                     onDeleteTap: (selectedIndex) async {
//                       // Call Delete API
//                       // BlocProvider.of<ContactRecordBloc>(context).add(
//                       //     DeleteRecord(state.items![selectedIndex].id!.toInt(),
//                       //         widget.type, widget.id));
//                     },
//                     index: index,
//                   );
//           }
//           return null;
//         },
//       ),
//     );
//   }
//
//   showAddContactPopUp({
//     required BuildContext context,
//     required ContactRecord contact,
//     required final List<Organisation> users,
//     required String rankType,
//   }) {
//     log('--.users--llen--${users.length}---');
//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AddKeyHistoryPopUp(
//           title: widget.title,
//           model: contact,
//           mainContext: context,
//           users: users,
//           rankType: rankType,
//           onSubmit: (KeyManagementMasterModel model) {
//             //loginFormKey.currentState!.validate();
//             FocusScope.of(context).unfocus();
//
//             log('-widget.title---${widget.title}----');
//
//             BlocProvider.of<kh.KeyHistoryRecordBloc>(context)
//                 .add(kh.SaveRecord(model, widget.id, widget.type));
//           },
//         );
//       },
//     );
//   }
//
//   getDetails(int id) async {
//     showLoadingDialog(context);
//
//     ContactRecord contactsModel = await ContactDetailsServices().getCdById(id);
//
//     editDataLoading(contactsModel);
//   }
//
//   void editDataLoading(ContactRecord? model) {
//     dismissLoadingDialog(context);
//     if (model != null) {
//       Navigator.pushNamed(
//         context,
//         contactDetailsRoute,
//         arguments: {
//           "model": model,
//           "title": Constants.contactDetails,
//         },
//       );
//     }
//   }
// }
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/key_management_master_list/bloc/key_management_master_list_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/key_management_master_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/services/key_management_master_services.dart';
import 'package:intl/intl.dart';

import '../bloc/key_history_record_bloc.dart';

class KeyHistoryRecordsView extends StatefulWidget {
  const KeyHistoryRecordsView({
    super.key,
    required this.id,
    required this.type,
  });

  final int id;
  final int type;

  @override
  State<KeyHistoryRecordsView> createState() => _KeyHistoryRecordsViewState();
}

class _KeyHistoryRecordsViewState extends State<KeyHistoryRecordsView> {
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
      context.read<KeyHistoryRecordBloc>().add(FetchData(
          startPos: pageNumber, maxPos: 20, id: widget.id, type: widget.type));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton: Flutterfloatingbutton(
          backgroundColor: AppColors.navigationSkybluecolor,
          foregroundColor: AppColors.backgroundWhitecolor,
          onPressed: () => {
            Navigator.pushNamed(context, keyHistoryRecordsDetailsRoute,
                arguments: {"title": Constants.createkeyManagementMaster}),
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.keyManagementMaster,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          excelAPIName: 'exportGMDataExcel',
          pdfAPIName: 'exportGMDataPDF',
        ),
        body: BlocBuilder<KeyHistoryRecordBloc, KeyHistoryRecordState>(
            builder: (context, state) {
          if (state.status == FormStatus.initial) {
            return const BaseLoader();
          }
          if (state.list.isEmptyOrNull) {
            return const NoRecordFoundWidget();
          }
          // log('--labels-${state.labels?.locale.locationRegion}');
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
                  ? state.list.length
                  : state.list.length + 1,
              itemBuilder: (context, index) {
                List<Label> labels = [];
                if (index < state.list.length) {
                  labels.add(Label(
                      // key: state.labels?.locale.locationRegion ??
                      //  state.labels?.defaultLocale.locationRegion ??
                      key: 'Floor',
                      value: state.list[index].floor.toString()));
                  labels.add(Label(
                      key:
                          // state.labels?.locale.location ??
                          //state.labels?.defaultLocale.location ??
                          'Created By',
                      value: state.list[index].createdBy?.name ?? ''));
                  // labels.add(Label(
                  //     key: 'Date of Creation',
                  //     value: DateFormat('dd-MM-yyyy').format(
                  //         DateTime.fromMillisecondsSinceEpoch(
                  //             state.list[index].createdDate ?? 0 * 1000))));
                }
                return index >= state.list.length
                    ? const BaseLoader()
                    : BaseListTileItem(
                        id: state.list[index].id,
                        labels: labels,
                        status: state.list[index].status,
                        isKeyManagementStatus: true,
                        isEventProtectionStatus: false,
                        onTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.list[selectedIndex].id.toString(),
                                slNo: state.list[selectedIndex].slNo,
                                labels: labels,
                                status: state.list[selectedIndex].status,
                                keyNo: state.list[selectedIndex].keyNo,
                                keyTagging:
                                    state.list[selectedIndex].keyTagging,
                                doorName: state.list[selectedIndex].doorName,
                                isKeyManagementStatus: true,
                                isEventProtectionStatus: false,
                                isMasterGuard: false,
                              );
                            },
                          );
                        },
                        onEditTap: (selectedIndex) {
                          getById(state.list[index].id ?? 0);
                        },
                        showEditButton: true,
                        onViewTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.list[selectedIndex].id.toString(),
                                slNo: state.list[selectedIndex].slNo,
                                labels: labels,
                                status: state.list[selectedIndex].status,
                                keyNo: state.list[selectedIndex].keyNo,
                                keyTagging:
                                    state.list[selectedIndex].keyTagging,
                                doorName: state.list[selectedIndex].doorName,
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

    KeyManagementMasterModel keyManagementMasterModel =
        await KeyManagementMasterServices().getKHById(id);

    editDataLoading(keyManagementMasterModel);
  }

  void editDataLoading(KeyManagementMasterModel? keyManagementMasterModel) {
    dismissLoadingDialog(context);
    if (keyManagementMasterModel != null) {
      Navigator.pushNamed(context, keyHistoryRecordsDetailsRoute, arguments: {
        "keyMgmtGi": keyManagementMasterModel,
        "title": Constants.editkeyManagementMaster
      });
    }
  }
}
