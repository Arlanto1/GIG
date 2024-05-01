import 'package:db_atom/index.dart';

class BudgetCostRequest {
  BudgetCostModel? apsBudget;

  BudgetCostRequest({
    this.apsBudget,
  });

  BudgetCostRequest.fromJson(Map<String, dynamic> json)
      : apsBudget = (json['apsBudget'] as Map<String, dynamic>?) != null
            ? BudgetCostModel.fromJson(
                json['apsBudget'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'apsBudget': apsBudget?.toJson()};
}
