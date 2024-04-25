part of 'vvip_visitors_record_bloc.dart';

class VVIPVisitorsRecordState extends Equatable {
  final List<VIVPVisitorRecordModel>? items;
  final bool hasReachedMax;
  final FormStatus status;
  final String? message;
  final SlaUiLabels? labels;
  final ExtraProperties? extraProperties;

  const VVIPVisitorsRecordState({
    this.message,
    this.items = const <VIVPVisitorRecordModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.labels,
    this.extraProperties,
  });

  VVIPVisitorsRecordState copyWith({
    List<VIVPVisitorRecordModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    SlaUiLabels? labels,
    ExtraProperties? extraProperties,
  }) {
    return VVIPVisitorsRecordState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      labels: labels ?? this.labels,
      extraProperties: extraProperties ?? this.extraProperties,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
