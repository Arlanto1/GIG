part of 'drawer_cubit.dart';

abstract class DrawerState extends Equatable {
  final int index;

  const DrawerState(this.index);

  @override
  List<Object> get props => [];
}

class DrawerInitial extends DrawerState {
  const DrawerInitial() : super(0);
}

class SetDrawerItemChange extends DrawerState {
  const SetDrawerItemChange(this.index) : super(index);

  @override
  final int index;
}

class GetDrawerItemChange extends DrawerState {
  const GetDrawerItemChange(super.index);
}

class OperationsSetDrawerItemChange extends DrawerState {
  const OperationsSetDrawerItemChange(this.index) : super(index);

  @override
  final int index;
}

class OperationsGetDrawerItemChange extends DrawerState {
  const OperationsGetDrawerItemChange(super.index);
}

class SecurityFunctionsSetDrawerItemChange extends DrawerState {
  const SecurityFunctionsSetDrawerItemChange(this.index) : super(index);

  @override
  final int index;
}

class SecurityFunctionsGetDrawerItemChange extends DrawerState {
  const SecurityFunctionsGetDrawerItemChange(super.index);
}

class PassMgmtSetDrawerItemChange extends DrawerState {
  const PassMgmtSetDrawerItemChange(this.index) : super(index);

  @override
  final int index;
}

class PassMgmtGetDrawerItemChange extends DrawerState {
  const PassMgmtGetDrawerItemChange(super.index);
}

class TicketingSystemSetDrawerItemChange extends DrawerState {
  const TicketingSystemSetDrawerItemChange(this.index) : super(index);

  @override
  final int index;
}

class TicketingSystemGetDrawerItemChange extends DrawerState {
  const TicketingSystemGetDrawerItemChange(super.index);
}
