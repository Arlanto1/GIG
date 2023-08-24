part of 'guarding_master_data_bloc.dart';

class GuardingMasterDataState extends Equatable {
  final List<GuardingMastersDataModel> list;
  final bool hasReachedMax;
  final LawEnforcementListStateType status;

  const GuardingMasterDataState(
      {this.list = const <GuardingMastersDataModel>[],
        this.hasReachedMax = false,
        this.status = LawEnforcementListStateType.initial});

  GuardingMasterDataState copyWith({
    List<GuardingMastersDataModel>? items,
    bool? hasReachedMax,
    LawEnforcementListStateType? status,
  }) {
    return GuardingMasterDataState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
