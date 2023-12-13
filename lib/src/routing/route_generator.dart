import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/contact_details/contact_details_list/bloc/contact_details_list_bloc.dart'
    as cd;
import 'package:db_atom/src/features/contact_details/contact_records/bloc/contact_record_bloc.dart'
    as cr;
import 'package:db_atom/src/features/contact_details/services/contact_details_services.dart';
import 'package:db_atom/src/features/dashboard/notifications/bloc/notifications_bloc.dart' as nb;
import 'package:db_atom/src/features/event_protection/event_protections/bloc/event_protections_bloc.dart'
    as ep;
import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/services/guarding_master_data_services.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/guarding_rates/bloc/guarding_rates_bloc.dart'
    as guarding;
import 'package:db_atom/src/features/guarding_operations/guarding_rate/services/guarding_services.dart';
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/sla_violation_penalty_list/bloc/sla_violation_penalty_list_bloc.dart'
    as sla;
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/violation_penalty_record/bloc/violation_penalty_record_bloc.dart'
    as vp;
import 'package:db_atom/src/features/incident_management/incident_managements/bloc/incident_management_bloc.dart'
    as im;
import 'package:db_atom/src/features/incident_management/services/incident_management_services.dart';
import 'package:db_atom/src/features/login/services/login_services.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/services/occurrences_services.dart';
import 'package:db_atom/src/features/occurrenceList/bloc/occurrences_bloc.dart'
    as ocb;
import 'package:db_atom/src/features/security_systems/services/sst_incident_services.dart';
import 'package:db_atom/src/features/security_systems/sst_incident_list/bloc/sst_incident_bloc.dart'
    as sv;
