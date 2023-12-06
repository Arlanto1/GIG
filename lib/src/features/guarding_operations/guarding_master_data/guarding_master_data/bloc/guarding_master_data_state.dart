part of 'guarding_master_data_bloc.dart';

class GuardingMasterDataState extends Equatable {
  final List<GuardingMastersDataModel> list;
  final bool hasReachedMax;
  final FormStatus status;
  final GmUiLabels? labels;

  const GuardingMasterDataState(
      {this.list = const <GuardingMastersDataModel>[],
        this.hasReachedMax = false,
        this.status = FormStatus.initial,
        this.labels
      });

  GuardingMasterDataState copyWith({
    List<GuardingMastersDataModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
     GmUiLabels? labels,
  }) {
    return GuardingMasterDataState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      labels: labels ?? this.labels
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
