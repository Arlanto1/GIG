import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/services/foundlist_services.dart';

part 'article_found_event.dart';
part 'article_found_state.dart';

class ArticleFoundBloc extends Bloc<ArticleFoundStateEvent, ArticleFoundState> {
  ArticleFoundBloc() : super(const ArticleFoundState()) {
    on<InitializeValuesAF>(_initializeValues);
    on<FetchData>(
      _fetchArticleFound,
      transformer: droppable(),
    );
    on<RefreshList>(
      _refreshList,
      transformer: droppable(),
    );
  }

  final FoundListServices services = FoundListServices();

  final CommonServices commonServices = CommonServices();

  FutureOr<void> _initializeValues(
      InitializeValuesAF event, Emitter<ArticleFoundState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));

      ExtraProperties extraProperties =
          await UtilsCommon().checkWritePermission(
        moduleCode: Constants.articleFoundModuleCode,
        commonServices: commonServices,
      );

      List<Organisation> statuses = await commonServices.getStatusesByModuleId(
          module: Constants.articleFoundModuleCode);

      List<Organisation> regions =
          await commonServices.getRegionsOrLocationsByRegionId();

      CommonFilters commonFilters =
          CommonFilters(regions: regions, statuses: statuses);

      Locations locations =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      dynamic responseLabels = await commonServices.getUiLabels(
          language: await SharedPrefs.getLanguageCode(),
          moduleCode: Constants.articleFoundModuleCode);

      AFUiLabels labels = AFUiLabels.fromJson(responseLabels);
      return emit(
        state.copyWith(
          locations: locations,
          regions: regions,
          statuses: statuses,
          commonFilters: commonFilters,
          hasReachedMax: false,
          status: FormStatus.initial,
          labels: labels,
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
      RefreshList event, Emitter<ArticleFoundState> emit) async {
    try {
      FoundListModel response;

      response = await services.getFoundArticleList(
        startPosition: '0',
        maximumRecords: '20',
        eventId: event.eventId,
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

  FutureOr<void> _fetchArticleFound(
      FetchData event, Emitter<ArticleFoundState> emit) async {
    log('-_fetchArticleFound-${state.status}-');

    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    try {
      // if (state.hasReachedMax) return;
      log('-_fetchArticleFound-222---${state.status}-');

      if (state.status == FormStatus.initial || event.newSearch) {
        FoundListModel response;

        response = await services.getFoundArticleList(
          startPosition: '${event.startPos}',
          maximumRecords: '${event.maxPos}',
          eventId: event.eventId,
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

      log('-_fetchArticleFound--${event.eventId}-event.eventId---##--');
      FoundListModel response;
      response = await services.getFoundArticleList(
        startPosition: '${event.startPos}',
        maximumRecords: '${event.maxPos}',
        eventId: event.eventId,
        filters: event.filters,
      );

      if (response.items?.isEmpty == true) {
        return emit(
            state.copyWith(hasReachedMax: true, status: FormStatus.success));
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
