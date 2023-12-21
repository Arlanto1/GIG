import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/notifications/bloc/notifications_bloc.dart'
    as nb;
import 'package:flutter_slidable/flutter_slidable.dart';

import 'notification_popup.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: Constants.notifications,
        showPopUp: false,
        showSaveButton: false,
        showCustomIcon: true,
        customIcon: Icons.clear_all,
        onTapCustomIcon: () {},
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
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Slidable(
          key: key,
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            dismissible: DismissiblePane(onDismissed: () {}),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: doNothing,
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
              SlidableAction(
                onPressed: doNothing,
                backgroundColor: const Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.share,
                label: 'Share',
              ),
            ],
          ),
          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                // An action can be bigger than the others.
                flex: 2,
                onPressed: doNothing,
                backgroundColor: const Color(0xFF7BC043),
                foregroundColor: Colors.white,
                icon: Icons.archive,
                label: 'Archive',
              ),
              SlidableAction(
                onPressed: doNothing,
                backgroundColor: const Color(0xFF0392CF),
                foregroundColor: Colors.white,
                icon: Icons.save,
                label: 'Save',
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              // Your onTap logic here
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return const NotificationPopUpItems(
                  );
                },
              );
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
      ),
    );
  }

  void doNothing(BuildContext context) {}
}
