import 'package:db_atom/index.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(const DrawerInitial());

  Future<void> getIndexChange(int index) async {
    emit(SetDrawerItemChange(index));
    emit(GetDrawerItemChange(index));
  }

  void getOperationsIndexChange(int index) {
    emit(OperationsSetDrawerItemChange(index));
    emit(OperationsGetDrawerItemChange(index));
  }

  void getSecurityIndexChange(int index) {
    emit(SecurityFunctionsSetDrawerItemChange(index));
    emit(SecurityFunctionsGetDrawerItemChange(index));
  }

  void getPassMgmtIndexChange(int index) {
    emit(PassMgmtSetDrawerItemChange(index));
    emit(PassMgmtGetDrawerItemChange(index));
  }
}
