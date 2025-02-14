import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/annual_power_shutdown_list/annual_power_shutdown_list/bloc/annual_power_shutdown_list_bloc.dart'
    as asp;
import 'package:db_atom/src/features/annual_power_shutdown_list/annual_power_shutdown_list/views/annual_power_shutdown_list_view.dart';
import 'package:db_atom/src/features/annual_power_shutdown_list/annual_power_shutdown_list_details/cubits/annual_power_shutdown_list_details_cubit.dart';
import 'package:db_atom/src/features/annual_power_shutdown_list/annual_power_shutdown_list_details/views/annual_power_shutdown_list_details_view.dart';
import 'package:db_atom/src/features/annual_power_shutdown_list/services/annual_power_shutdown_services.dart';
import 'package:db_atom/src/features/article_found_register_module/article_found_list/bloc/article_found_bloc.dart'
    as af;
import 'package:db_atom/src/features/article_found_register_module/article_found_list/views/article_found_list_view.dart';
import 'package:db_atom/src/features/contact_details/contact_details_list/bloc/contact_details_list_bloc.dart'
    as cd;
import 'package:db_atom/src/features/contact_details/contact_records/bloc/contact_record_bloc.dart'
    as cr;
import 'package:db_atom/src/features/contact_details/services/contact_details_services.dart';
import 'package:db_atom/src/features/dashboard/notifications/notification_details/cubits/notification_details_cubit.dart';
import 'package:db_atom/src/features/dashboard/notifications/notification_details/views/notification_details_view.dart';
import 'package:db_atom/src/features/dashboard/notifications/notification_list/bloc/notifications_bloc.dart';
import 'package:db_atom/src/features/dashboard/notifications/notification_list/views/notifications_view.dart';
import 'package:db_atom/src/features/dashboard/notifications/services/notifications_services.dart';
import 'package:db_atom/src/features/event_protection/event_protections/bloc/event_protections_bloc.dart'
    as ep;
import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/services/guarding_master_data_services.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/guarding_rates/bloc/guarding_rates_bloc.dart'
    as guarding;
import 'package:db_atom/src/features/guarding_operations/guarding_rate/services/guarding_services.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/services/key_management_issuance_services.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/key_history_records/bloc/key_history_record_bloc.dart'
    as kh;
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/key_history_records/views/key_history_records_view.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/key_management_master_details/cubits/key_management_master_details_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/key_management_master_details/views/key_management_master_details_view.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/key_management_master_list/bloc/key_management_master_list_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/key_management_master_list/views/key_management_master_list_view.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/services/key_management_master_services.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/attendance/views/attendance_view.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/attendance_details/cubits/attendance_details_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/attendance_shifts/views/attendance_shifts_view.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance_report_billing/bloc/attendance_report_billing_bloc.dart'
    as arb;
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance_report_billing/views/attendance_report_billing_view.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/duty_post_master_details/cubits/duty_post_master_details_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/duty_post_master_details/views/duty_post_master_details_view.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/duty_post_master_list/bloc/duty_post_master_list_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/duty_post_master_list/views/duty_post_master_list_view.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/services/duty_post_master_services.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/services/duty_post_name_master_services.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/shift_schedule_details_view.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_list/bloc/shift_schedule_list_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_list/views/shift_schedule_list_view.dart';
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/sla_violation_penalty_list/bloc/sla_violation_penalty_list_bloc.dart'
    as sla;
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/violation_penalty_record/bloc/violation_penalty_record_bloc.dart'
    as vp;
import 'package:db_atom/src/features/guarding_operations/vvip_visitor/services/vvip_visitor_services.dart';
import 'package:db_atom/src/features/guarding_operations/vvip_visitor/vvip_visitors/views/vvip_visitors_view.dart';
import 'package:db_atom/src/features/incident_management/incident_managements/bloc/incident_management_bloc.dart'
    as im;
import 'package:db_atom/src/features/incident_management/services/incident_management_services.dart';
import 'package:db_atom/src/features/lawenforcement/views/visiting_officials_list/bloc/visiting_officials_list_bloc.dart'
    as vo;
import 'package:db_atom/src/features/lawenforcement/views/visiting_officials_list/views/visiting_officials_list_view.dart';
import 'package:db_atom/src/features/login/services/login_services.dart';
import 'package:db_atom/src/features/material_movement/material_movements/bloc/material_movement_bloc.dart'
    as mm;
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/services/occurrences_services.dart';
import 'package:db_atom/src/features/occurrenceList/bloc/occurrences_bloc.dart'
    as ocb;
import 'package:db_atom/src/features/passmanagement/day_passmangement/day_passmanagement_list/bloc/day_passmanagement_list_bloc.dart';
import 'package:db_atom/src/features/passmanagement/pass_management_list/bloc/pass_management_list_bloc.dart'
    as pm;
import 'package:db_atom/src/features/passmanagement/pass_management_list/views/pass_manangement_list_view.dart';
import 'package:db_atom/src/features/security_systems/services/sst_incident_services.dart';
import 'package:db_atom/src/features/security_systems/sst_incident_list/bloc/sst_incident_bloc.dart'
    as sv;
import 'package:db_atom/src/features/ticketing_system/models/ticketing_system_model.dart';
import 'package:db_atom/src/features/ticketing_system/services/ticketing_system_services.dart';
import 'package:db_atom/src/features/ticketing_system/ticketing_system_details/cubits/ticketing_system_details_cubit.dart';
import 'package:db_atom/src/features/ticketing_system/ticketing_system_details/views/ticketing_system_details_view.dart';
import 'package:db_atom/src/features/ticketing_system/ticketing_systems/bloc/ticketing_system_bloc.dart';
import 'package:db_atom/src/features/ticketing_system/ticketing_systems/views/ticketing_system_view.dart';

import '../features/guarding_operations/key_management_data/key_loss_destruction_list/key_loss_destruction_details/cubits/key_loss_destruction_details_cubit.dart';
import '../features/guarding_operations/key_management_data/key_loss_destruction_list/key_loss_destruction_details/views/key_loss_destruction_details_view.dart';
import '../features/guarding_operations/key_management_data/key_loss_destruction_list/key_loss_destruction_list/bloc/key_loss_destruction_list_bloc.dart';
import '../features/guarding_operations/key_management_data/key_loss_destruction_list/key_loss_destruction_list/views/key_loss_destruction_list_view.dart';
import '../features/guarding_operations/key_management_data/key_loss_destruction_list/models/key_loss_destruction_list_model.dart';
import '../features/guarding_operations/key_management_data/key_loss_destruction_list/services/key_loss_destruction_list_services.dart';
import '../features/guarding_operations/key_management_data/key_management_issuance/key_issuance_process_record/bloc/key_issuance_process_record_bloc.dart'
    as kip;
