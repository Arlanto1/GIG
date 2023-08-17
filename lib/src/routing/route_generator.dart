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
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/law_enforcement_list/views/ln_list_page.dart';
import 'package:db_atom/src/features/lawenforcement/views/lawencorcementcreate.dart';
import 'package:db_atom/src/features/login/views/login_screen.dart';
import 'package:db_atom/src/features/login/views/otp_verify_screen.dart';
import 'package:db_atom/src/features/onboarding/views/splashscreen.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/views/create_pass_mgmt.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return MaterialPageRoute(builder: (context) => MyHomePage());
      case splashScreenRoute:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case loginScreenRoute:
        return MaterialPageRoute(builder: (context) => LoginScreen());
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
        return MaterialPageRoute(builder: (context) => FoundList());
      case createFoundAttachmentRoute:
        return MaterialPageRoute(builder: (context) => CreateFoundAttachment());
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

      default:
        return MaterialPageRoute(builder: (context) => App());
    }
  }
}
