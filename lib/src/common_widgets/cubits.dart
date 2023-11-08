import 'package:db_atom/src/features/article_found_register_module/foundlist/controllers/foundlist_cubit.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/services/foundlist_services.dart';
import 'package:db_atom/src/features/createfound/controllers/create_found_cubit.dart';
import 'package:db_atom/src/features/createfound/services/create_found_services.dart';
import 'package:db_atom/src/features/law_enforcement_list/services/law_enforcement_list_services.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_cubit.dart';
import 'package:db_atom/src/features/lawenforcement/services/law_enforcement_service.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/controllers/create_pass_mgmt_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/services/create_pass_mgmt_services.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/controllers/day_passlist_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/services/day_passlist_services.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/controllers/day_pass_info_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/services/day_pass_info_services.dart';

import '../features/law_enforcement_list/controllers/law_enforcement_list_cubit.dart';

FoundListCubit foundListArticleCubit =
    FoundListCubit(foundListServices: FoundListServices());

CreateFoundArticleCubit createFoundArticleCubit =
    CreateFoundArticleCubit(createFoundServices: CreateFoundServices());

// LoginCubit loginCubit = LoginCubit(loginService: LoginService());

LawEnforcementCubit lawenforcementCubit =
    LawEnforcementCubit(lawenforcementServices: LawEnforcementService());

LawEnforcementListCubit lawEnforcementListCubit = LawEnforcementListCubit(
    lawEnforcementListServices: LawEnforcementListServices());

DayPassListCubit daypassListCubit =
    DayPassListCubit(passListServices: DayPassListServices());

DayPassInfoCubit daypassinfoCubit =
    DayPassInfoCubit(passListServices: DayPassInfoServices());

CreatePassMgmtCubit createpassmgmtCubit =
    CreatePassMgmtCubit(createpassmgmtServices: CreatePassMgmtService());
