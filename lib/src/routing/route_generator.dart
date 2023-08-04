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
import 'package:db_atom/src/features/login/views/login_view.dart';
import 'package:db_atom/src/features/material_movement/material_movements/bloc/inward_bloc.dart';
import 'package:db_atom/src/features/material_movement/material_movements/models/material_movements_model.dart';
import 'package:db_atom/src/features/material_movement/material_movement_details/views/material_movement_inward.dart';
import 'package:db_atom/src/features/material_movement/material_movements/views/material_movement_inwards.dart';
import 'package:db_atom/src/features/onboarding/views/splashscreen.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
        return MaterialPageRoute(builder: (context) => const LoginView());

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
          return MaterialPageRoute(builder: (context) => CreateLawenforcement());
        } else {
          return MaterialPageRoute(builder: (context) => CreateLawenforcement());
        }
      case addemployeedepartmentRoute:
        return MaterialPageRoute(
            builder: (context) => AddEmployeeDepartment(
                  title: Constants.addemployeedepartment,
                ));

      case articleFoundListRoute:
        return MaterialPageRoute(builder: (context) => const FoundList());
      case createFoundAttachmentRoute:
        return MaterialPageRoute(builder: (context) => const CreateFoundAttachment());
      case piechartRoute:
        return MaterialPageRoute(builder: (context) => PieChartApp());
      case customexpansionlisttextsRoute:
        return MaterialPageRoute(
            builder: (context) => CustomExpansionListTexts());
      case lawEnforcementListRoute:
        return MaterialPageRoute(builder: (context) => const LnListPageList());

      case materialMovementInwards:
        return MaterialPageRoute(builder: (context) => BlocProvider<InwardBloc>(
          create: (_) => InwardBloc()
            ..add( const InwardFetch(startPos: 0, maxPos: 20)),
          child: const MaterialMovementInwards(),
        ));

      case materialMovementInward:
        if (settings.arguments != null) {
          Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
          if (arguments.isNotEmpty) {
            MaterialMovementModel? materialMovement = arguments["MaterialMovementModel"];
            return MaterialPageRoute(
                builder: (context) => MaterialMovementInward(materialMovement: materialMovement));
          }
          return MaterialPageRoute(builder: (context) => const MaterialMovementInward());
        } else {
          return MaterialPageRoute(builder: (context) => const MaterialMovementInward());
        }

      default:
        return MaterialPageRoute(builder: (context) => App());
    }
  }
}
