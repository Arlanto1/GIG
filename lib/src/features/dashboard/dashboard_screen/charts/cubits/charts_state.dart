part of 'charts_cubit.dart';

class ChartsState extends Equatable {
  final List<PieChartData>? lawEnforcementVisitByEntity;
  final List<PieChartData>? lawEnforcementVisitByRegion;
  final List<PieChartData>? eventProtectionByRegion;
  final int? notificationCount;
  final DisplayMenu? displayMenu;
  final FormStatus? status;
  final String? message;

  factory ChartsState.initial({
    required List<PieChartData> lawEnforcementVisitByEntity,
    required List<PieChartData> lawEnforcementVisitByRegion,
    required List<PieChartData> eventProtectionByRegion,
    required String errorMessage,
    required int notificationCount,
  }) {
    return ChartsState(
      lawEnforcementVisitByEntity: lawEnforcementVisitByEntity,
      lawEnforcementVisitByRegion: lawEnforcementVisitByRegion,
      eventProtectionByRegion: eventProtectionByRegion,
      message: errorMessage,
      notificationCount: notificationCount,
    );
  }

  @override
  List<Object?> get props => [lawEnforcementVisitByEntity];

  const ChartsState({
    this.status,
    this.lawEnforcementVisitByEntity,
    this.lawEnforcementVisitByRegion,
    this.eventProtectionByRegion,
    this.displayMenu,
    this.message,
    this.notificationCount,
  });

  ChartsState copyWith({
    List<PieChartData>? lawEnforcementVisitByEntity,
    List<PieChartData>? lawEnforcementVisitByRegion,
    List<PieChartData>? eventProtectionByRegion,
    String? message,
    DisplayMenu? displayMenu,
    int? notificationCount,
    FormStatus? status,
  }) {
    return ChartsState(
      lawEnforcementVisitByEntity:
          lawEnforcementVisitByEntity ?? this.lawEnforcementVisitByEntity,
      lawEnforcementVisitByRegion:
          lawEnforcementVisitByRegion ?? this.lawEnforcementVisitByRegion,
      eventProtectionByRegion:
          eventProtectionByRegion ?? this.eventProtectionByRegion,
      message: message ?? this.message,
      status: status ?? this.status,
      notificationCount: notificationCount ?? this.notificationCount,
      displayMenu: displayMenu ?? this.displayMenu,
    );
  }
}
