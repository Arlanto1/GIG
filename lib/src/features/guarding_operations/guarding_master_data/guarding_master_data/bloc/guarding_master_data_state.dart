part of 'guarding_master_data_bloc.dart';

class GuardingMasterDataState extends Equatable {
  final List<GuardingMastersDataModel> list;
  final bool hasReachedMax;
  final FormStatus status;
  final String? message;

  const GuardingMasterDataState({
    this.list = const <GuardingMastersDataModel>[],
    this.hasReachedMax = false,
    this.message,
    this.status = FormStatus.initial,
  });

  GuardingMasterDataState copyWith({
    List<GuardingMastersDataModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
  }) {
    return GuardingMasterDataState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
