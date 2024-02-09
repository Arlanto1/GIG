class BudgetCostModel {
  final int? vendorId;
  final int? soCount;
  final int? soHours;
  final int? ssCount;
  final int? ssHours;
  final int? sgCount;
  final int? sgHours;
  final int? sfCount;
  final int? sfHours;
  final double? budgetCost;
  final int? locationId;

  BudgetCostModel({
    this.vendorId,
    this.soCount,
    this.soHours,
    this.ssCount,
    this.ssHours,
    this.sgCount,
    this.sgHours,
    this.sfCount,
    this.sfHours,
    this.budgetCost,
    this.locationId,
  });

  BudgetCostModel.fromJson(Map<String, dynamic> json)
      : vendorId = json['vendorId'] as int?,
        soCount = json['soCount'] as int?,
        soHours = json['soHours'] as int?,
        ssCount = json['ssCount'] as int?,
        ssHours = json['ssHours'] as int?,
        sgCount = json['sgCount'] as int?,
        sgHours = json['sgHours'] as int?,
        sfCount = json['sfCount'] as int?,
        sfHours = json['sfHours'] as int?,
        budgetCost = json['budgetCost'] as double?,
        locationId = json['locationId'] as int?;

  Map<String, dynamic> toJson() => {
    'vendorId' : vendorId,
    'soCount' : soCount,
    'soHours' : soHours,
    'ssCount' : ssCount,
    'ssHours' : ssHours,
    'sgCount' : sgCount,
    'sgHours' : sgHours,
    'sfCount' : sfCount,
    'sfHours' : sfHours,
    'budgetCost' : budgetCost,
    'locationId' : locationId
  };
}