import 'package:db_atom/src/services/CommonServices.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    // ignore: non_constant_identifier_names
    switch (settings.name) {
      // case appRoute:
      //   return MaterialPageRoute(builder: (context) => const App());
      case dashboardViewRoute:
        return MaterialPageRoute(builder: (context) => const DashboardView());

      case notificationViewRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<nb.NotificationsBloc>(
            create: (_) => nb.NotificationsBloc()
              ..add(const nb.FetchData(startPos: 0, maxPos: 20)),
            child: const NotificationsView(),
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
            ),
          );
        }
        return MaterialPageRoute(builder: (context) => const OtpVerifyScreen());

      case createfoundScreenRoute:
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
      case lawenforcementScreenRoute:
        // return MaterialPageRoute(builder: (context) => CreateLawenforcement());
        if (settings.arguments != null) {
          final listroutes = settings.arguments as Map<String, dynamic>;
          LawEnforcementDetails? listuser = listroutes["UserElement"];
          return MaterialPageRoute(
              builder: (context) => LawEnforcementDetailsView(model: listuser));
        } else {
          return MaterialPageRoute(
              builder: (context) => const LawEnforcementDetailsView());
        }
      case addemployeedepartmentRoute:
        return MaterialPageRoute(
          builder: (context) => const AddEmployeeDepartment(
            title: Constants.addemployeedepartment,
          ),
        );

      case articleFoundListRoute:
        return MaterialPageRoute(builder: (context) => const FoundList());
      case createFoundAttachmentRoute:
        return MaterialPageRoute(
            builder: (context) => const CreateFoundAttachment());
      case piechartRoute:
        return MaterialPageRoute(builder: (context) => PieChartApp());
      case customexpansionlisttextsRoute:
        return MaterialPageRoute(
            builder: (context) => const CustomExpansionListTexts());
      case lawEnforcementListRoute:
        return MaterialPageRoute(
            builder: (context) => const LawEnforcementsView());
      case daypassmanagementListRoute:
        if (settings.arguments != null) {
          final passRoutes = settings.arguments as Map<String, dynamic>;
          PassMngArguments? passMngArguments = passRoutes["passMngDetails"];
          return MaterialPageRoute(
              builder: (context) => DayPassManagementList(
                    passId: passMngArguments?.passType ?? '',
                    title: passMngArguments?.title ?? '',
                  ));
        }
        return MaterialPageRoute(builder: (context) => DayPassManagementList());
      case daypassregistertListRoute:
        if (settings.arguments != null) {
          final passRoutes = settings.arguments as Map<String, dynamic>;
          PassMngArguments? passMngArguments =
              passRoutes["passMngRegisterDetails"];
          return MaterialPageRoute(
              builder: (context) => DayPassInfoListPage(
                    passId: passMngArguments?.passType ?? '',
                    title: passMngArguments?.title ?? '',
                  ));
        }
        return MaterialPageRoute(builder: (context) => DayPassInfoListPage());
      case createpassmgmtRoute:
        if (settings.arguments != null) {
          final passRoutes = settings.arguments as Map<String, dynamic>;
          CreatePassMngArguments? passMngArguments =
              passRoutes["passMngCreateDetails"];
          return MaterialPageRoute(
            builder: (context) => CreatePassManagement(
              passId: passMngArguments?.passType ?? '',
              title: passMngArguments?.title ?? '',
              model: passMngArguments?.model,
            ),
          );
        }
        return MaterialPageRoute(builder: (context) => CreatePassManagement());

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
              ..add(const sla.FetchData(startPos: 0, maxPos: 20)),
            child: const SLAViolationPenaltyListView(),
          ),
        );

      case slaViolationPenaltyDetailsRoute:
        SLAViolationPenaltyServices services = SLAViolationPenaltyServices();
        CommonServices commonServices = CommonServices();
        String title;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        SLAViolationPenaltyModel? model = arguments["model"];
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SLAViolationPenaltyDetailsCubit>(
            create: (_) => SLAViolationPenaltyDetailsCubit(
              services: services,
              model: model,
              commonServices: commonServices,
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
        String violationDescription = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id];
          title = arguments[ConstantsArgument.title];
          violationDescription =
              arguments[ConstantsArgument.violationDescription] ?? '';
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<vp.ViolationPenaltyRecordBloc>(
            create: (_) => vp.ViolationPenaltyRecordBloc(
              violationDescription: violationDescription,
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
              ..add(const cd.FetchData(startPos: 0, maxPos: 20)),
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
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          id = arguments[ConstantsArgument.id];
          title = arguments[ConstantsArgument.title];
          type = arguments[ConstantsArgument.type] ?? 0;
          rankType = arguments[ConstantsArgument.rankType] ?? '';
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<cr.ContactRecordBloc>(
            create: (_) => cr.ContactRecordBloc(
              rankType: rankType,
            )..add(cr.FetchData(
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
              ..add(const ep.FetchData(startPos: 0, maxPos: 20)),
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
            builder: (context) => BlocProvider<MaterialMovementBloc>(
                  create: (_) => MaterialMovementBloc(isInward: isInward)
                    ..add(const FetchData(startPos: 0, maxPos: 20)),
                  child: MaterialMovementsView(
                    isInward: isInward,
                  ),
                ));

      case materialMovementInwardDetailsRoute:
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
                      materialMovement: materialMovement,
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
              ..add(const guarding.FetchList(startPos: 0, maxPos: 20)),
            child: const GuardingRates(),
          ),
        );

      case guardingMasterReportRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<GuardingMasterReportBloc>(
                  create: (_) => GuardingMasterReportBloc()
                    ..add(const FetchReportList(startPos: 0, maxPos: 20)),
                  child: const GuardingMasterReport(),
                ));

      case guardingMasterDataRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<GuardingMasterDataBloc>(
                  create: (_) => GuardingMasterDataBloc()
                    ..add(const FetchDataList(startPos: 0, maxPos: 20)),
                  child: const GuardingMasterDataView(),
                ));

      case guardingMasterDataDetailsRoute:
        GuardingMasterDataServices services = GuardingMasterDataServices();
        CommonServices commonServices = CommonServices();
        String title;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments[ConstantsArgument.title];
        GuardingMastersDataModel? guardingMastersData =
            arguments["GuardingMastersDataModel"];
        return MaterialPageRoute(
          builder: (context) => BlocProvider<GuardingMasterDataDetailsCubit>(
            create: (_) => GuardingMasterDataDetailsCubit(
              services: services,
              model: guardingMastersData,
              commonServices: commonServices,
            ),
            child: GuardingMasterDataDetails(
              guardingMasterData: guardingMastersData,
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
      default:
        return MaterialPageRoute(builder: (context) => const DashboardView());
    }
  }
}
