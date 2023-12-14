part of 'charts_cubit.dart';

class ChartsState extends Equatable {
  final List<PieChartData>? pieCharts;
  final FormStatus? status;
  final String? message;

  factory ChartsState.initial({
    required List<PieChartData> pieCharts,
    required String errorMessage,
  }) {
    return ChartsState(
      pieCharts: pieCharts,
      message: errorMessage,
    );
  }



  @override
  List<Object?> get props => [pieCharts];


  const ChartsState( {
    this.status,
    this.pieCharts,
    this.message,
  });

  ChartsState copyWith({
    List<PieChartData>? pieCharts,
    String? message,
    FormStatus? status,
  }) {
    return ChartsState(
      pieCharts: pieCharts ?? this.pieCharts,
      message: message ?? this.message,
      status: status?? this.status,
    );
  }
}
