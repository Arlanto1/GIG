part of 'guarding_rate_bloc.dart';

 class GuardingRateState extends Equatable {
   final List<GMRate> items;
   final bool hasReachedMax;
   final LawEnforcementListStateType status;

   const GuardingRateState(
       {this.items = const <GMRate>[],
         this.hasReachedMax = false,
         this.status = LawEnforcementListStateType.initial});

   GuardingRateState copyWith({
     List<GMRate>? items,
     bool? hasReachedMax,
     LawEnforcementListStateType? status,
   }) {
     return GuardingRateState(
       items: items ?? this.items,
       hasReachedMax: hasReachedMax ?? this.hasReachedMax,
       status: status ?? this.status,
     );
   }

   @override
   List<Object?> get props => [items, hasReachedMax, status];
}
