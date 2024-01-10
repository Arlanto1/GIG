part of 'guarding_master_data_bloc.dart';

abstract class GuardingMasterDataEvent extends Equatable {
  const GuardingMasterDataEvent();

  @override
  List<Object?> get props => [];
}

class FetchDataList extends GuardingMasterDataEvent {
  final int startPos;
  final int maxPos;

  const FetchDataList({required this.startPos, required this.maxPos});
}
class InitializeValues extends GuardingMasterDataEvent {
  const InitializeValues();
}