import '../features/guarding_operations/key_management_data/key_management_issuance/key_issuance_process_record/views/key_issuance_process_record_view.dart';
import '../features/guarding_operations/key_management_data/key_management_issuance/key_management_issuance_details/cubits/key_management_issuance_details_cubits.dart';
import '../features/guarding_operations/key_management_data/key_management_issuance/key_management_issuance_details/views/key_management_issuance_details_view.dart';
import '../features/guarding_operations/key_management_data/key_management_issuance/key_management_issuance_list/bloc/key_management_issuance_list_bloc.dart';
import '../features/guarding_operations/key_management_data/key_management_issuance/key_management_issuance_list/views/key_management_issuance_list_view.dart';
import '../features/guarding_operations/key_management_data/key_management_master/key_history_records_details/cubits/key_history_records_details_cubit.dart';
import '../features/guarding_operations/key_management_data/key_management_master/key_history_records_details/views/key_history_records_details_view.dart';
import '../features/guarding_operations/key_management_data/key_reconciliation_list/key_reconciliation_list/bloc/key_reconciliation_list_bloc.dart';
import '../features/guarding_operations/key_management_data/key_reconciliation_list/key_reconciliation_list/views/key_reconciliation_list_view.dart';
import '../features/guarding_operations/shift_scheduling/attendance/attendance/bloc/attendance_bloc.dart';
import '../features/guarding_operations/shift_scheduling/attendance/attendance_details/views/attendance_details_view.dart';
import '../features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
import '../features/guarding_operations/shift_scheduling/duty_post_name_master/duty_post_name_master_details/views/duty_post_name_master_details_view.dart';
import '../features/guarding_operations/shift_scheduling/duty_post_name_master/duty_post_name_master_list/bloc/duty_post_name_master_list_bloc.dart';
import '../features/guarding_operations/shift_scheduling/duty_post_name_master/duty_post_name_master_list/views/duty_post_name_master_list_view.dart';
import '../features/guarding_operations/vvip_visitor/models/vvip_visitor_response_model.dart';
import '../features/guarding_operations/vvip_visitor/vvip_visitor_details/cubits/vvip_visitor_details_cubit.dart';
import '../features/guarding_operations/vvip_visitor/vvip_visitor_details/views/vvip_visitor_details_view.dart';
import '../features/guarding_operations/vvip_visitor/vvip_visitors/bloc/vvip_visitors_bloc.dart'
    as vip;
import '../features/guarding_operations/vvip_visitor/vvip_visitors_record/bloc/vvip_visitors_record_bloc.dart'
    as vipr;
