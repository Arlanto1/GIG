part of 'vvip_visitors_record_bloc.dart';

class VVIPVisitorsRecordState extends Equatable {
  final List<VIVPVisitorRecordModel>? items;
  final bool hasReachedMax;
  final FormStatus status;
  final String? message;
  final SlaUiLabels? labels;

  const VVIPVisitorsRecordState({
    this.message,
    this.items = const <VIVPVisitorRecordModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.labels,
  });

  VVIPVisitorsRecordState copyWith({
    List<VIVPVisitorRecordModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    SlaUiLabels? labels,
  }) {
    return VVIPVisitorsRecordState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      labels: labels ?? this.labels,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
