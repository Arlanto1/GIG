import 'dart:async';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found/models/article_found_model.dart';
import 'package:db_atom/src/features/article_found/services/article_found_service.dart';
part 'article_found_list_event.dart';
part 'article_found_list_state.dart';

class ArticleFoundBloc extends Bloc<ArticleFoundEvent, ArticleFoundState>{
  ArticleFoundBloc(): super(const ArticleFoundState(items: [])){
      on<InitializeValuesAF>(_initializeValues);
      on<RefreshList>(_refreshList);
      on<FetchArticleData>(_fetchArticleList);
  }

  ArticleFoundServices services = ArticleFoundServices();
  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(InitializeValuesAF event,Emitter<ArticleFoundState> emit) async {
     try {
       emit(state.copyWith
         (status: FormStatus.loading));

       ExtraProperties extraProperties =
       await UtilsCommon().checkWritePermission(
         moduleCode: Constants.materialMovementModuleCode,
         commonServices: commonServices,
       );

       List<Organisation> statuses = await commonServices.getStatusesByModuleId(
           module: Constants.materialMovementModuleCode);

       List<Organisation> regions =
       await commonServices.getRegionsOrLocationsByRegionId();

       CommonFilters commonFilters =
       CommonFilters(regions: regions, statuses: statuses);

       Locations locations =
       await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

       // dynamic responseLabels = await commonServices.getUiLabels(
       //     language: await SharedPrefs.getLanguageCode(),
       //     moduleCode: Constants.articleFoundModuleCode);

       return emit(
       state.copyWith(
         location: locations,
         extraProperties: extraProperties,
         // labels: responseLabels,
         commonFilters: commonFilters,
       )
       );
     }on GenericResponse catch (e){
       emit(state.copyWith(
         message: e.message,
         status: FormStatus.formError
       )
       );
       return;
     }
     on Exception catch(e){
       return UtilsCommon().exceptionHandling(e, emit, state);
     }
  }


  FutureOr<void> _refreshList(
      RefreshList event, Emitter<ArticleFoundState> emit) async {
    try {
      final ArticleFoundResponseModel response = await services
          .getListWithFilters(
          startPosition: '0',
          maximumRecords: '20',
          filters: BaseFilterModel()
      );
      return emit(
        state.copyWith(
          items: response.list,
          hasReachedMax: false,
          status: FormStatus.success,
        ),
      );
    } on Exception catch(e){
      return UtilsCommon().exceptionHandling(e, emit, state);
    }
}

 Future<void> _fetchArticleList(FetchArticleData event, Emitter<ArticleFoundState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading
      )
    );

    try{
      if(state.status == FormStatus.initial || event.newSearch) {
        ArticleFoundResponseModel response = await services.getListWithFilters(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          filters: event.filters,
        );
        emit(
          state.copyWith(
            items: response.list,
            status: FormStatus.success,
            hasReachedMax: false,
          )
        );
      }
      ArticleFoundResponseModel response = await services.getListWithFilters(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        filters: event.filters,
      );

      if (response.list?.isEmpty == true) {
        return emit(
          state.copyWith(
            hasReachedMax: true,
            status: FormStatus.success,
          )
        );
      }
        return emit(state.copyWith(
        items: List.of(state.items)..addAll(response.list ?? []),
        hasReachedMax: false,
        status: FormStatus.success
      ));
    }on TokenExpiredException catch(e){
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.sessionExpired
        )
      );
    } catch(e){
      return emit(
        state.copyWith(
          status: FormStatus.failure
        )
      );
    }
 }
}