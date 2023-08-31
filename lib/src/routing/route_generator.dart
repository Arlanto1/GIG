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
import 'package:db_atom/src/features/guarding_operations/drop_pick_up/bloc/female_drop_pick_up_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/drop_pick_up/views/female_drop_pick_up_view.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/guarding_rate_details/pay_rates/cubits/pay_rate_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/guarding_rates/bloc/guarding_rates_bloc.dart'
    as guarding;
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/services/guarding_services.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/law_enforcement_list/views/ln_list_page.dart';
import 'package:db_atom/src/features/lawenforcement/views/lawencorcementcreate.dart';
import 'package:db_atom/src/features/login/views/forgot_pwd_screen.dart';
import 'package:db_atom/src/features/login/views/login_screen.dart';
import 'package:db_atom/src/features/login/views/otp_verify_screen.dart';
import 'package:db_atom/src/features/login/views/reset_password_screen.dart';
import 'package:db_atom/src/features/onboarding/views/splashscreen.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/views/create_pass_mgmt.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/guarding_operations/guarding_master_data/guarding_master_data/bloc/guarding_master_data_bloc.dart';
import '../features/guarding_operations/guarding_master_data/guarding_master_data/views/guarding_master_data.dart';
import '../features/guarding_operations/guarding_master_data/guarding_master_data_details/cubits/guarding_master_data_details_cubit.dart';
import '../features/guarding_operations/guarding_master_data/guarding_master_data_details/views/guarding_master_data_details.dart';
import '../features/guarding_operations/guarding_master_data/models/guarding_master_data_model.dart';
import '../features/guarding_operations/guarding_master_data/services/guarding_master_data_services.dart';
import '../features/guarding_operations/guarding_master_reports/bloc/guarding_master_report_bloc.dart';
import '../features/guarding_operations/guarding_master_reports/views/guarding_master_reports.dart';
import '../features/guarding_operations/guarding_rate/guarding_rate_details/pay_rates/views/pay_rate_view.dart';
import '../features/guarding_operations/guarding_rate/guarding_rate_details/views/guarding_rate_details.dart';
import '../features/guarding_operations/guarding_rate/guarding_rate_details/views/rates_info.dart';
import '../features/guarding_operations/guarding_rate/guarding_rates/views/gaurading_rates.dart';
import '../features/material_movement/material_movement_details/cubits/material_movement_details_cubit.dart';
import '../features/material_movement/material_movement_details/views/material_movement_details.dart';
import '../features/material_movement/material_movements/bloc/material_movement_bloc.dart';
import '../features/material_movement/material_movements/views/material_movements.dart';
import '../features/material_movement/models/material_movements_model.dart';
import '../features/material_movement/services/material_movement_services.dart';
import '../features/passmanagement/daypassmgmt/passmgmtlist/views/day_pass_management_list_page.dart';
import '../features/passmanagement/daypassregister/views/day_pass_info_list_page.dart';
import '../services/CommonServices.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    // ignore: non_constant_identifier_names
    switch (settings.name) {
      case appRoute:
        return MaterialPageRoute(builder: (context) => App());
      case homePageRoute:
        return MaterialPageRoute(builder: (context) => const MyHomePage());
      case splashScreenRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case loginScreenRoute:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case forgotPwdScreenRoute:
        return MaterialPageRoute(builder: (context) => const ForgotPwdScreen());
      case resetPwdScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const ResetPasswordScreen());
      case otpVerificationRoute:
        if (settings.arguments != null) {
          final userRoutes = settings.arguments as Map<String, dynamic>;
          if (userRoutes != null) {
            VerifyOTPArguments? userDetails = userRoutes["userDetails"];
            return MaterialPageRoute(
                builder: (context) => OtpVerifyScreen(
                      userName: userDetails?.name ?? '',
                      password: userDetails?.pwd ?? '',
                    ));
          }
          return MaterialPageRoute(builder: (context) => OtpVerifyScreen());
        }
        return MaterialPageRoute(builder: (context) => OtpVerifyScreen());

      case createfoundScreenRoute:
        if (settings.arguments != null) {
          final listroutes = settings.arguments as Map<String, dynamic>;
          if (listroutes != null) {
            FoundListArticleDetails? listuser = listroutes["UserElement"];
            return MaterialPageRoute(
                builder: (context) => Createfound(listuser: listuser));
          }
          return MaterialPageRoute(builder: (context) => Createfound());
        } else {
          return MaterialPageRoute(builder: (context) => Createfound());
        }
      case lawenforcementScreenRoute:
        // return MaterialPageRoute(builder: (context) => CreateLawenforcement());
        if (settings.arguments != null) {
          final listroutes = settings.arguments as Map<String, dynamic>;
          if (listroutes != null) {
            LawEnforcementDetails? listuser = listroutes["UserElement"];
            return MaterialPageRoute(
                builder: (context) => CreateLawenforcement(listuser: listuser));
          }
          return MaterialPageRoute(
              builder: (context) => CreateLawenforcement());
        } else {
          return MaterialPageRoute(
              builder: (context) => CreateLawenforcement());
        }
      case addemployeedepartmentRoute:
        return MaterialPageRoute(
            builder: (context) => AddEmployeeDepartment(
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
            builder: (context) => CustomExpansionListTexts());
      case lawEnforcementListRoute:
        return MaterialPageRoute(builder: (context) => const LnListPageList());
      case daypassmanagementListRoute:
        if (settings.arguments != null) {
          final passRoutes = settings.arguments as Map<String, dynamic>;
          if (passRoutes != null) {
            PassMngArguments? passMngArguments = passRoutes["passMngDetails"];
            return MaterialPageRoute(
                builder: (context) => DayPassManagementList(
                      passId: passMngArguments?.passType ?? '',
                      title: passMngArguments?.title ?? '',
                    ));
          }
          return MaterialPageRoute(
              builder: (context) => DayPassManagementList());
        }
        return MaterialPageRoute(builder: (context) => DayPassManagementList());
      case daypassregistertListRoute:
        if (settings.arguments != null) {
          final passRoutes = settings.arguments as Map<String, dynamic>;
          if (passRoutes != null) {
            PassMngArguments? passMngArguments =
                passRoutes["passMngRegisterDetails"];
            return MaterialPageRoute(
                builder: (context) => DayPassInfoListPage(
                      passId: passMngArguments?.passType ?? '',
                      title: passMngArguments?.title ?? '',
                    ));
          }
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
          if (passRoutes != null) {
            CreatePassMngArguments? passMngArguments =
                passRoutes["passMngCreateDetails"];
            return MaterialPageRoute(
                builder: (context) => CreatePassManagement(
                      passId: passMngArguments?.passType ?? '',
                      title: passMngArguments?.title ?? '',
                      listuser: passMngArguments?.listuser,
                    ));
          }
          return MaterialPageRoute(
              builder: (context) => CreatePassManagement());
        }
        return MaterialPageRoute(builder: (context) => CreatePassManagement());

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
                    ..add(const InwardFetch(startPos: 0, maxPos: 20)),
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
                  child: const GuardingMasterData(),
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
                    guardingMasterDataServices: services,
                    model: guardingMastersData,
                    commonServices: commonServices,
                  ),
                  child: GuardigMasterDataDetails(
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
          payRates = arguments['payRates'];
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
        return MaterialPageRoute(builder: (context) => App());
    }
  }
}
