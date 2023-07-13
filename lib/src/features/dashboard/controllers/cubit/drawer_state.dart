part of 'drawer_cubit.dart';

abstract class DrawerState extends Equatable {
  final int index;
   const DrawerState(this.index);
  

   @override
  List<Object> get props => [];
}

  class DrawerInitial extends DrawerState {
    
    const DrawerInitial() :super(0);
  }

class SetDrawerItemChange extends DrawerState{
   SetDrawerItemChange(this.index) : super(index);
   
  @override
  final int index;
}
class GetDrawerItemChange extends DrawerState{
  GetDrawerItemChange(super.index);

}

class OperationsSetDrawerItemChange extends DrawerState{
   OperationsSetDrawerItemChange(this.index) : super(index);
   
  @override
  final int index;
}
class OperationsGetDrawerItemChange extends DrawerState{
  OperationsGetDrawerItemChange(super.index);

}

class SecurityFunctionsSetDrawerItemChange extends DrawerState{
   SecurityFunctionsSetDrawerItemChange(this.index) : super(index);
   
  @override
  final int index;
}
class SecurityFunctionsGetDrawerItemChange extends DrawerState{
  SecurityFunctionsGetDrawerItemChange(super.index);

}




