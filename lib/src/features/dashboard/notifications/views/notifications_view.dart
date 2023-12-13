import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/contact_details/services/contact_details_services.dart';

import '../bloc/notifications_bloc.dart' as nb;

class NotificationsView extends StatefulWidget {
  const NotificationsView({
    super.key,
  });

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
    context.read<nb.NotificationsBloc>().add(
          const nb.InitializeValues(),
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
      context
          .read<nb.NotificationsBloc>()
          .add(nb.FetchData(startPos: pageNumber, maxPos: 20));
    }
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    log('-----didUpdateWidget----------');
    // This method is called when the widget is updated or rebuilt
    // You can perform actions here when the state is resumed
    setState(() {
      // Fetch or update yourItemList here
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   log('-----didChangeDependencies----------');
  //   // Fetch or update yourItemList here
  //   _scrollController = ScrollController()..addListener(_onScroll);
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      // floatingActionButton: Flutterfloatingbutton(
      //   backgroundColor: AppColors.navigationSkybluecolor,
      //   foregroundColor: AppColors.backgroundWhitecolor,
      //   onPressed: () => {
      //     Navigator.pushNamed(context, contactDetailsRoute, arguments: {
      //       "title": Constants.notifications,
      //     })
      //   },
      // ),
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: Constants.notifications,
        showPopUp: true,
        showSaveButton: false,
        excelAPIName: 'exportGcdExcel',
        pdfAPIName: 'exportGcdPDF',
      ),
      body: BlocConsumer<nb.NotificationsBloc, nb.NotificationsState>(
        listener: (context, state) {
          if (state.status == FormStatus.sessionExpired) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.message ?? 'Session Expired...')));
            Validator.logoutAction(context);
          }
        },
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
            ),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.items.length
                  : state.items.length + 1,
              itemBuilder: (context, index) {
                if (index < state.items.length) {
                  return index >= state.items.length
                      ? const BaseLoader()
                      : const NotificationTile();
                }
                return null;
              },
            ),
          );
        },
      ),
    );
  }

  getLawEnforcementId(int id) async {
    showLoadingDialog(context);

    ContactDetailModel materialMovementModel =
        await ContactDetailsServices().getGcdById(id);

    editDataLoading(materialMovementModel);
  }

  void editDataLoading(ContactDetailModel? model) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(
        context,
        contactDetailsRoute,
        arguments: {
          "model": model,
          "title": Constants.contactDetails,
        },
      );
    }
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.5),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                color: AppColors.searchBarBorder, width: 1,),
            borderRadius: circularBorderRadius10,
          ),
          child: InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              // widget.onTap != null ? widget.onTap!(widget.index) : null;
            },
            borderRadius: BorderRadius.circular(8),
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Incoming Material Record Added.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text('1 hour ago'),
                    ],
                  ),
                  Text(
                    'Ashok has created the record for 5 items.',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
