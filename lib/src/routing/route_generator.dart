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
import 'package:db_atom/src/features/dashboard/notifications/notification_list/bloc/notifications_bloc.dart'
    as nb;
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
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/attendance_details/views/attendance_details_view.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/attendance_shifts/cubits/attendance_shifts_cubit.dart';
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
import 'package:db_atom/src/features/passmanagement/pass_management_list/bloc/pass_management_list_bloc.dart'
    as pm;
import 'package:db_atom/src/features/passmanagement/pass_management_list/views/pass_manangement_list_view.dart';
import 'package:db_atom/src/features/security_systems/services/sst_incident_services.dart';
import 'package:db_atom/src/features/security_systems/sst_incident_list/bloc/sst_incident_bloc.dart'
    as sv;
import 'package:db_atom/src/services/common_services.dart';

import '../features/guarding_operations/key_management_data/key_loss_destruction_list/key_loss_destruction_list/bloc/key_loss_destruction_list_bloc.dart';
import '../features/guarding_operations/key_management_data/key_loss_destruction_list/key_loss_destruction_list/views/key_loss_destruction_list_view.dart';
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
        return MaterialPageRoute(
          builder: (context) => BlocProvider<nb.NotificationsBloc>(
            create: (_) => NotificationsBloc()
              ..add(const nb.FetchData(startPos: 0, maxPos: 20)),
            child: const NotificationsView(),
          ),
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
          final listroutes = settings.arguments as Map<String, dynamic>;
          FoundListArticleDetails? listuser = listroutes["UserElement"];
          int eventId = listroutes['eventId'];
          return MaterialPageRoute(
            builder: (context) => CreateFound(
              model: listuser,
              eventId: eventId,
            ),
          );
        } else {
          return MaterialPageRoute(builder: (context) => const CreateFound());
        }
      case addemployeedepartmentRoute:
        return MaterialPageRoute(
          builder: (context) => const AddEmployeeDepartment(
            title: Constants.addemployeedepartment,
          ),
        );

      // case articleFoundListRoute:
      //   return MaterialPageRoute(builder: (context) => const ArticleFoundListView());
      case articleFoundListRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<af.ArticleFoundBloc>(
            create: (_) => af.ArticleFoundBloc()
              ..add(
                af.FetchData(
                  startPos: 0,
                  maxPos: 20,
                  newSearch: true,
                  filters: BaseFilterModel(),
                ),
              ),
            child: const ArticleFoundListView(),
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
          return MaterialPageRoute(
              builder: (context) => LawEnforcementDetailsView(model: listuser));
        } else {
          return MaterialPageRoute(
              builder: (context) => const LawEnforcementDetailsView());
        }

      case visitingOfficialListRoute:
        String title = '';
        int id = 0;
        int type = 0;
        List<LawVisitingOfficial> visitingOfficials = [];
        List<Organisation> departments = [];
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id];
          title = arguments[ConstantsArgument.title];
          type = arguments[ConstantsArgument.type] ?? 0;
          visitingOfficials = arguments[ConstantsArgument.models] ?? [];
          departments = arguments[ConstantsArgument.departments] ?? [];
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<vo.VisitingOfficialListBloc>(
            create: (_) => vo.VisitingOfficialListBloc(
                parentId: id, departments: departments)
              ..add(vo.FetchData(
                id: id,
                type: type,
                startPos: 0,
                maxPos: 100,
              )),
            child: VisitingOfficialListView(
              id: id,
              type: type,
              title: title,
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
                      maxPos: 20,
                      newSearch: true,
                      filters: BaseFilterModel())),
            child: PassManagementListView(
              passId: passMngArguments!.passType,
              title: passMngArguments.title ?? '',
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

        if (settings.arguments != null) {
          final passRoutes = settings.arguments as Map<String, dynamic>;
          CreatePassMngArguments? passMngArguments =
              passRoutes["passMngCreateDetails"];
          passId = passMngArguments!.passType;
          return MaterialPageRoute(
            builder: (context) => CreatePassManagement(
              passId: passMngArguments.passType,
              title: passMngArguments.title ?? '',
              model: passMngArguments.model,
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

        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          occId = arguments['occId'] ?? '';
          occType = arguments['occType'] ?? 0;
        }
        log('--occId-router-im list-$occId--');
        return MaterialPageRoute(
          builder: (context) => BlocProvider<im.IncidentManagementsBloc>(
            create: (_) => im.IncidentManagementsBloc(occType, occId)
              ..add(const im.FetchData(startPos: 0, maxPos: 20)),
            child: IncidentManagementsView(
              occId: occId,
              occType: occType,
            ),
          ),
        );

      case incidentManagementDetailsRoute:
        String id = '';
        String occId = '';
        int occType = 0;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments['id'] ?? '';
          occId = arguments['occId'] ?? '';
          occType = arguments['occType'] ?? 0;
        }
        log('--occId-router--$occId--');
        return MaterialPageRoute(
          builder: (context) => BlocProvider<IncidentGeneralInfoCubit>(
            create: (_) => IncidentGeneralInfoCubit(
              services: IncidentManagementServices(),
              commonServices: CommonServices(),
              id: id,
              occId: occId,
              occType: occType,
            ),
            child: IncidentGeneralInfoView(
              viaOccurrence: !occId.isEmptyOrNull ? true : false,
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
            )..add(const sv.FetchData(startPos: 0, maxPos: 20)),
            child: SstIncidentView(isInternal: isInternal),
          ),
        );

      case sstIncidentDetailsRoute:
        String id = '';
        String occId = '';
        int occType = 0;
        bool isInternal = false;

        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          occId = arguments['occId'] ?? '';
          id = arguments['id'] ?? '';
          occType = arguments['occType'] ?? 0;

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
            ),
            child: SstIncidentGeneralInfoView(
              isInternal: isInternal,
              viaOccurrence: !occId.isEmptyOrNull ? true : false,
            ),
          ),
        );
      case occurrenceRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ocb.OccurrencesBloc>(
            create: (_) => ocb.OccurrencesBloc()
              ..add(const ocb.FetchData(startPos: 0, maxPos: 20)),
            child: const OccurrencesView(),
          ),
        );

      case occurrenceDetailsRoute:
        OccurrenceDetailsServices services = OccurrenceDetailsServices();
        CommonServices commonServices = CommonServices();
        String id = '';
        String title;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments["title"];
        id = arguments['id'] ?? '';
        return MaterialPageRoute(
            builder: (context) => BlocProvider<OccurrenceGeneralInfoCubit>(
                  create: (_) => OccurrenceGeneralInfoCubit(
                    services: services,
                    id: id,
                    commonServices: commonServices,
                  ),
                  child: OccurrenceDetails(
                    title: title,
                  ),
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
                  maxPos: 20,
                  newSearch: true,
                  filters: BaseFilterModel())),
            child: const SLAViolationPenaltyListView(),
          ),
        );

      case slaViolationPenaltyDetailsRoute:
        SLAViolationPenaltyServices services = SLAViolationPenaltyServices();
        CommonServices commonServices = CommonServices();
        String title;
        String? attdInfoId = '';
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        attdInfoId = arguments['attdInfoId'] ?? '';
        SLAViolationPenaltyModel? model = arguments["model"];
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SLAViolationPenaltyDetailsCubit>(
            create: (_) => SLAViolationPenaltyDetailsCubit(
              services: services,
              model: model,
              commonServices: commonServices,
              attdInfoId: attdInfoId,
            ),
            child: SLAViolationPenaltyDetailsView(
              model: model,
              title: title,
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
        List<Organisation> violationDescriptions = [];
        String violationDescription = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id];
          title = arguments[ConstantsArgument.title];
          violationDescription =
              arguments[ConstantsArgument.violationDescription] ?? '';
          violationDescriptions =
              arguments[ConstantsArgument.violationDescriptions] ?? '';
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
            ),
          ),
        );

      case contactDetailsListRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<cd.ContactDetailsListBloc>(
            create: (_) => cd.ContactDetailsListBloc()
              ..add(cd.FetchData(
                  startPos: 0,
                  maxPos: 20,
                  newSearch: true,
                  filters: BaseFilterModel())),
            child: const ContactDetailsListView(),
          ),
        );

      case contactDetailsRoute:
        ContactDetailsServices services = ContactDetailsServices();
        CommonServices commonServices = CommonServices();
        String title;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        ContactDetailModel? model = arguments["model"];
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
            ),
          ),
        );

      case contactRecordsRoute:
        String title = '';
        int id = 0;
        int type = 0;
        String rankType = '';
        List<Organisation> ranks = [];
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id];
          title = arguments[ConstantsArgument.title];
          type = arguments[ConstantsArgument.type] ?? 0;
          rankType = arguments[ConstantsArgument.rankType] ?? '';
          ranks = arguments[ConstantsArgument.ranks] ?? [];
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
            ),
          ),
        );
      case eventProtectionListRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ep.EventProtectionsBloc>(
            create: (_) => ep.EventProtectionsBloc()
              ..add(ep.FetchData(
                  startPos: 0,
                  maxPos: 20,
                  newSearch: true,
                  filters: BaseFilterModel())),
            child: const EventProtectionsView(),
          ),
        );

      case eventProtectionDetailsTabRoute:
        String id = '';
        int eventStatus = 0;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments['id'];
          eventStatus = arguments['eventStatus'];
        }
        return MaterialPageRoute(
            builder: (context) => EventProtectionDetails(
                  id: id,
                  eventStatus: eventStatus,
                ));
      case generalInfoTilesViewRoute:
        String id = '';
        bool showGuardInfo = true;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments['id'];
          showGuardInfo = arguments['showGuardInfo'];
        }
        return MaterialPageRoute(
          builder: (context) => GeneralInfoTilesView(
            id: id,
            showGuardInfo: showGuardInfo,
          ),
        );

      case generalInfoGIRoute:
        String id = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments['id'];
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<GeneralInfoCubit>(
            create: (_) => GeneralInfoCubit(
              services: EventProtectionServices(),
              commonServices: CommonServices(),
              id: id,
            ),
            child: const GeneralInfoView(),
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

        int eventDuration = 0;
        String title = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          title = arguments[ConstantsArgument.title] ?? '';
          id = arguments['id'];
          eventDuration = arguments['eventDuration'];
        }
        return MaterialPageRoute(
            builder: (context) => BlocProvider<EventInfoCubit>(
                  create: (_) => EventInfoCubit(
                    services: EventProtectionServices(),
                    commonServices: CommonServices(),
                    id: id,
                    eventDuration: eventDuration,
                  ),
                  child: EventInfoView(
                    title: title,
                  ),
                ));

      case materialMovementInwardsOutwardsRoute:
        bool isInward = true;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          if (arguments.isNotEmpty) {
            isInward = arguments['isInward'];
          }
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<mm.MaterialMovementBloc>(
            create: (_) => mm.MaterialMovementBloc(isInward: isInward)
              ..add(mm.FetchData(
                  startPos: 0,
                  maxPos: 20,
                  newSearch: true,
                  filters: BaseFilterModel())),
            child: MaterialMovementsView(
              isInward: isInward,
            ),
          ),
        );

      case materialMovementInwardOutwardDetailsRoute:
        MaterialMovementServices services = MaterialMovementServices();
        CommonServices commonServices = CommonServices();
        bool isInward = true;
        String title;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        isInward = arguments['isInward'];
        MaterialMovementModel? materialMovement =
            arguments["MaterialMovementModel"];

        if (materialMovement != null) {
          return MaterialPageRoute(
              builder: (context) => BlocProvider<MaterialMovementDetailsCubit>(
                    create: (_) => MaterialMovementDetailsCubit(
                      materialMovementServices: services,
                      commonServices: commonServices,
                      model: materialMovement,
                      isInward: isInward,
                    ),
                    child: MaterialMovementDetailsView(
                      model: materialMovement,
                      isInward: isInward,
                      title: title,
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
                  ),
                  child: MaterialMovementDetailsView(
                    isInward: isInward,
                    title: title,
                  ),
                ));

      case guardingRatesRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<guarding.GuardingRatesBloc>(
            create: (_) => guarding.GuardingRatesBloc()
              ..add(guarding.FetchList(
                  startPos: 0,
                  maxPos: 20,
                  newSearch: true,
                  filters: BaseFilterModel())),
            child: const GuardingRates(),
          ),
        );

      case guardingMasterReportRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<GuardingMasterReportBloc>(
                  create: (_) => GuardingMasterReportBloc()
                    ..add(FetchReportList(
                      startPos: 0,
                      maxPos: 20,
                      newSearch: true,
                      filters: BaseFilterModel(),
                    )),
                  child: const GuardingMasterReport(),
                ));

      case guardingMasterDataRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<GuardingMasterDataBloc>(
                  create: (_) => GuardingMasterDataBloc()
                    ..add(FetchDataList(
                        startPos: 0,
                        maxPos: 20,
                        newSearch: true,
                        filters: BaseFilterModel())),
                  child: const GuardingMasterDataView(),
                ));

      case guardingMasterDataDetailsRoute:
        GuardingMasterDataServices services = GuardingMasterDataServices();
        CommonServices commonServices = CommonServices();
        String title;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        GuardingMastersDataModel? model = arguments["GuardingMastersDataModel"];
        log('-guardingMastersDataModel-model--id---${model?.id}---');

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
                  maxPos: 20,
                  newSearch: true,
                  filters: BaseFilterModel())),
            child: const AnnualPowerShutdownListView(),
          ),
        );

      case annualPowerShutdownListDetailsRoute:
        String id = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments['id'];
        }
        return MaterialPageRoute(
          builder: (context) =>
              BlocProvider<AnnualPowerShutdownListDetailsCubit>(
            create: (_) => AnnualPowerShutdownListDetailsCubit(
              services: AnnualPowerShutdownListServices(),
              commonServices: CommonServices(),
              id: id,
            ),
            child: const AnnualPowerShutdownListDetailsView(),
          ),
        );

      case keyManagementMasterListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<KeyManagementMasterListBloc>(
                  create: (_) => KeyManagementMasterListBloc()
                    ..add(const FetchKeyMasterList(startPos: 0, maxPos: 20)),
                  child: const KeyManagementMasterListView(),
                ));

      case keyManagementMasterDetailsRoute:
        KeyManagementMasterServices services = KeyManagementMasterServices();
        CommonServices commonServices = CommonServices();
        String title;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        KeyManagementMasterModel? keyMgmtGi = arguments["keyMgmtGi"];
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
            ),
          ),
        );

      case keyHistoryRecordsViewRoute:
        // String title = '';
        int id = 0;
        int type = 0;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id];
          // title = arguments[ConstantsArgument.title];
          type = arguments[ConstantsArgument.type];
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
            ),
          ),
        );

      case keyHistoryRecordsDetailsRoute:
        KeyManagementMasterServices services = KeyManagementMasterServices();
        CommonServices commonServices = CommonServices();
        int parentId = 0;
        String title;
        int type = 0;

        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        parentId = arguments[ConstantsArgument.id];
        type = arguments[ConstantsArgument.type];
        KeyManagementMasterModel? keyMgmtGi = arguments["keyMgmtGi"];
        return MaterialPageRoute(
          builder: (context) => BlocProvider<KeyHistoryRecordsDetailsCubit>(
            create: (_) => KeyHistoryRecordsDetailsCubit(
              services: services,
              model: keyMgmtGi,
              parentId: parentId,
              commonServices: commonServices,
              type: type,
            ),
            child: KeyHistoryRecordsDetailsView(
              model: keyMgmtGi,
              title: title,
              parentId: parentId,
              type: type,
            ),
          ),
        );
      case keyReconciliationListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<KeyReconciliationListBloc>(
                  create: (_) => KeyReconciliationListBloc()
                    ..add(const FetchKeyReconciliationList(
                        startPos: 0, maxPos: 20)),
                  child: const KeyReconciliationListView(),
                ));

      case keyLossDestructionListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<KeyLossDestructionListBloc>(
                  create: (_) => KeyLossDestructionListBloc()
                    ..add(const FetchKeyLossList(startPos: 0, maxPos: 20)),
                  child: const KeyLossDestructionListView(),
                ));

      case keyManagementIssuanceListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<KeyManagementIssuanceListBloc>(
                  create: (_) => KeyManagementIssuanceListBloc()
                    ..add(const FetchKeyIssuanceList(startPos: 0, maxPos: 20)),
                  child: const KeyManagementIssuanceListView(),
                ));

      case keyManagementIssuanceDetailsRoute:
        KeyManagementIssuanceServices services =
            KeyManagementIssuanceServices();
        CommonServices commonServices = CommonServices();
        String title;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        KeyManagementIssuanceModel? model = arguments["model"];
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
            ),
          ),
        );

      case keyManagementIssuanceProcessRecordsRoute:
        String title = '';
        int parentId = 0;
        int parentStatus = 0;
        int locationId = 0;
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          title = arguments[ConstantsArgument.title];
          parentId = arguments[ConstantsArgument.parentId];
          parentStatus = arguments[ConstantsArgument.parentStatus];
          locationId = arguments[ConstantsArgument.locationId];
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<kip.KeyIssuanceProcessRecordBloc>(
            create: (_) => kip.KeyIssuanceProcessRecordBloc(
              locationId: locationId,
              parentId: parentId,
            )..add(kip.FetchData(
                id: parentId,
                startPos: 0,
                maxPos: 100,
              )),
            child: KeyIssuanceProcessRecordsView(
              parentId: parentId,
              parentStatus: parentStatus,
              locationId: locationId,
              title: title,
            ),
          ),
        );

      case dutyPostMasterListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<DutyPostMasterListBloc>(
                  create: (_) => DutyPostMasterListBloc()
                    ..add(
                        const FetchDutyPostMasterList(startPos: 0, maxPos: 20)),
                  child: const DutyPostMasterListView(),
                ));

      case dutyPostMasterDetailsRoute:
        DutyPostMasterServices services = DutyPostMasterServices();
        CommonServices commonServices = CommonServices();
        String title;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        DutyPostMasterModel? dutyPostMasterModel =
            arguments["dutyPostMasterModel"];
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
            ),
          ),
        );

      case dutyPostNameMasterListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<DutyPostNameMasterListBloc>(
                  create: (_) => DutyPostNameMasterListBloc()
                    ..add(const FetchDutyPostNameMasterList(
                        startPos: 0, maxPos: 20)),
                  child: const DutyPostNameMasterListView(),
                ));

      case dutyPostNameMasterDetailsRoute:
        DutyPostNameMasterServices services = DutyPostNameMasterServices();
        CommonServices commonServices = CommonServices();
        String title;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        DutyPostNameMasterModel? dutyPostNameMasterModel =
            arguments["dutyPostNameMasterModel"];
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
            ),
          ),
        );

      case attendanceListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<AttendanceBloc>(
                  create: (_) => AttendanceBloc()
                    ..add(const FetchAttendanceList(startPos: 0, maxPos: 20)),
                  child: const AttendanceView(),
                ));

      case attendanceDetailsRoute:
        String id = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id] ?? '';
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
            child: const AttendanceDetailsView(),
          ),
        );

      case attendanceShiftsRoute:
        String id = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id] ?? '';
        }
        AttendanceServices services = AttendanceServices();
        CommonServices commonServices = CommonServices();
        SLAViolationPenaltyServices slaServices = SLAViolationPenaltyServices();

        return MaterialPageRoute(
          builder: (context) => BlocProvider<AttendanceShiftsCubit>(
            create: (_) => AttendanceShiftsCubit(
              id: id,
              services: services,
              commonServices: commonServices,
              slaServices: slaServices,
            ),
            child: const AttendanceShiftsView(),
          ),
        );

      case attendanceReportBillingListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<arb.AttendanceReportBillingBloc>(
                  create: (_) => arb.AttendanceReportBillingBloc()
                    ..add(
                        const arb.FetchAttendanceList(startPos: 0, maxPos: 20)),
                  child: const AttendanceReportBillingView(),
                ));

      case shiftScheduleListRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<ShiftScheduleListBloc>(
                  create: (_) => ShiftScheduleListBloc()
                    ..add(
                        const FetchShiftScheduleList(startPos: 0, maxPos: 20)),
                  child: const ShiftScheduleListView(),
                ));

      case shiftScheduleDetailsRoute:
        String id = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id] ?? '';
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ShiftScheduleDetailsCubit>(
            create: (_) => ShiftScheduleDetailsCubit(
              id: id,
            ),
            child: const ShiftScheduleDetailsView(),
          ),
        );

      case vipVisitorsListRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<vip.VVIPVisitorsBloc>(
            create: (_) => vip.VVIPVisitorsBloc()
              ..add(const vip.FetchData(startPos: 0, maxPos: 20)),
            child: const VVIPVisitorsView(),
          ),
        );

      case vipVisitorsDetailsRoute:
        VVIPVisitorServices services = VVIPVisitorServices();
        CommonServices commonServices = CommonServices();
        String title;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        VIVPVisitorModel? model = arguments["model"];
        return MaterialPageRoute(
          builder: (context) => BlocProvider<VVIPVisitorDetailsCubit>(
            create: (_) => VVIPVisitorDetailsCubit(
              services: services,
              model: model,
              commonServices: commonServices,
            ),
            child: VVIPVisitorDetailsView(
              model: model,
              title: title,
            ),
          ),
        );

      case vipVisitorsRecordsRoute:
        String title = '';
        int id = 0;
        // String violationDescription = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id];
          title = arguments[ConstantsArgument.title];
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
            ),
          ),
        );

      default:
        CommonServices commonServices = CommonServices();
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ChartsCubit>(
            create: (_) => ChartsCubit(commonServices: commonServices),
            child: const DashboardView(),
          ),
        );
    }
  }
}
