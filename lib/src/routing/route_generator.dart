import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/app.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_article_details.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/views/found_list_page.dart';
import 'package:db_atom/src/features/createfound/views/add_employee_deparment.dart';
import 'package:db_atom/src/features/createfound/views/create_found.dart';
import 'package:db_atom/src/features/createfound/views/create_found_attachment.dart';
import 'package:db_atom/src/features/dashboard/views/charts/pie_chart.dart';
import 'package:db_atom/src/features/dashboard/views/my_home_page.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/contact_info/cubits/contact_info_cubit.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/contact_info/views/contact_info_view.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/event_info/views/event_info_view.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/general_information/guard_info/cubits/guard_info_cubit.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/general_information/guard_info/views/guard_info_view.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/views/event_protection_details.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/views/gereral_info_tiles_view.dart';
import 'package:db_atom/src/features/guarding_operations/drop_pick_up/bloc/female_drop_pick_up_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/drop_pick_up/views/female_drop_pick_up_view.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/guarding_master_data_details/views/guarding_master_data_details.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/guarding_rate_details/pay_rates/cubits/pay_rate_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/guarding_rates/bloc/guarding_rates_bloc.dart'
    as guarding;
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/services/guarding_services.dart';
import 'package:db_atom/src/features/incident_management/incident_managements/bloc/incident_management_bloc.dart'
    as im;
import 'package:db_atom/src/features/incident_management/services/incident_management_services.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/law_enforcement_list/views/law_enforcements_view.dart';
import 'package:db_atom/src/features/login/views/forgot_pwd_screen.dart';
import 'package:db_atom/src/features/login/views/login_screen.dart';
import 'package:db_atom/src/features/login/views/otp_verify_screen.dart';
import 'package:db_atom/src/features/login/views/reset_password_screen.dart';
import 'package:db_atom/src/features/material_movement/models/material_movement_model.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/views/occurrence_general_info_view.dart';
import 'package:db_atom/src/features/onboarding/views/splashscreen.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/views/create_pass_mgmt.dart';
import 'package:db_atom/src/features/security_systems/sst_incident_details/general_info/views/sst_incident_general_info_view.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/event_protection/event_protection_details/event_info/cubits/event_info_cubit.dart';
//import '../features/event_protection/event_protection_details/general_info/cubits/occurrence_general_info_cubit.dart';
import '../features/event_protection/event_protection_details/general_info/cubits/general_info_cubit.dart';
import '../features/event_protection/event_protection_details/general_info/views/general_info_view.dart';
import '../features/event_protection/event_protections/bloc/event_protections_bloc.dart'
    as ep;
import '../features/event_protection/event_protections/views/event_protections_view.dart';
import '../features/event_protection/services/event_protection_services.dart';
import '../features/guarding_operations/guarding_master_data/guarding_master_data/bloc/guarding_master_data_bloc.dart';
import '../features/guarding_operations/guarding_master_data/guarding_master_data/views/guarding_master_data_view.dart';
import '../features/guarding_operations/guarding_master_data/guarding_master_data_details/cubits/guarding_master_data_details_cubit.dart';
import '../features/guarding_operations/guarding_master_data/models/guarding_master_data_model.dart';
import '../features/guarding_operations/guarding_master_data/services/guarding_master_data_services.dart';
import '../features/guarding_operations/guarding_master_reports/bloc/guarding_master_report_bloc.dart';
import '../features/guarding_operations/guarding_master_reports/views/guarding_master_reports.dart';
import '../features/guarding_operations/guarding_rate/guarding_rate_details/pay_rates/views/pay_rate_view.dart';
import '../features/guarding_operations/guarding_rate/guarding_rate_details/views/guarding_rate_details.dart';
import '../features/guarding_operations/guarding_rate/guarding_rate_details/views/rates_info.dart';
import '../features/guarding_operations/guarding_rate/guarding_rates/views/gaurading_rates.dart';
import '../features/incident_management/incident_details/general_info/cubits/incident_general_info_cubit.dart';
import '../features/incident_management/incident_details/general_info/views/incident_general_info_view.dart';
import '../features/incident_management/incident_managements/views/incident_managements_view.dart';
import '../features/lawenforcement/views/law_enforcement_details_view.dart';
import '../features/login/bloc/login_bloc.dart';
import '../features/login/services/login_services.dart';
import '../features/material_movement/material_movement_details/cubits/material_movement_details_cubit.dart';
import '../features/material_movement/material_movement_details/views/material_movement_details.dart';
import '../features/material_movement/material_movements/bloc/material_movement_bloc.dart';
import '../features/material_movement/material_movements/views/material_movements.dart';
import '../features/material_movement/services/material_movement_services.dart';
import '../features/occurrence/occurrences_details/general_info/cubits/occurrence_general_info_cubit.dart';
import '../features/occurrence/occurrences_details/general_info/services/occurrences_services.dart';
import '../features/occurrenceList/bloc/occurrences_bloc.dart' as ocb;
import '../features/occurrenceList/views/occurrences_view.dart';
import '../features/passmanagement/daypassmgmt/passmgmtlist/views/day_pass_management_list.dart';
import '../features/passmanagement/daypassregister/views/day_pass_info_list_page.dart';
import '../features/security_systems/services/sst_incident_services.dart';
import '../features/security_systems/sst_incident_details/general_info/cubits/sst_incident_general_info_cubit.dart';
import '../features/security_systems/sst_incident_list/bloc/sst_incident_bloc.dart'
    as sv;
