import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/material_movement/material_movements/models/material_movements_model.dart';
import 'package:db_atom/src/features/material_movement/services/material_movement_services.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:equatable/equatable.dart';

import '../../../../constants/constants.dart';

part 'inward_state.dart';

class InwardCubit extends Cubit<InwardState> {
  final MaterialMovementServices materialMovementServices;
  final MaterialMovementModel? model;
  final CommonServices commonServices;
  InwardCubit({required this.materialMovementServices, required this.commonServices, required this.model})
      : super(
          InwardState.initial(
            model:model?? MaterialMovementModel(),
            locations: GetLocations(),
            errorMessage: ''
          ),
        );


  void onModelValueChange(MaterialMovementModel model) {
    emit(state.copyWith(materialMovement: model, status: FormStatus.initial));
  }

  // Get locations api call
  Future<void> getLocations() async {
    try {
      GetLocations getLocationsData =
      await commonServices.getLocations(locationName: 'ATOM_LOCATIONS');
      emit(
        state.copyWith(
          locations: getLocationsData,
          status: FormStatus.initial,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,  // TODO: error message should be dynamic
          status: FormStatus.error,
        ),
      );
    }
  }
}
