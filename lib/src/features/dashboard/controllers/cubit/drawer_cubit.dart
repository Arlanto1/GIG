import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(const DrawerInitial());

  Future<void> getindexChange(int index) async {
    emit(SetDrawerItemChange(index));
    emit(GetDrawerItemChange(index));
  }

  void getOperationsindexChange(int index) {
    emit(OperationsSetDrawerItemChange(index));
    emit(OperationsGetDrawerItemChange(index));
  }

  void getSecurityindexChange(int index) {
    emit(SecurityFunctionsSetDrawerItemChange(index));
    emit(SecurityFunctionsGetDrawerItemChange(index));
  }

  void getPassmgmtindexChange(int index) {
    emit(PassmgmtSetDrawerItemChange(index));
    emit(PassmgmtGetDrawerItemChange(index));
  }
}
