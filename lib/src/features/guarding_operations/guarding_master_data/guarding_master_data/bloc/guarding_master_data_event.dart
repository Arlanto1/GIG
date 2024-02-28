part of 'guarding_master_data_bloc.dart';

abstract class GuardingMasterDataEvent extends Equatable {
  const GuardingMasterDataEvent();

  @override
  List<Object?> get props => [];
}

class FetchDataList extends GuardingMasterDataEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchDataList(
      {required this.startPos,
      required this.maxPos,
      required this.newSearch,
      required this.filters});
}

class InitializeValuesGMD extends GuardingMasterDataEvent {
  const InitializeValuesGMD();
}

class RefreshLists extends GuardingMasterDataEvent {
  const RefreshLists();
}
