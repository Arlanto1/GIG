// import 'dart:async';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/article_found/models/article_found_model.dart';
// import 'package:db_atom/src/features/article_found/services/article_found_service.dart';
// import 'package:db_atom/src/features/patrolling/models/patrolling_model.dart';
// part 'training_module_list_event.dart';
// part 'training_module_list_state.dart';
//
// class TrainingModuleListBloc extends Bloc<TrainingModuleListEvent, TrainingModuleListState>{
//   TrainingModuleListBloc(): super(const TrainingModuleListState(items: [])){
//     on<InitializeValuesTraining>(_initializeValues);
//     on<RefreshTrainingList>(_refreshList);
//     on<FetchTrainingData>(_fetchArticleList);
//   }
//
//   ArticleFoundServices services = ArticleFoundServices();
//   final CommonServices commonServices = CommonServices();
//
//   FutureOr<void> _initializeValues(
//       InitializeValuesTraining event, Emitter<TrainingModuleListState> emit) async {
//     try {
//       emit(state.copyWith(status: FormStatus.loading));
//
//       ExtraProperties extraProperties =
//       await UtilsCommon().checkWritePermission(
//         moduleCode: Constants.leoModuleCode,
//         commonServices: commonServices,
//       );
//
//       List<Organisation> statuses = await commonServices.getStatusesByModuleId(
//           module: Constants.articleFoundModuleCode);
//
//       List<Organisation> regions =
//       await commonServices.getRegionsOrLocationsByRegionId();
//
//       CommonFilters commonFilters =
//       CommonFilters(regions: regions, statuses: statuses);
//
//       Locations locations =
//       await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');
//
//       dynamic responseLabels = await commonServices.getUiLabels(
//           language: await SharedPrefs.getLanguageCode(),
//           moduleCode: Constants.articleFoundModuleCode);
//
//       AFUiLabels labels = AFUiLabels.fromJson(responseLabels);
//
//       return emit(
//         state.copyWith(
//           location: locations,
//           regions: regions,
//           statuses: statuses,
//           commonFilters: commonFilters,
//           hasReachedMax: false,
//           status: FormStatus.initial,
//           labels: labels,
//           extraProperties: extraProperties,
//         ),
//       );
//     } on GenericResponse catch (e) {
//       emit(
//         state.copyWith(
//           message: e.message,
//           status: FormStatus.formError,
//         ),
//       );
//       return;
//     } on Exception catch (e) {
//       return UtilsCommon().exceptionHandling(e, emit, state);
//     }
//   }
//   FutureOr<void> _refreshList(
//       RefreshTrainingList event, Emitter<TrainingModuleListState> emit) async {
//     try {
//       final ArticleFoundResponseModel response = await services
//           .getListWithFilters(
//           startPosition: '0',
//           maximumRecords: '20',
//           filters: BaseFilterModel()
//       );
//       return emit(
//         state.copyWith(
//           items: response.list,
//           hasReachedMax: false,
//           status: FormStatus.success,
//         ),
//       );
//     } on Exception catch(e){
//       return UtilsCommon().exceptionHandling(e, emit, state);
//     }
//   }
//
//   Future<void> _fetchArticleList(FetchTrainingData event, Emitter<TrainingModuleListState> emit) async {
//     emit(
//         state.copyWith(
//             status: FormStatus.loading
//         )
//     );
//
//     try {
//       if (state.status == FormStatus.initial || event.newSearch) {
//         ArticleFoundResponseModel response;
//
//         response = await services.getListWithFilters(
//           startPosition: '${event.startPos}',
//           maximumRecords: '${event.maxPos}',
//           filters: event.filters,
//         );
//
//         return emit(
//           state.copyWith(
//             items: response.list,
//             hasReachedMax: (response.list?.length ?? 0) < event.maxPos,
//             status: FormStatus.success,
//           ),
//         );
//       }
//
//       ArticleFoundResponseModel response;
//
//       response = await services.getListWithFilters(
//         startPosition: '${event.startPos}',
//         maximumRecords: '${event.maxPos}',
//         // passType: 0,
//         filters: event.filters,
//       );
//
//       if (response.list?.isEmpty == true) {
//         return emit(state.copyWith(hasReachedMax: true));
//       }
//       return emit(
//         state.copyWith(
//           items: List.of(state.items)..addAll(response.list ?? []),
//           hasReachedMax: false,
//           status: FormStatus.success,
//         ),
//       );
//     }
//
//     on TokenExpiredException catch(e){
//       emit(
//           state.copyWith(
//               message: e.message,
//               status: FormStatus.sessionExpired
//           )
//       );
//     } catch(e){
//       return emit(
//           state.copyWith(
//               status: FormStatus.failure
//           )
//       );
//     }
//   }
// }


import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/incident_management/models/im_ui_labels.dart';
import 'package:db_atom/src/features/patrolling/models/patrolling_model.dart';
import 'package:db_atom/src/features/patrolling/services/patrolling_service.dart';
part 'training_module_list_event.dart';
part 'training_module_list_state.dart';

class TrainingModuleListBloc
    extends Bloc<TrainingModuleListEvent, TrainingModuleListState> {
  TrainingModuleListBloc(
      ) : super(const TrainingModuleListState(items: [])) {
    on<InitializeValuesTraining>(_initializeValues);
    on<FetchTrainingData>(
      _fetchList,
      transformer: droppable(),
    );
    on<RefreshTrainingList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final PatrollingService _services = PatrollingService();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValuesTraining event, Emitter<TrainingModuleListState> emit) async {


    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
      await UtilsCommon().checkWritePermission(
        moduleCode: Constants.patrollingModule,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.patrollingModule);

      List<Organisation> regions =
      await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
      CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
      await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      // dynamic responseLabels = await commonServices.getUiLabels(
      //     language: await SharedPrefs.getLanguageCode(),
      //     moduleCode: Constants.patrollingModule);

      // IMUiLabels labels = IMUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          regions: regions,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.initial,
          // labels: labels,
          extraProperties: extraProperties,
        ),
      );
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.formError,
        ),
      );
      return;
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }

  FutureOr<void> _refreshList(
      RefreshTrainingList event, Emitter<TrainingModuleListState> emit) async {
    try {
      PatrollingModelResponse response;

      response = await _services.getPatrollingList(
        startPosition: '0',
        maximumRecords: '20',
        // userId: '7',
        filters: BaseFilterModel(),

      );

      return emit(
        state.copyWith(
          items: response.items,
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on Exception catch (e) {
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
  }


  FutureOr<void> _fetchList(
      FetchTrainingData event, Emitter<TrainingModuleListState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      if (state.status == FormStatus.initial || event.newSearch) {
        PatrollingModelResponse response;
        response = await _services.getPatrollingList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          filters: event.filters,
        );

        return emit(
          state.copyWith(
            items: response.items,
            hasReachedMax: false,
            status: FormStatus.success,
          ),
        );
      }

      PatrollingModelResponse response;
      response = await _services.getPatrollingList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        // userId: '7',
        filters: event.filters,
      );

      if (response.items?.isEmpty == true) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      return emit(
        state.copyWith(
          items: List.of(state.items)..addAll(response.items ?? []),
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on TokenExpiredException catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.sessionExpired,
        ),
      );
      return;
    } catch (e) {
      return emit(state.copyWith(status: FormStatus.failure));
    }
  }
}
