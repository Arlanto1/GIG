import 'package:db_atom/src/features/article_found_register_module/foundlist/controllers/foundlist_cubit.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/services/foundlist_services.dart';
import 'package:db_atom/src/features/createfound/controllers/create_found_cubit.dart';
import 'package:db_atom/src/features/createfound/services/create_found_services.dart';
import 'package:db_atom/src/features/dashboard/dashboard_screen/charts/cubits/charts_cubit.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_cubit.dart';
import 'package:db_atom/src/features/lawenforcement/services/law_enforcement_services.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/controllers/create_pass_mgmt_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/services/create_pass_mgmt_services.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/controllers/day_passlist_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/services/day_passlist_services.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/controllers/day_pass_info_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/services/day_pass_info_services.dart';
import 'package:db_atom/src/services/CommonServices.dart';

import '../features/law_enforcement_list/controllers/law_enforcement_list_cubit.dart';

FoundListCubit foundListArticleCubit =
    FoundListCubit(foundListServices: FoundListServices());

CreateFoundArticleCubit createFoundArticleCubit =
    CreateFoundArticleCubit(createFoundServices: CreateFoundServices());

// LoginCubit loginCubit = LoginCubit(loginService: LoginService());

LawEnforcementCubit lawEnforcementCubit =
    LawEnforcementCubit(services: LawEnforcementServices());

LawEnforcementListCubit lawEnforcementListCubit =
    LawEnforcementListCubit(services: LawEnforcementServices());

DayPassListCubit dayPassListCubit =
    DayPassListCubit(passListServices: DayPassListServices());

DayPassInfoCubit dayPassInfoCubit =
    DayPassInfoCubit(passListServices: DayPassInfoServices());

CreatePassMgmtCubit createPassMgmtCubit =
    CreatePassMgmtCubit(createpassmgmtServices: CreatePassMgmtService());

ChartsCubit chartsCubit = ChartsCubit(commonServices: CommonServices());
