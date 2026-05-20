import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/notifications/notification_list/bloc/notifications_bloc.dart'
    as nb;
import 'package:flutter_slidable/flutter_slidable.dart';

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
    var dialog = CustomAlertDialog(
        title: Constants.deleteAllNotifications,
        message: Constants.deleteAllNotificationWarningMessage,
        onPositivePressed: () {
          BlocProvider.of<nb.NotificationsBloc>(context)
              .add(const nb.DeleteAllRecords());
          Navigator.pop(context);
        },
        positiveBtnText: Constants.yes,
        negativeBtnText: Constants.no);
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  Future<void> _onRefresh() async {
    context.read<NotificationsBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
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
          Utils().formError(state, context);
          Utils().errorAndLogout(state, context);
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
              CustomMaterialIndicator(
                onRefresh: () => _onRefresh(),
                backgroundColor: Colors.white,
                indicatorBuilder: (context, controller) {
                  return const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: BaseLoader(),
                  );
                },

                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: state.items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return NotificationTile(item: state.items[index]);
                  },
                ),
              ),
            ],
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
        key: ValueKey(item.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.23, // how much space the button occupies
          children: [
            CustomSlidableAction(
              onPressed: (context) => deleteNotification(context),
              borderRadius: BorderRadius.circular(40),
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.red.shade600,
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.red[600]!, Colors.orange[600]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete, color: Colors.white),
                    SizedBox(height: 4),
                    Text(
                      'Remove',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              notificationDetailsViewRoute,
              arguments: {ConstantsArgument.id: item.id.toString()},
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.2),
                      Colors.transparent,
                      Colors.white.withValues(alpha: 0.2),
                      // Color(0xFF6474C6).withOpacity(0.14)
                    ],
                    stops: [0.02, 0.35, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(27),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.80),
                    width: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6474C6).withValues(alpha: 0.09),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
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
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          Utils.timestampToDateConversion(
                            int.tryParse(item.createdDate ?? ''),
                            Constants.dateFormat,
                          ),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${item.email}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          Utils.timestampToDateConversion(
                            int.tryParse(item.createdDate ?? ''),
                            Constants.timeFormat,
                          ),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
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
      ),
    );
  }

  void deleteNotification(BuildContext context) {
    BlocProvider.of<nb.NotificationsBloc>(context)
        .add(nb.DeleteRecord(item.id!));
  }
}
