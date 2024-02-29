import 'package:db_atom/index.dart';
import 'package:db_atom/src/services/common_services.dart';

part 'base_filter_state.dart';

class BaseFilterCubit extends Cubit<BaseFilterState> {
  BaseFilterCubit()
      : super(const BaseFilterState(status: FormStatus.loading, locations: []));

  Future<void> getRegionsOrLocationsByRegionId({required int id}) async {
    emit(state.copyWith(status: FormStatus.loading));
    List<Organisation> locations = [];
    locations = await CommonServices().getRegionsOrLocationsByRegionId(id: id);

    emit(
      state.copyWith(
        status: FormStatus.initial,
        locations: locations,
      ),
    );
  }
}
