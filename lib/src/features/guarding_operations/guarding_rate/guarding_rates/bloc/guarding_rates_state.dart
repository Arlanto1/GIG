part of 'guarding_rates_bloc.dart';

 class GuardingRatesState extends Equatable {
   final List<GMRate> items;
   final bool hasReachedMax;
   final LawEnforcementListStateType status;

   const GuardingRatesState(
       {this.items = const <GMRate>[],
         this.hasReachedMax = false,
         this.status = LawEnforcementListStateType.initial});

   GuardingRatesState copyWith({
     List<GMRate>? items,
     bool? hasReachedMax,
     LawEnforcementListStateType? status,
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
