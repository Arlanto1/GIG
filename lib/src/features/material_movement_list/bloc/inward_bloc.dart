import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'inward_event.dart';
part 'inward_state.dart';

class InwardBloc extends Bloc<InwardEvent, InwardState> {
  InwardBloc() : super(InwardInitial()) {
    on<InwardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
