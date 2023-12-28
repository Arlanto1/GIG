import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/notifications/notification_details/cubits/notification_details_cubit.dart';
import 'package:flutter_html/flutter_html.dart';

class NotificationDetailsView extends StatefulWidget {
  const NotificationDetailsView({
    super.key,
  });

  @override
  State<NotificationDetailsView> createState() =>
      _NotificationDetailsViewState();
}

class _NotificationDetailsViewState extends State<NotificationDetailsView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotificationDetailsCubit>(context).initializeValues();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<NotificationDetailsCubit, NotificationDetailsState>(
      listener: (context, state) {
        log('--NN-state.status-${state.status}-------');

        if (state.status == FormStatus.success) {
          Navigator.pop(context);

          // var dialog = CustomAlertDialog(
          //   title: 'Material Movement',
          //   message: state.message ?? '',
          //   positiveBtnText: Constants.ok,
          //   onPostivePressed: () {
          //     // TODO: Need to improve this code
          //     Navigator.pop(context);
          //   },
          // );
          // showDialog(
          //     context: context,
          //     barrierDismissible: false,
          //     builder: (BuildContext context) => dialog);

          // Utils.dynamicAlert(
          //     context, state.message ?? '', 'Material Movement', '');
        }
        if (state.status == FormStatus.error) {
          Validator().showToast(
            context,
            state.message ?? 'Invalid Information',
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.notifications,
            showPopUp: false,
            showSaveButton: false,
            showSubmitButton: false,
            onTapSave: () {},
            showCustomIcon: true,
            customIcon: Icons.delete,
            onTapCustomIcon: deleteNotification,
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void deleteNotification() {
    BlocProvider.of<NotificationDetailsCubit>(context).deleteNotification();
  }

  getBodybuilder(NotificationDetailsState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }
    return Container(
      color: AppColors.navigationSkybluecolor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.01,
              color: AppColors.navigationSkybluecolor,
            ),
            Container(
              decoration: const ShapeDecoration(
                color: AppColors.backgroundWhitecolor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${state.model.content?.subject}',
                            style: Styles.styleHeaderGreyText30,
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        CommonWidgets.verticalSpacerWidget(height * 0.001),
                        SingleChildScrollView(
                          child: Html(
                            data: """
                <div>Follow<a class='sup'><sup>pl</sup></a> 
                  Below hr
                    <b>Bold</b>
                <h1>Sample Notification Detail.</h1>, 
                and do not follow other guardians apart from Him. Little do 
                <span class='h'>you remind yourselves</span><a class='f'><sup f=2437>1</sup></a></div>
                """,
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.04),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getStatusString(int status) {
    switch (status) {
      case 0:
        return 'Draft';
      case 1:
        return 'Active';
      default:
        return '';
    }
  }

  Widget cancelButtonDisplay() {
    return AppButton(
      // Customize the button properties as needed
      width: 150,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
