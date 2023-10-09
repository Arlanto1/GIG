part of 'guarding_rates_bloc.dart';

 class GuardingRatesState extends Equatable {
   final List<GMRate> items;
   final bool hasReachedMax;
   final FormStatus status;

   const GuardingRatesState(
       {this.items = const <GMRate>[],
         this.hasReachedMax = false,
         this.status = FormStatus.initial});

   GuardingRatesState copyWith({
     List<GMRate>? items,
     bool? hasReachedMax,
     FormStatus? status,
   }) {
     return GuardingRatesState(
       items: items ?? this.items,
       hasReachedMax: hasReachedMax ?? this.hasReachedMax,
       status: status ?? this.status,
     );
   }

   @override
   List<Object?> get props => [items, hasReachedMax, status];
}
