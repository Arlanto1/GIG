import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/notifications/notification_list/bloc/notifications_bloc.dart'
    as nb;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../bloc/notifications_bloc.dart';

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
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

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

  void deleteAllNotification() {
    BlocProvider.of<nb.NotificationsBloc>(context)
        .add(const nb.DeleteAllRecords());
  }

  void _onRefresh() async {
    context.read<NotificationsBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) {
      setState(() {});
    }
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: Constants.notifications,
        showPopUp: false,
        showSaveButton: false,
        showSubmitButton: false,
        showCustomIcon: true,
        showDisLikeButton: false,
        showLikeButton: false,
        popAndReplace: () {
          log('--popAndReplace-----');
          // Navigator.pop(context);
          Navigator.pop(context);
          Navigator.popAndPushNamed(
            context,
            dashboardViewRoute,
          );
        },
        customIcon: Icons.delete_sweep,
        onTapCustomIcon: deleteAllNotification,
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
            margin: allMargin4,
            decoration: const ShapeDecoration(
              color: AppColors.backgroundWhitecolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: SmartRefresher(
                    controller: refreshController,
                    enablePullDown: true,
                    physics: const BouncingScrollPhysics(),
                    header: const WaterDropHeader(
                      waterDropColor: AppColors.navigationSkybluecolor,
                      refresh: BaseLoader(),
                    ),
                    key: const Key(Keys.refreshKey),
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.hasReachedMax
                          ? state.items.length
                          : state.items.length + 1,
                      itemBuilder: (context, index) {
                        if (index < state.items.length) {
                          return index >= state.items.length
                              ? const BaseLoader()
                              : NotificationTile(item: state.items[index]);
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.item,
  });

  final NotificationModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: Slidable(
        key: key,
        // startActionPane: ActionPane(
        //   // A motion is a widget used to control how the pane animates.
        //   motion: const ScrollMotion(),
        //
        //   // A pane can dismiss the Slidable.
        //   dismissible: DismissiblePane(onDismissed: () {}),
        //
        //   // All actions are defined in the children parameter.
        //   children: [
        //     // A SlidableAction can have an icon and/or a label.
        //     SlidableAction(
        //       onPressed: deleteNotification,
        //       backgroundColor: const Color(0xFFFE4A49),
        //       foregroundColor: Colors.white,
        //       icon: Icons.delete,
        //       label: 'Delete',
        //     ),
        //     SlidableAction(
        //       onPressed: deleteNotification,
        //       backgroundColor: const Color(0xFF21B7CA),
        //       foregroundColor: Colors.white,
        //       icon: Icons.share,
        //       label: 'Share',
        //     ),
        //   ],
        // ),
        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            // SlidableAction(
            //   // An action can be bigger than the others.
            //   flex: 2,
            //   onPressed: deleteNotification,
            //   backgroundColor: const Color(0xFF7BC043),
            //   foregroundColor: Colors.white,
            //   icon: Icons.archive,
            //   label: 'Archive',
            // ),
            SlidableAction(
              onPressed: deleteNotification,
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.save,
              label: 'Remove',
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            // Mark Notification as Read
            // BlocProvider.of<nb.NotificationsBloc>(context).add(nb.ReadRecord(item.id!));
            Navigator.pushNamed(
              context,
              notificationDetailsViewRoute,
              arguments: {
                ConstantsArgument.id: item.id.toString(),
              },
            );
            // Your onTap logic here
            // showDialog(
            //   context: context,
            //   builder: (BuildContext dialogContext) {
            //     return const NotificationPopUpItems();
            //   },
            // );
          },
          borderRadius: BorderRadius.circular(8),
          child: ColoredBox(
            color: item.status == 0
                ? AppColors.white
                : AppColors.disabletextfieldBackground,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Text(
                          '${item.content?.subject}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        Utils.timestampToDateConversion(
                          int.tryParse(item.createdDate ?? ''),
                          Constants.dateFormat,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${item.email}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        Utils.timestampToDateConversion(
                          int.tryParse(item.createdDate ?? ''),
                          Constants.timeFormat,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void deleteNotification(BuildContext context) {
    BlocProvider.of<nb.NotificationsBloc>(context)
        .add(nb.DeleteRecord(item.id!));
  }
}