import '../features/security_systems/sst_incident_list/views/sst_incident_view.dart';
import '../services/CommonServices.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    // ignore: non_constant_identifier_names
    switch (settings.name) {
      case appRoute:
        return MaterialPageRoute(builder: (context) => const App());
      case homePageRoute:
        return MaterialPageRoute(builder: (context) => const MyHomePage());
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
                  ));
                  return MaterialPageRoute(
              builder: (context) => const OtpVerifyScreen());
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
                  ));
                  return MaterialPageRoute(builder: (context) => const CreateFound());
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
                  return MaterialPageRoute(
              builder: (context) => const LawEnforcementDetailsView());
        } else {
          return MaterialPageRoute(
              builder: (context) => const LawEnforcementDetailsView());
        }
      case addemployeedepartmentRoute:
        return MaterialPageRoute(
            builder: (context) => const AddEmployeeDepartment(
                  title: Constants.addemployeedepartment,
                ));

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
        return MaterialPageRoute(builder: (context) => const LawEnforcementsView());
      case daypassmanagementListRoute:
        if (settings.arguments != null) {
          final passRoutes = settings.arguments as Map<String, dynamic>;
          PassMngArguments? passMngArguments = passRoutes["passMngDetails"];
          return MaterialPageRoute(
              builder: (context) => DayPassManagementList(
                    passId: passMngArguments?.passType ?? '',
                    title: passMngArguments?.title ?? '',
                  ));
                  return MaterialPageRoute(
              builder: (context) => DayPassManagementList());
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
                  return MaterialPageRoute(builder: (context) => DayPassInfoListPage());
        }
        return MaterialPageRoute(builder: (context) => DayPassInfoListPage());
      case createpassmgmtRoute:
        // return MaterialPageRoute(builder: (context) => CreatePassManagement());
        // if (settings.arguments != null) {
        //     final listroutes = settings.arguments as Map<String, dynamic>;

        //     if (listroutes != null) {
        //      // DayPassListItemResponse? listuser = listroutes["UserElement"];
        //       PassMngArguments? passMngArguments = listroutes["passMngRegisterDetails"];
        //       return MaterialPageRoute(
        //           builder: (context) => CreatePassManagement(listuser: listuser));
        //     }

        //     return MaterialPageRoute(
        //         builder: (context) => CreatePassManagement());
        //   } else {
        //     return MaterialPageRoute(
        //         builder: (context) => CreatePassManagement());
        //   }

        if (settings.arguments != null) {
          final passRoutes = settings.arguments as Map<String, dynamic>;
          CreatePassMngArguments? passMngArguments =
              passRoutes["passMngCreateDetails"];
          return MaterialPageRoute(
              builder: (context) => CreatePassManagement(
                    passId: passMngArguments?.passType ?? '',
                    title: passMngArguments?.title ?? '',
                    model: passMngArguments?.model,
                  ));
                  return MaterialPageRoute(
              builder: (context) => CreatePassManagement());
        }
        return MaterialPageRoute(builder: (context) => CreatePassManagement());

      case incidentManagementsRoute:
        String occId = '';
        int occType = 0;

        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          occId = arguments['occId'];
          occType = arguments['occType'] ?? 0;
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<im.IncidentManagementsBloc>(
            create: (_) => im.IncidentManagementsBloc(occType, occId)
              ..add(const im.FetchData(startPos: 0, maxPos: 20)),
            child: const IncidentManagementsView(),
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
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          isInternal = arguments['isInternal'];
        }
        return MaterialPageRoute(
          builder: (context) => BlocProvider<sv.SstIncidentBloc>(
            create: (_) => sv.SstIncidentBloc(
              ticketType: 1,
              staffType: isInternal ? 1 : 2,
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
                ));

      case eventInfoRoute:
        String id = '';

        int eventDuration = 0;
        String title = '';
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
          title = arguments['title'] ?? '';
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
                  child: MaterialMovements(
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
        title = arguments['title'];
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
                    child: MaterialMovementDetails(
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
                  child: MaterialMovementDetails(
                    isInward: isInward,
                    title: title,
                  ),
                ));

      case guardingRatesRoute:
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
        }
        return MaterialPageRoute(
            builder: (context) => BlocProvider<guarding.GuardingRatesBloc>(
                  create: (_) => guarding.GuardingRatesBloc()
                    ..add(const guarding.FetchList(startPos: 0, maxPos: 20)),
                  child: const GuardingRates(),
                ));

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
        title = arguments['title'];
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
                ));

      case guardingRateDetailsRoute:
        GuardingServices services = GuardingServices();
        String title;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments['title'];
        GMRate rate = arguments['gmRate'];
        return MaterialPageRoute(
            builder: (context) => BlocProvider<PayRateCubit>(
                  create: (_) => PayRateCubit(
                    services: services,
                    rate: rate,
                    payRates: [],
                  ),
                  child: GuardingRateDetails(
                    rate: rate,
                    title: title,
                  ),
                ));

      case guardingRatesGRIRoute:
        GuardingServices services = GuardingServices();
        CommonServices commonServices = CommonServices();
        String title;
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        title = arguments['title'];
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
          title = arguments['title'];
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
        if (settings.arguments != null) {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;
        }
        return MaterialPageRoute(
            builder: (context) => BlocProvider<FemaleDropPickUpBloc>(
                  create: (_) => FemaleDropPickUpBloc()
                    ..add(const FetchList(startPos: 0, maxPos: 20)),
                  child: const FemaleDropPickUpView(),
                ));
      default:
        return MaterialPageRoute(builder: (context) => const MyHomePage());
    }
  }
}