import '../features/guarding_operations/vvip_visitor/vvip_visitors_record/views/vvip_visitors_record_view.dart';
import '../features/passmanagement/day_passmangement/day_passmanagement_list/views/day_passmanagement_list_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    // ignore: non_constant_identifier_names
    switch (settings.name) {
      // case appRoute:
      //   return MaterialPageRoute(builder: (context) => const App());
      case dashboardViewRoute:
        CommonServices commonServices = CommonServices();
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ChartsCubit>(
            create: (_) => ChartsCubit(commonServices: commonServices),
            child: const DashboardView(),
          ),
        );

      case notificationsViewRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              BlocProvider<NotificationsBloc>(
            create: (_) => NotificationsBloc()
              ..add(const FetchData(startPos: 0, maxPos: 20)),
            child: const NotificationsView(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case notificationDetailsViewRoute:
        String id = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments['id'] ?? '';
        }
        NotificationServices services = NotificationServices();
        CommonServices commonServices = CommonServices();
        return MaterialPageRoute(
          builder: (context) => BlocProvider<NotificationDetailsCubit>(
            create: (_) => NotificationDetailsCubit(
              id: id,
              services: services,
              commonServices: commonServices,
            ),
            child: const NotificationDetailsView(),
          ),
        );
      case splashScreenRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case loginScreenRoute:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case forgotPwdScreenRoute:
        return MaterialPageRoute(builder: (context) => const ForgotPwdScreen());

      // case updatePasswordScreenRoute:
      //   return MaterialPageRoute(builder: (context) => const UpdatePasswordScreen());
      case resetPwdScreenRoute:
        bool viaNavigationDrawer = false;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          viaNavigationDrawer = arguments['viaNavigationDrawer'];
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<LoginBloc>(
            create: (_) => LoginBloc(loginService: LoginService()),
            child: ResetPasswordView(viaNavigationDrawer: viaNavigationDrawer),
          ),
        );

      case otpVerificationRoute:
        if (settings.arguments != null) {
          final userRoutes = settings.arguments as Map<String, dynamic>;
          VerifyOTPArguments? userDetails = userRoutes["userDetails"];
          return MaterialPageRoute(
            builder: (context) => OtpVerifyScreen(
              userName: userDetails?.name ?? '',
              password: userDetails?.pwd ?? '',
              deviceToken: userDetails?.deviceToken ?? '',
            ),
          );
        }
        return MaterialPageRoute(builder: (context) => const OtpVerifyScreen());

      case createFoundScreenRoute:
        if (settings.arguments != null) {
          final arguments = settings.arguments as Map<String, dynamic>;
          FoundListArticleDetails? model = arguments["UserElement"];
          ExtraProperties? extraProperties =
              arguments[ConstantsArgument.extraProperties];
          int? eventId = arguments[ConstantsArgument.eventId];
          String? eventProtectionId =
              arguments[ConstantsArgument.eventProtectionId];
          Organisation? location = arguments[ConstantsArgument.location];
          return MaterialPageRoute(
            builder: (context) => CreateFound(
              model: model,
              eventId: eventId,
              eventProtectionId: eventProtectionId,
              extraProperties: extraProperties,
              eventProtectionLocation: location,
            ),
          );
        } else {
          return MaterialPageRoute(builder: (context) => const CreateFound());
        }
      case addemployeedepartmentRoute:
        return MaterialPageRoute(
          builder: (context) => const AddEmployeeDepartment(
            title: Constants.addEmployeeDepartment,
          ),
        );

      // case articleFoundListRoute:
      //   return MaterialPageRoute(builder: (context) => const ArticleFoundListView());
      case articleFoundListRoute:
        int? eventId;
        String? eventProtectionId;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          eventId = arguments[ConstantsArgument.eventId];
          eventProtectionId = arguments[ConstantsArgument.eventProtectionId];
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<af.ArticleFoundBloc>(
            create: (_) => af.ArticleFoundBloc()
              ..add(
                af.FetchData(
                  startPos: 0,
                  maxPos: Constants.maxResults,
                  newSearch: true,
                  filters: BaseFilterModel(),
                  eventId: eventId,
                ),
              ),
            child: ArticleFoundListView(
              eventId: eventId,
              eventProtectionId: eventProtectionId,
            ),
          ),
        );

      case createFoundAttachmentRoute:
        return MaterialPageRoute(
            builder: (context) => const CreateFoundAttachment());
      case customexpansionlisttextsRoute:
        return MaterialPageRoute(
            builder: (context) => const CustomExpansionListTexts());
      case lawEnforcementListRoute:
        return MaterialPageRoute(
            builder: (context) => const LawEnforcementsView());

      case lawEnforcementDetailsViewRoute:
        // return MaterialPageRoute(builder: (context) => CreateLawenforcement());
        if (settings.arguments != null) {
          final listroutes = settings.arguments as Map<String, dynamic>;
          LawEnforcementDetailsModel? listuser = listroutes["UserElement"];
          ExtraProperties? extraProperties =
              listroutes[ConstantsArgument.extraProperties];
          return MaterialPageRoute(
              builder: (context) => LawEnforcementDetailsView(
                    model: listuser,
                    extraProperties: extraProperties,
                  ));
        } else {
          return MaterialPageRoute(
              builder: (context) => const LawEnforcementDetailsView());
        }

      case visitingOfficialListRoute:
        String title = '';
        int id = 0;
        int type = 0;
        bool showSaveButton = true;
        String? lock;
        // List<LawVisitingOfficial> visitingOfficials = [];
        List<Organisation> departments = [];
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id];
          title = arguments[ConstantsArgument.title];
          // type = arguments[ConstantsArgument.type] ?? 0;
          // visitingOfficials = arguments[ConstantsArgument.models] ?? [];
          departments = arguments[ConstantsArgument.departments] ?? [];
          showSaveButton = arguments[ConstantsArgument.showSaveButton];
          lock = arguments[ConstantsArgument.isLocked];
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<vo.VisitingOfficialListBloc>(
            create: (_) => vo.VisitingOfficialListBloc(
              parentId: id,
              departments: departments,
            )..add(vo.FetchData(
                id: id,
                type: type,
                startPos: 0,
                maxPos: 100,
              )),
            child: VisitingOfficialListView(
              id: id,
              type: type,
              title: title,
              showSaveButton: showSaveButton,
              lock: lock,
            ),
          ),
        );

      // case daypassmanagementListRoute:
      //   PassMngArguments? passMngArguments;
      //   if (settings.arguments != null) {
      //     final passRoutes = settings.arguments as Map<String, dynamic>;
      //     passMngArguments = passRoutes["passMngDetails"];
      //     return MaterialPageRoute(
      //         builder: (context) => DayPassManagementList(
      //               passId: passMngArguments!.passType,
      //               title: passMngArguments.title ?? '',
      //             ));
      //   }
      //   return MaterialPageRoute(
      //       builder: (context) => DayPassManagementList(
      //             passId: 0,
      //             title: passMngArguments?.title ?? '',
      //           ));

      case daypassmanagementListRoute:
        PassMngArguments? passMngArguments;
        if (settings.arguments != null) {
          final passRoutes = settings.arguments as Map<String, dynamic>;
          passMngArguments = passRoutes["passMngDetails"];
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<pm.PassManagementListBloc>(
            create: (_) =>
                pm.PassManagementListBloc(passId: passMngArguments!.passType)
                  ..add(pm.FetchData(
                      startPos: 0,
                      maxPos: Constants.maxResults,
                      newSearch: true,
                      filters: BaseFilterModel())),
            child: PassManagementListView(
              passId: passMngArguments!.passType,
              title: passMngArguments.title,
            ),
          ),
        );

      case daypassregistertListRoute:
        if (settings.arguments != null) {
          final passRoutes = settings.arguments as Map<String, dynamic>;
          PassMngArguments? passMngArguments =
              passRoutes["passMngRegisterDetails"];
          return MaterialPageRoute(
              builder: (context) => DayPassInfoListPage(
                    passId: passMngArguments?.passType.toString() ?? '',
                    title: passMngArguments?.title ?? '',
                  ));
        }
        return MaterialPageRoute(builder: (context) => DayPassInfoListPage());

      case createpassmgmtRoute:
        int passId = 0;
        ExtraProperties? extraProperties;

        if (settings.arguments != null) {
          final passRoutes = settings.arguments as Map<String, dynamic>;
          CreatePassMngArguments? passMngArguments =
              passRoutes["passMngCreateDetails"];
          extraProperties = passRoutes[ConstantsArgument.extraProperties];
          passId = passMngArguments!.passType;
          return MaterialPageRoute(
            builder: (context) => CreatePassManagement(
              passId: passMngArguments.passType,
              title: passMngArguments.title,
              model: passMngArguments.model,
              extraProperties: extraProperties,
            ),
          );
        }
        return MaterialPageRoute(
            builder: (context) => CreatePassManagement(
                  passId: passId,
                ));

      case incidentManagementsRoute:
        String occId = '';
        int occType = 0;
        String kldId = '';

        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          occId = arguments['occId'] ?? '';
          occType = arguments['occType'] ?? 0;
          kldId = arguments['kldId'] ?? '';
        }
        log('--occId-router-im list-$occId--');
        return MaterialPageRoute(
          builder: (context) => BlocProvider<im.IncidentManagementsBloc>(
            create: (_) => im.IncidentManagementsBloc(occType, occId, kldId)
              ..add(im.FetchData(
                  startPos: 0,
                  maxPos: Constants.maxResults,
                  newSearch: true,
                  filters: BaseFilterModel())),
            child: IncidentManagementsView(
              occId: occId,
              occType: occType,
              kldId: kldId,
            ),
          ),
        );

      case incidentManagementDetailsRoute:
        String id = '';
        String occId = '';
        int occType = 0;
        late int? keyType;
        late int? keyLostType;
        late int? keyIssuanceId;
        late int? kmId;
        String kldId = '';
        Organisation? location;
        ExtraProperties? extraProperties;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments['id'] ?? '';
          occId = arguments['occId'] ?? '';
          occType = arguments['occType'] ?? 0;
          kldId = arguments[ConstantsArgument.kldId] ?? '';
          keyType = arguments[ConstantsArgument.keyType];
          keyLostType = arguments[ConstantsArgument.keyLostType];
          location = arguments[ConstantsArgument.location];
          keyIssuanceId = arguments[ConstantsArgument.keyIssuanceId];
          extraProperties = arguments[ConstantsArgument.extraProperties];
          kmId = arguments[ConstantsArgument.kmId];
        }
        log('--kldId-router--$kldId--');
        return MaterialPageRoute(
          builder: (context) => BlocProvider<IncidentGeneralInfoCubit>(
            create: (_) => IncidentGeneralInfoCubit(
              services: IncidentManagementServices(),
              commonServices: CommonServices(),
              id: id,
              occId: occId,
              occType: occType,
              kldId: kldId,
              location: location,
            ),
            child: IncidentGeneralInfoView(
              viaOccurrence: !occId.isEmptyOrNull ? true : false,
              viaKeyIssuance: !kldId.isEmptyOrNull ? true : false,
              extraProperties: extraProperties,
              keyType: keyType,
              keyLostType: keyLostType,
              keyIssuanceId: keyIssuanceId,
              kmId: kmId,
            ),
          ),
        );

      case sstIncidentListRoute:
        bool isInternal = false;
        String occId = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          isInternal = arguments['isInternal'];
          occId = arguments['occId'] ?? '';
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<sv.SstIncidentBloc>(
            create: (_) => sv.SstIncidentBloc(
              ticketType: 1,
              staffType: isInternal ? 1 : 2,
              occId: occId,
            )..add(sv.FetchData(
                startPos: 0,
                maxPos: Constants.maxResults,
                newSearch: true,
                filters: BaseFilterModel())),
            child: SstIncidentView(
              isInternal: isInternal,
              occId: occId,
            ),
          ),
        );

      case sstIncidentDetailsRoute:
        String id = '';
        String occId = '';
        int occType = 0;
        bool isInternal = false;
        Organisation? location;
        ExtraProperties? extraProperties;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          occId = arguments['occId'] ?? '';
          id = arguments['id'] ?? '';
          occType = arguments['occType'] ?? 0;
          location = arguments[ConstantsArgument.location];
          extraProperties = arguments[ConstantsArgument.extraProperties];
          if (arguments.containsKey('isInternal')) {
            isInternal = arguments['isInternal'];
          }
        }

        return MaterialPageRoute(
          builder: (context) => BlocProvider<SstIncidentGeneralInfoCubit>(
            create: (_) => SstIncidentGeneralInfoCubit(
              services: SstIncidentServices(),
              commonServices: CommonServices(),
              occId: occId,
              occType: occType,
              id: id,
              isInternal: isInternal,
              location: location,
            ),
            child: SstIncidentGeneralInfoView(
              isInternal: isInternal,
              viaOccurrence: !occId.isEmptyOrNull ? true : false,
              extraProperties: extraProperties,
            ),
          ),
        );

      // case ticketingSystemDetailsRoute:
      // String id = '';
      // ExtraProperties? extraProperties;
      // if (settings.arguments != null) {
      //   Map<String, dynamic> arguments =
      //       settings.arguments as Map<String, dynamic>;
      //   id = arguments['id'] ?? '';
      //   extraProperties = arguments[ConstantsArgument.extraProperties];
      // }
      //
      // return MaterialPageRoute(
      //   builder: (context) => BlocProvider<TicketingSystemDetailsCubit>(
      //     create: (_) => TicketingSystemDetailsCubit(
      //       services: TicketingSystemServices(),
      //       commonServices: CommonServices(),
      //     ),
      //     child: const TicketingSystemDetailsView(),
      //   ),
      // );
      case shiftOccurrenceRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ocb.OccurrencesBloc>(
            create: (_) => ocb.OccurrencesBloc()
              ..add(ocb.FetchData(
                  startPos: 0,
                  maxPos: Constants.maxResults,
                  newSearch: true,
                  filters: BaseFilterModel())),
            child: const OccurrencesView(),
          ),
        );

      case shiftOccurrenceDetailsRoute:
        OccurrenceDetailsServices services = OccurrenceDetailsServices();
        CommonServices commonServices = CommonServices();
        String id = '';
        String title;
        ExtraProperties? extraProperties;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments["title"];
        id = arguments['id'] ?? '';
        extraProperties = arguments[ConstantsArgument.extraProperties];

        return MaterialPageRoute(
            builder: (context) => BlocProvider<OccurrenceGeneralInfoCubit>(
                  create: (_) => OccurrenceGeneralInfoCubit(
                    services: services,
                    id: id,
                    commonServices: commonServices,
                  ),
                  child: OccurrenceDetails(
                      title: title, extraProperties: extraProperties),
                ));

      // case occurrenceDetailsRoute:
      //   String id = '';
      //   String title;
      //   int eventStatus = 0;
      //   if (settings.arguments != null) {
      //     Map<String, dynamic> arguments =
      //     settings.arguments as Map<String, dynamic>;
      //     id = arguments['id'];
      //     eventStatus = arguments['eventStatus'];
      //   }
      //   return MaterialPageRoute(
      //       builder: (context) => const OccurrenceDetails(
      //         //title: title,
      //         //eventStatus: eventStatus,
      //       ));
      //

      case slaViolationPenaltyListRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<sla.SLAViolationPenaltyListBloc>(
            create: (_) => sla.SLAViolationPenaltyListBloc()
              ..add(sla.FetchData(
                  startPos: 0,
                  maxPos: Constants.maxResults,
                  newSearch: true,
                  filters: BaseFilterModel())),
            child: const SLAViolationPenaltyListView(),
          ),
        );

      case slaViolationPenaltyDetailsRoute:
        SLAViolationPenaltyServices services = SLAViolationPenaltyServices();
        CommonServices commonServices = CommonServices();
        String title;
        late int? attdInfoId;
        Organisation? location;
        Organisation? locationRegion;
        Organisation? vendor;
        bool viaAttendance = false;
        ExtraProperties? extraProperties;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        attdInfoId = arguments[ConstantsArgument.attdInfoId];
        SLAViolationPenaltyModel? model = arguments[ConstantsArgument.model];
        location = arguments[ConstantsArgument.location];
        locationRegion = arguments[ConstantsArgument.locationRegion];
        vendor = arguments[ConstantsArgument.vendor];
        extraProperties = arguments[ConstantsArgument.extraProperties];
        log('--attdInfoId--$attdInfoId-');
        viaAttendance = location != null ? true : false;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SLAViolationPenaltyDetailsCubit>(
            create: (_) => SLAViolationPenaltyDetailsCubit(
              services: services,
              model: model,
              commonServices: commonServices,
              attdInfoId: attdInfoId,
              location: location,
              locationRegion: locationRegion,
              vendor: vendor,
            ),
            child: SLAViolationPenaltyDetailsView(
              model: model,
              title: title,
              viaAttendance: viaAttendance,
              extraProperties: extraProperties,
            ),
          ),
        );

      // case slaViolationPenaltyListingRoute:
      //   String title = '';
      //   int id = 0;
      //   if (settings.arguments != null) {
      //     Map<String, dynamic> arguments =
      //     settings.arguments as Map<String, dynamic>;
      //     id = arguments[ConstantsArgument.id];
      //     title = arguments[ConstantsArgument.title];
      //   }
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider<vp.ViolationPenaltyRecordBloc>(
      //       create: (_) => vp.ViolationPenaltyRecordBloc()
      //         ..add(vp.FetchData(
      //           id: id,
      //           startPos: 0,
      //           maxPos: 100,
      //         )),
      //       child: ViolationPenaltyRecordView(
      //         id: id,
      //         title: title,
      //       ),
      //     ),
      //   );

      case slaViolationPenaltyRecordsRoute:
        String title = '';
        int id = 0;
        int parentStatus = 0;
        ExtraProperties? extraProperties;
        List<Organisation> violationDescriptions = [];
        String violationDescription = '';
        bool isLocked = false;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id];
          title = arguments[ConstantsArgument.title];
          violationDescription =
              arguments[ConstantsArgument.violationDescription] ?? '';
          violationDescriptions =
              arguments[ConstantsArgument.violationDescriptions] ?? '';
          extraProperties = arguments[ConstantsArgument.extraProperties];
          parentStatus = arguments[ConstantsArgument.parentStatus];
          isLocked = arguments[ConstantsArgument.isLocked];
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<vp.ViolationPenaltyRecordBloc>(
            create: (_) => vp.ViolationPenaltyRecordBloc(
              violationDescription: violationDescription,
              violationDescriptions: violationDescriptions,
            )..add(vp.FetchData(
                id: id,
                startPos: 0,
                maxPos: 100,
              )),
            child: ViolationPenaltyRecordsView(
              id: id,
              title: title,
              extraProperties: extraProperties,
              parentStatus: parentStatus,
              isLocked: isLocked,
            ),
          ),
        );

      case contactDetailsListRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<cd.ContactDetailsListBloc>(
            create: (_) => cd.ContactDetailsListBloc()
              ..add(cd.FetchData(
                  startPos: 0,
                  maxPos: Constants.maxResults,
                  newSearch: true,
                  filters: BaseFilterModel())),
            child: const ContactDetailsListView(),
          ),
        );

      case contactDetailsRoute:
        ContactDetailsServices services = ContactDetailsServices();
        CommonServices commonServices = CommonServices();
        String title;
        ExtraProperties? extraProperties;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        ContactDetailModel? model = arguments["model"];
        extraProperties = arguments[ConstantsArgument.extraProperties];

        return MaterialPageRoute(
          builder: (context) => BlocProvider<ContactDetailsCubit>(
            create: (_) => ContactDetailsCubit(
              services: services,
              model: model,
              commonServices: commonServices,
            ),
            child: ContactDetailsView(
              model: model,
              title: title,
              extraProperties: extraProperties,
            ),
          ),
        );

      case contactRecordsRoute:
        String title = '';
        int id = 0;
        int type = 0;
        String rankType = '';
        int parentStatus = 0;
        ExtraProperties? extraProperties;
        String? lock;
        List<Organisation> ranks = [];
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id];
          title = arguments[ConstantsArgument.title];
          type = arguments[ConstantsArgument.keyLostType] ?? 0;
          rankType = arguments[ConstantsArgument.rankType] ?? '';
          ranks = arguments[ConstantsArgument.ranks] ?? [];
          parentStatus = arguments[ConstantsArgument.parentStatus];
          lock = arguments[ConstantsArgument.isLocked];
          extraProperties = arguments[ConstantsArgument.extraProperties];
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<cr.ContactRecordBloc>(
            create: (_) =>
                cr.ContactRecordBloc(rankType: rankType, ranks: ranks)
                  ..add(cr.FetchData(
                    id: id,
                    type: type,
                    startPos: 0,
                    maxPos: 100,
                  )),
            child: ContactRecordView(
              id: id,
              type: type,
              title: title,
              rankType: rankType,
              parentStatus: parentStatus,
              lock: lock,
              extraProperties: extraProperties,
            ),
          ),
        );
      case eventProtectionListRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ep.EventProtectionsBloc>(
            create: (_) => ep.EventProtectionsBloc()
              ..add(ep.FetchData(
                  startPos: 0,
                  maxPos: Constants.maxResults,
                  newSearch: true,
                  filters: BaseFilterModel())),
            child: const EventProtectionsView(),
          ),
        );

      case eventProtectionDetailsTabRoute:
        String id = '';
        String title = '';
        int eventStatus = 0;
        bool? isEventProtection = false;
        ShowEPGridsModel showEPGridsModel = ShowEPGridsModel();
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments['id'];
          eventStatus = arguments['eventStatus'];
          showEPGridsModel = arguments[ConstantsArgument.showEPGridsModel];
          title = arguments[ConstantsArgument.title];
          isEventProtection = arguments[ConstantsArgument.isEventProtection];
        }
        return MaterialPageRoute(
          builder: (context) => EventProtectionDetails(
            id: id,
            title: title,
            eventStatus: eventStatus,
            showEPGridsModel: showEPGridsModel,
            isEventProtection: isEventProtection ?? false,
          ),
        );
      // case generalInfoTilesViewRoute:
      //   String id = '';
      //   bool showGuardInfo = true;
      //   if (settings.arguments != null) {
      //     Map<String, dynamic> arguments =
      //         settings.arguments as Map<String, dynamic>;
      //     id = arguments['id'];
      //     showGuardInfo = arguments['showGuardInfo'];
      //   }
      //   return MaterialPageRoute(
      //     builder: (context) => GeneralInfoTilesView(
      //       id: id,
      //       showGuardInfo: showGuardInfo,
      //     ),
      //   );

      case eventProtectionGeneralInfoGIRoute:
        String id = '';
        ExtraProperties? extraProperties;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments['id'];
          extraProperties = arguments[ConstantsArgument.extraProperties];
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<GeneralInfoCubit>(
            create: (_) => GeneralInfoCubit(
              services: EventProtectionServices(),
              commonServices: CommonServices(),
              id: id,
            ),
            child: GeneralInfoView(
              extraProperties: extraProperties,
            ),
          ),
        );

      case generalInfoCIRoute:
        String id = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments['id'];
        }
        return MaterialPageRoute(
            builder: (context) => BlocProvider<ContactInfoCubit>(
                  create: (_) => ContactInfoCubit(
                    services: EventProtectionServices(),
                    commonServices: CommonServices(),
                    id: id,
                  ),
                  child: const ContactInfoView(),
                ));

      case guardInfoRoute:
        String id = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments['id'];
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<GuardInfoCubit>(
            create: (_) => GuardInfoCubit(
              services: EventProtectionServices(),
              commonServices: CommonServices(),
              id: id,
            ),
            child: const GuardInfoView(),
          ),
        );

      case eventInfoRoute:
        String id = '';
        bool editForm = false;
        bool? isEventProtection = false;
        int eventDuration = 0;
        String title = '';

        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          title = arguments[ConstantsArgument.title] ?? '';
          id = arguments[ConstantsArgument.id];
          eventDuration = arguments['eventDuration'];
          editForm = arguments[ConstantsArgument.editForm];
          isEventProtection = arguments[ConstantsArgument.isEventProtection];
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<EventInfoCubit>(
            create: (_) => EventInfoCubit(
              services: EventProtectionServices(),
              commonServices: CommonServices(),
              eventProtectionId: id,
              eventDurationType: eventDuration,
            ),
            child: EventInfoView(
              title: title,
              editForm: editForm,
              eventProtectionId: id,
              isEventProtection: isEventProtection ?? false,
            ),
          ),
        );

      case materialMovementInwardsOutwardsRoute:
        bool isInward = true;
        bool? returnable = false;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          if (arguments.isNotEmpty) {
            isInward = arguments['isInward'];
            returnable = arguments['returnable'];
          }
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<mm.MaterialMovementBloc>(
            create: (_) => mm.MaterialMovementBloc(
              isInward: isInward,
              returnable: returnable,
            )..add(mm.FetchData(
                startPos: 0,
                maxPos: Constants.maxResults,
                newSearch: true,
                filters: BaseFilterModel())),
            child: MaterialMovementsView(
              isInward: isInward,
              returnable: returnable,
            ),
          ),
        );

      case materialMovementInwardOutwardDetailsRoute:
        MaterialMovementServices services = MaterialMovementServices();
        CommonServices commonServices = CommonServices();
        bool isInward = true;
        bool? returnable = false;
        String title;
        ExtraProperties? extraProperties;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        isInward = arguments['isInward'];
        MaterialMovementModel? materialMovement =
            arguments["MaterialMovementModel"];
        extraProperties = arguments[ConstantsArgument.extraProperties];
        returnable = arguments['returnable'];
        if (materialMovement != null) {
          return MaterialPageRoute(
              builder: (context) => BlocProvider<MaterialMovementDetailsCubit>(
                    create: (_) => MaterialMovementDetailsCubit(
                      materialMovementServices: services,
                      commonServices: commonServices,
                      model: materialMovement,
                      isInward: isInward,
                      returnable: returnable,
                    ),
                    child: MaterialMovementDetailsView(
                      model: materialMovement,
                      isInward: isInward,
                      title: title,
                      extraProperties: extraProperties,
                      returnable: returnable,
                    ),
                  ));
        }
        return MaterialPageRoute(
            builder: (context) => BlocProvider<MaterialMovementDetailsCubit>(
                  create: (_) => MaterialMovementDetailsCubit(
                    materialMovementServices: services,
                    commonServices: commonServices,
                    model: MaterialMovementModel(),
                    isInward: isInward,
                    returnable: returnable,
                  ),
                  child: MaterialMovementDetailsView(
                    isInward: isInward,
                    title: title,
                    extraProperties: extraProperties,
                    returnable: returnable,
                  ),
                ));

      case guardingRatesRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<guarding.GuardingRatesBloc>(
            create: (_) => guarding.GuardingRatesBloc()
              ..add(guarding.FetchData(
                  startPos: 0,
                  maxPos: Constants.maxResults,
                  newSearch: true,
                  filters: BaseFilterModel())),
            child: const GuardingRatesView(),
          ),
        );

      case guardingMasterReportRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<GuardingMasterReportBloc>(
                  create: (_) => GuardingMasterReportBloc()
                    ..add(FetchReportList(
                      startPos: 0,
                      maxPos: Constants.maxResults,
                      newSearch: true,
                      filters: BaseFilterModel(),
                    )),
                  child: const GuardingMasterReport(),
                ));

      case guardingMasterDataRoute:
        log('--guardingMasterDataRoute-');
        return MaterialPageRoute(
            builder: (context) => BlocProvider<GuardingMasterDataBloc>(
                  create: (_) => GuardingMasterDataBloc()
                    ..add(FetchDataList(
                        startPos: 0,
                        maxPos: Constants.maxResults,
                        newSearch: true,
                        filters: BaseFilterModel())),
                  child: const GuardingMasterDataView(),
                ));

      case guardingMasterDataDetailsRoute:
        GuardingMasterDataServices services = GuardingMasterDataServices();
        CommonServices commonServices = CommonServices();
        String title;
        ExtraProperties? extraProperties;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        GuardingMastersDataModel? model = arguments["GuardingMastersDataModel"];
        log('-guardingMastersDataModel-model--id---${model?.id}---');
        extraProperties = arguments[ConstantsArgument.extraProperties];
        return MaterialPageRoute(
          builder: (context) => BlocProvider<GuardingMasterDataDetailsCubit>(
            create: (_) => GuardingMasterDataDetailsCubit(
              services: services,
              model: model,
              commonServices: commonServices,
            ),
            child: GuardingMasterDataDetailsView(
              guardingMasterData: model,
              title: title,
              extraProperties: extraProperties,
            ),
          ),
        );

      case guardingRateDetailsRoute:
        GuardingServices services = GuardingServices();
        String title;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        GMRate rate = arguments['gmRate'];
        return MaterialPageRoute(
            builder: (context) => BlocProvider<PayRateCubit>(
                  create: (_) => PayRateCubit(
                    services: services,
                    rate: rate,
                    payRates: [],
                  ),
                  child: GuardingRateDetailsView(
                    rate: rate,
                    title: title,
                  ),
                ));

      case guardingRatesGRIRoute:
        GuardingServices services = GuardingServices();
        String title;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        GMRate? model = arguments["gmRate"];

        if (model != null) {
          return MaterialPageRoute(
              builder: (context) => BlocProvider<PayRateCubit>(
                    create: (_) => PayRateCubit(
                      services: services,
                      rate: model,
                      payRates: [],
                    ),
                    child: RatesInfo(
                      // materialMovement: materialMovement,
                      title: title,
                      rate: model,
                    ),
                  ));
        }
        return MaterialPageRoute(
            builder: (context) => BlocProvider<PayRateCubit>(
                  create: (_) => PayRateCubit(
                    services: services,
                    rate: model ?? GMRate(),
                    payRates: [],
                  ),
                  child: const RatesInfo(
                    title: 'Guarding Rates Information',
                  ),
                ));

      case payRateRoute:
        List<PayRate> payRates = [];
        GMRate rate = GMRate();
        String title = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          payRates = arguments['payRates'] ?? [];
          rate = arguments['gmRate'];
          title = arguments[ConstantsArgument.title];
        }
        return MaterialPageRoute(
            builder: (context) => BlocProvider<PayRateCubit>(
                  create: (_) => PayRateCubit(
                    payRates: payRates,
                    rate: rate,
                    services: GuardingServices(),
                  ),
                  child: PayRateView(
                    payRates: payRates,
                    rate: rate,
                    title: title,
                  ),
                ));

      case femaleDropPickUpRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<FemaleDropPickUpBloc>(
            create: (_) => FemaleDropPickUpBloc()
              ..add(const FetchList(startPos: 0, maxPos: 20)),
            child: const FemaleDropPickUpView(),
          ),
        );

      case annualPowerShutdownListRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<asp.AnnualPowerShutdownListBloc>(
            create: (_) => asp.AnnualPowerShutdownListBloc()
              ..add(asp.FetchData(
                  startPos: 0,
                  maxPos: Constants.maxResults,
                  newSearch: true,
                  filters: BaseFilterModel())),
            child: const AnnualPowerShutdownListView(),
          ),
        );

      case annualPowerShutdownListDetailsRoute:
        String id = '';
        ExtraProperties? extraProperties;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments['id'];
          extraProperties = arguments[ConstantsArgument.extraProperties];
        }
        return MaterialPageRoute(
          builder: (context) =>
              BlocProvider<AnnualPowerShutdownListDetailsCubit>(
            create: (_) => AnnualPowerShutdownListDetailsCubit(
              services: AnnualPowerShutdownListServices(),
              commonServices: CommonServices(),
              id: id,
            ),
            child: AnnualPowerShutdownListDetailsView(
              extraProperties: extraProperties,
            ),
          ),
        );

      case keyManagementMasterListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<KeyManagementMasterListBloc>(
                  create: (_) => KeyManagementMasterListBloc()
                    ..add(FetchKeyMasterList(
                        startPos: 0,
                        maxPos: Constants.maxResults,
                        newSearch: true,
                        filters: BaseFilterModel())),
                  child: const KeyManagementMasterListView(),
                ));

      case keyManagementMasterDetailsRoute:
        KeyManagementMasterServices services = KeyManagementMasterServices();
        CommonServices commonServices = CommonServices();
        String title;
        ExtraProperties? extraProperties;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        KeyManagementMasterModel? keyMgmtGi = arguments["keyMgmtGi"];
        extraProperties = arguments[ConstantsArgument.extraProperties];
        return MaterialPageRoute(
          builder: (context) => BlocProvider<KeyManagementMasterDetailsCubit>(
            create: (_) => KeyManagementMasterDetailsCubit(
              services: services,
              model: keyMgmtGi,
              commonServices: commonServices,
            ),
            child: KeyManagementMasterDetailsView(
              model: keyMgmtGi,
              title: title,
              extraProperties: extraProperties,
            ),
          ),
        );

      case keyHistoryRecordsViewRoute:
        // String title = '';
        int id = 0;
        int type = 0;
        String? lock;
        ExtraProperties? extraProperties;
        bool isEligibleToEdit = false;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id];
          // title = arguments[ConstantsArgument.title];
          type = arguments[ConstantsArgument.keyLostType];
          extraProperties = arguments[ConstantsArgument.extraProperties];
          lock = arguments[ConstantsArgument.isLocked];
          isEligibleToEdit = arguments[ConstantsArgument.isEligibleToEdit];
        }
        log('route----type--$type--');
        return MaterialPageRoute(
          builder: (context) => BlocProvider<kh.KeyHistoryRecordBloc>(
            create: (_) => kh.KeyHistoryRecordBloc()
              ..add(kh.FetchData(
                id: id,
                type: type,
                startPos: 0,
                maxPos: 100,
              )),
            child: KeyHistoryRecordsView(
                id: id,
                type: type,
                extraProperties: extraProperties,
                parentIsEligibleToEdit: isEligibleToEdit,
                lock: lock),
          ),
        );

      case keyHistoryRecordsDetailsRoute:
        KeyManagementMasterServices services = KeyManagementMasterServices();
        KeyManagementIssuanceServices keyIssuanceServices =
            KeyManagementIssuanceServices();
        CommonServices commonServices = CommonServices();
        // int? parentId;
        int? id;
        String title;
        late int keyLostType;
        late int? keyType;
        String? lock;
        int? kipId;
        int? keyIssuanceId;
        ExtraProperties? extraProperties;
        bool isEligibleToEdit = false;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        id = arguments[ConstantsArgument.id];
        kipId = arguments[ConstantsArgument.kipId];
        keyIssuanceId = arguments[ConstantsArgument.keyIssuanceId];
        keyLostType = arguments[ConstantsArgument.keyLostType];
        KeyHistoryModel? model = arguments[ConstantsArgument.model];
        extraProperties = arguments[ConstantsArgument.extraProperties];
        lock = arguments[ConstantsArgument.isLocked];
        keyType = arguments[ConstantsArgument.keyType];
        isEligibleToEdit = arguments[ConstantsArgument.isEligibleToEdit];
        log('--keyType--$keyType--');
        return MaterialPageRoute(
          builder: (context) => BlocProvider<KeyHistoryRecordsDetailsCubit>(
            create: (_) => KeyHistoryRecordsDetailsCubit(
              services: services,
              model: model,
              parentId: id!,
              kipId: kipId,
              keyIssuanceId: keyIssuanceId,
              commonServices: commonServices,
              lostType: keyLostType,
              keyType: keyType,
              keyIssuanceServices: keyIssuanceServices,
            ),
            child: KeyHistoryRecordsDetailsView(
              model: model,
              title: title,
              parentId: id!,
              keyLostType: keyLostType,
              extraProperties: extraProperties,
              parentIsEligibleToEdit: isEligibleToEdit,
              lock: lock,
              keyType: keyType,
            ),
          ),
        );
      case keyReconciliationListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<KeyReconciliationListBloc>(
                  create: (_) => KeyReconciliationListBloc()
                    ..add(FetchKeyReconciliationList(
                        startPos: 0,
                        maxPos: Constants.maxResults,
                        newSearch: true,
                        filters: BaseFilterModel())),
                  child: const KeyReconciliationListView(),
                ));

      case keyLossDestructionListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<KeyLossDestructionListBloc>(
                  create: (_) => KeyLossDestructionListBloc()
                    ..add(FetchKeyLossList(
                        startPos: 0,
                        maxPos: Constants.maxResults,
                        newSearch: true,
                        filters: BaseFilterModel())),
                  child: const KeyLossDestructionListView(),
                ));

      case keyLossDestructionListDetailsRoute:
        KeyLossDestructionListServices services =
            KeyLossDestructionListServices();
        CommonServices commonServices = CommonServices();
        String title;
        int type = 0;
        ExtraProperties? extraProperties;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        type = arguments[ConstantsArgument.keyLostType] ?? 0;
        KeyLossDestructionListModel? keyLossDestructionListModel =
            arguments["keyLossGi"];
        extraProperties = arguments[ConstantsArgument.extraProperties];

        return MaterialPageRoute(
          builder: (context) => BlocProvider<KeyLossDestructionDetailsCubit>(
            create: (_) => KeyLossDestructionDetailsCubit(
              services: services,
              model: keyLossDestructionListModel,
              commonServices: commonServices,
            ),
            child: KeyLossDestructionDetailsView(
              model: keyLossDestructionListModel,
              title: title,
              type: type,
              extraProperties: extraProperties,
            ),
          ),
        );

      case keyManagementIssuanceListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<KeyManagementIssuanceListBloc>(
                  create: (_) => KeyManagementIssuanceListBloc()
                    ..add(FetchKeyIssuanceList(
                        startPos: 0,
                        maxPos: Constants.maxResults,
                        newSearch: true,
                        filters: BaseFilterModel())),
                  child: const KeyManagementIssuanceListView(),
                ));

      case keyManagementIssuanceDetailsRoute:
        KeyManagementIssuanceServices services =
            KeyManagementIssuanceServices();
        CommonServices commonServices = CommonServices();
        String title;
        ExtraProperties? extraProperties;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        KeyManagementIssuanceModel? model = arguments["model"];
        extraProperties = arguments[ConstantsArgument.extraProperties];
        return MaterialPageRoute(
          builder: (context) => BlocProvider<KeyManagementIssuanceDetailsCubit>(
            create: (_) => KeyManagementIssuanceDetailsCubit(
              services: services,
              model: model,
              commonServices: commonServices,
            ),
            child: KeyManagementIssuanceDetailsView(
              model: model,
              title: title,
              extraProperties: extraProperties,
            ),
          ),
        );

      case keyManagementIssuanceProcessRecordsRoute:
        String title = '';
        int parentId = 0;
        late int? id;
        int parentStatus = 0;
        int locationId = 0;
        bool isMasterKey = false;
        String? lock;
        ExtraProperties? extraProperties;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          title = arguments[ConstantsArgument.title];
          id = arguments[ConstantsArgument.id];
          parentId = arguments[ConstantsArgument.parentId];
          parentStatus = arguments[ConstantsArgument.parentStatus];
          locationId = arguments[ConstantsArgument.locationId];
          isMasterKey = arguments[ConstantsArgument.isMasterKey];
          extraProperties = arguments[ConstantsArgument.extraProperties];
          lock = arguments[ConstantsArgument.isLocked];
        }

        log('ID --$id');
        log('parentId --$parentId');
        return MaterialPageRoute(
          builder: (context) => BlocProvider<kip.KeyIssuanceProcessRecordBloc>(
            create: (_) => kip.KeyIssuanceProcessRecordBloc(
              locationId: locationId,
              parentId: parentId,
              isMasterKey: isMasterKey ? true : false,
            )..add(kip.FetchData(
                id: parentId,
                startPos: 0,
                maxPos: 100,
              )),
            child: KeyIssuanceProcessRecordsView(
              id: id,
              parentId: parentId,
              parentStatus: parentStatus,
              locationId: locationId,
              title: title,
              isMasterKey: isMasterKey,
              extraProperties: extraProperties,
              lock: lock,
            ),
          ),
        );

      case dutyPostMasterListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<DutyPostMasterListBloc>(
                  create: (_) => DutyPostMasterListBloc()
                    ..add(FetchDutyPostMasterList(
                        startPos: 0,
                        maxPos: Constants.maxResults,
                        newSearch: true,
                        filters: BaseFilterModel())),
                  child: const DutyPostMasterListView(),
                ));

      case dutyPostMasterDetailsRoute:
        DutyPostMasterServices services = DutyPostMasterServices();
        CommonServices commonServices = CommonServices();
        String title;
        ExtraProperties? extraProperties;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        DutyPostMasterModel? dutyPostMasterModel =
            arguments["dutyPostMasterModel"];
        extraProperties = arguments[ConstantsArgument.extraProperties];
        return MaterialPageRoute(
          builder: (context) => BlocProvider<DutyPostMasterDetailsCubit>(
            create: (_) => DutyPostMasterDetailsCubit(
              services: services,
              model: dutyPostMasterModel,
              commonServices: commonServices,
            ),
            child: DutyPostMasterDetailsView(
              model: dutyPostMasterModel,
              title: title,
              extraProperties: extraProperties,
            ),
          ),
        );

      case dutyPostNameMasterListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<DutyPostNameMasterListBloc>(
                  create: (_) => DutyPostNameMasterListBloc()
                    ..add(FetchDutyPostNameMasterList(
                        startPos: 0,
                        maxPos: Constants.maxResults,
                        newSearch: true,
                        filters: BaseFilterModel())),
                  child: const DutyPostNameMasterListView(),
                ));

      case dutyPostNameMasterDetailsRoute:
        DutyPostNameMasterServices services = DutyPostNameMasterServices();
        CommonServices commonServices = CommonServices();
        String title;
        ExtraProperties? extraProperties;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        DutyPostNameMasterModel? dutyPostNameMasterModel =
            arguments["dutyPostNameMasterModel"];
        extraProperties = arguments[ConstantsArgument.extraProperties];
        return MaterialPageRoute(
          builder: (context) => BlocProvider<DutyPostNameMasterDetailsCubit>(
            create: (_) => DutyPostNameMasterDetailsCubit(
              services: services,
              model: dutyPostNameMasterModel,
              commonServices: commonServices,
            ),
            child: DutyPostNameMasterDetailsView(
              model: dutyPostNameMasterModel,
              title: title,
              extraProperties: extraProperties,
            ),
          ),
        );

      case attendanceListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<AttendanceBloc>(
                  create: (_) => AttendanceBloc()
                    ..add(FetchAttendanceList(
                        startPos: 0,
                        maxPos: Constants.maxResults,
                        newSearch: true,
                        filters: BaseFilterModel())),
                  child: const AttendanceView(),
                ));

      case attendanceDetailsRoute:
        String id = '';
        ExtraProperties? extraProperties;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id] ?? '';
          extraProperties = arguments[ConstantsArgument.extraProperties];
        }
        AttendanceServices services = AttendanceServices();
        CommonServices commonServices = CommonServices();
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AttendanceDetailsCubit>(
            create: (_) => AttendanceDetailsCubit(
              id: id,
              services: services,
              commonServices: commonServices,
            ),
            child: AttendanceDetailsView(
              extraProperties: extraProperties,
            ),
          ),
        );

      case attendanceShiftsRoute:
        int? attInfoId;
        int? selectedDutyPostNameId;
        Organisation? location;
        Organisation? locationRegion;
        Organisation? vendor;
        late DutyPostModel selectedDutyPostModel;
        late bool isReadOnly;
        late bool isEligibleToEdit;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          attInfoId = arguments[ConstantsArgument.parentId];
          selectedDutyPostNameId =
              arguments[ConstantsArgument.selectedDutyPostNameId];
          location = arguments[ConstantsArgument.location];
          locationRegion = arguments[ConstantsArgument.locationRegion];
          vendor = arguments[ConstantsArgument.vendor];
          selectedDutyPostModel =
              arguments[ConstantsArgument.selectedDutyPostModel];
          isReadOnly = arguments[ConstantsArgument.isReadOnly];
          isEligibleToEdit = arguments[ConstantsArgument.isEligibleToEdit];
        }
        AttendanceServices services = AttendanceServices();
        CommonServices commonServices = CommonServices();
        SLAViolationPenaltyServices slaServices = SLAViolationPenaltyServices();

        return MaterialPageRoute(
          builder: (context) => BlocProvider<AttendanceShiftsCubit>(
            create: (_) => AttendanceShiftsCubit(
              attInfoId: attInfoId!,
              selectedDutyPostNameId: selectedDutyPostNameId!,
              services: services,
              commonServices: commonServices,
              slaServices: slaServices,
            ),
            child: AttendanceShiftsView(
                attInfoId: attInfoId!,
                location: location!,
                locationRegion: locationRegion!,
                vendor: vendor!,
                selectedDutyPostModel: selectedDutyPostModel,
                isReadOnly: isReadOnly,
                isEligibleToEdit: isEligibleToEdit),
          ),
        );

      case attendanceReportBillingListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<arb.AttendanceReportBillingBloc>(
                  create: (_) => arb.AttendanceReportBillingBloc()
                    ..add(arb.FetchAttendanceReportBillingList(
                        startPos: 0,
                        maxPos: Constants.maxResults,
                        newSearch: true,
                        filters: BaseFilterModel())),
                  child: const AttendanceReportBillingView(),
                ));

      case shiftScheduleListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<ShiftScheduleListBloc>(
                  create: (_) => ShiftScheduleListBloc()
                    ..add(FetchShiftScheduleList(
                        startPos: 0,
                        maxPos: Constants.maxResults,
                        newSearch: true,
                        filters: BaseFilterModel())),
                  child: const ShiftScheduleListView(),
                ));

      case shiftScheduleDetailsRoute:
        String id = '';
        ExtraProperties? extraProperties;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id] ?? '';
          extraProperties = arguments[ConstantsArgument.extraProperties];
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ShiftScheduleDetailsCubit>(
            create: (_) => ShiftScheduleDetailsCubit(
              id: id,
            ),
            child: ShiftScheduleDetailsView(extraProperties: extraProperties),
          ),
        );

      case vipVisitorsListRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<vip.VVIPVisitorsBloc>(
            create: (_) => vip.VVIPVisitorsBloc()
              ..add(vip.FetchData(
                  startPos: 0,
                  maxPos: Constants.maxResults,
                  newSearch: true,
                  filters: BaseFilterModel())),
            child: const VVIPVisitorsView(),
          ),
        );

      case vipVisitorsDetailsRoute:
        VVIPVisitorServices services = VVIPVisitorServices();
        CommonServices commonServices = CommonServices();
        String title;
        ExtraProperties? extraProperties;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        VIVPVisitorModel? model = arguments["model"];
        extraProperties = arguments[ConstantsArgument.extraProperties];

        return MaterialPageRoute(
          builder: (context) => BlocProvider<VVIPVisitorDetailsCubit>(
            create: (_) => VVIPVisitorDetailsCubit(
              services: services,
              model: model,
              commonServices: commonServices,
            ),
            child: VVIPVisitorDetailsView(
                model: model, title: title, extraProperties: extraProperties),
          ),
        );

      case vipVisitorsRecordsRoute:
        String title = '';
        int id = 0;
        ExtraProperties? extraProperties;
        String? lock;
        int parentStatus = 0;
        // String violationDescription = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id];
          title = arguments[ConstantsArgument.title];
          extraProperties = arguments[ConstantsArgument.extraProperties];
          lock = arguments[ConstantsArgument.isLocked];
          parentStatus = arguments[ConstantsArgument.parentStatus];
          // violationDescription =
          //     arguments[ConstantsArgument.violationDescription] ?? '';
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<vipr.VVIPVisitorsRecordBloc>(
            create: (_) => vipr.VVIPVisitorsRecordBloc(
                //violationDescription: violationDescription,
                )
              ..add(vipr.FetchData(
                id: id,
                startPos: 0,
                maxPos: 100,
              )),
            child: VVIPVisitorsRecordView(
              id: id,
              title: title,
              extraProperties: extraProperties,
              lock: lock,
              parentStatus: parentStatus,
            ),
          ),
        );

      // case ticketingSystemDetailsRoute:
      //   // ExtraProperties? extraProperties;
      //   if (settings.arguments != null) {
      //     Map<String, dynamic> arguments =
      //         settings.arguments as Map<String, dynamic>;
      //     // extraProperties = arguments[ConstantsArgument.extraProperties];
      //   }
      //
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider<TicketingSystemDetailsCubit>(
      //       create: (_) => TicketingSystemDetailsCubit(
      //         services: TicketingSystemServices(),
      //         commonServices: CommonServices(),
      //       ),
      //       child: const TicketingSystemDetailsView(),
      //     ),
      //   );

      case ticketingSystemListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<TicketingSystemBloc>(
                  create: (_) => TicketingSystemBloc()
                    ..add(FetchTicketingSystemData(
                        startPos: 0,
                        maxPos: Constants.maxResults,
                        newSearch: true,
                        filters: BaseFilterModel())),
                  child: const TicketingSystemView(),
                ));

      case ticketingSystemDetailsRoute:
        TicketingSystemServices services = TicketingSystemServices();
        CommonServices commonServices = CommonServices();
        String title;
        ExtraProperties? extraProperties;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        TicketingSystemModel? ticketingSystemModel = arguments["redmineIssue"];
        extraProperties = arguments[ConstantsArgument.extraProperties];
        return MaterialPageRoute(
          builder: (context) => BlocProvider<TicketingSystemDetailsCubit>(
            create: (_) => TicketingSystemDetailsCubit(
              services: services,
              model: ticketingSystemModel,
              commonServices: commonServices,
            ),
            child: TicketingSystemDetailsView(
              model: ticketingSystemModel,
              title: title,
              // extraProperties: extraProperties,
            ),
          ),
        );

      case dayPassManagementListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<DayPassManagementListBloc>(
              create: (_) => DayPassManagementListBloc(passId: 0)
                ..add(FetchDayPassData(
                    startPos: 0,
                    maxPos: Constants.maxResults,
                    newSearch: true,
                    filters: BaseFilterModel())),
              child: const DayPassManagementListView(),
            ));

      default:
        log('--default---${settings.name}-');
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      // CommonServices commonServices = CommonServices();
      // return MaterialPageRoute(
      //   builder: (context) => BlocProvider<ChartsCubit>(
      //     create: (_) => ChartsCubit(commonServices: commonServices),
      //     child: const DashboardView(),
      //   ),
      // );
    }
  }
}
