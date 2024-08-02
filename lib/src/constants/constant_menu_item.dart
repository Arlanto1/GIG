import 'package:db_atom/index.dart';

const mainDrawerItems = [
  MenuItem(Constants.dashboard, AppIcon.dashboardselect, 0),
  MenuItem(Constants.securityFunctions, AppIcon.securityFunctionsIcon, 1),
  //  const MenuItem(Constants.administration, AppIcon.maninsuitandtie, 0),
  MenuItem(Constants.updatePassword, AppIcon.settings, 0),
  // MenuItem(Constants.logout, AppIcon.logout, 0),
];
// const securityItems = [
//   MenuItem(Constants.operations, AppIcon.operationsIcon, 1),
//   MenuItem(Constants.costAndBilling, AppIcon.costBillingIcon, 1),
//   MenuItem(Constants.securitySystems, AppIcon.securitySystemIcon, 1),
// ];

// const costAndBillingExpansionTileDrawerItems = [
//   // MenuItem(Constants.attendanceReportBilling, AppIcon.attendanceReportBillingIcon, 0),
//   MenuItem(Constants.guardingRates, AppIcon.guardingRatesIcon, 0),
// ];
// const securitySystemExpansionTileDrawerItems = [
//   MenuItem(Constants.securitySystemTickets, AppIcon.clipboardImage, 1),
// ];

const materialMovementDrawerItems = [
  MenuItem(
      Constants.materialMovementInward, AppIcon.materialMovementInwardIcon, 0),
  MenuItem(Constants.materialMovementOutward,
      AppIcon.materialMovementOutwardIcon, 0),
];

// const securitySystemTicketsItems = [
//   MenuItem(Constants.incident, AppIcon.incidentIcon, 0),
// ];
// const securitySystemTicketsIncidentItems = [
//   MenuItem(Constants.ticketLifeCycle, AppIcon.materialMovementOutwardIcon, 0),
//   MenuItem(Constants.externalVendor, AppIcon.materialMovementOutwardIcon, 0),
// ];

const guardingOperationDrawerItems = [
  MenuItem(Constants.escalationMatrix, AppIcon.escalationMatrixIcon, 0),
  MenuItem(Constants.guardingMasterData, AppIcon.guardingMasterDataIcon, 0),
  MenuItem(Constants.guardingMasterReport, AppIcon.guardingMasterReportIcon, 0),
  // MenuItem(Constants.guardingRate, AppIcon.guardingMasterRatesIcon, 0),
  MenuItem(Constants.shiftOccurrence, AppIcon.shiftOccurrenceIcon, 0),
  MenuItem(
      Constants.slaViolationPenaltyTitle, AppIcon.slaViolationPenaltyIcon, 0),
  //const MenuItem(Constants.femaleDropPickUp, AppIcon.femalePickUpDropIcon, 0),
  // MenuItem(Constants.keyManagementData, AppIcon.keyManagementListIcon, 1),
  // MenuItem(Constants.shiftScheduling, AppIcon.keyManagementListIcon, 1),
];

// const keyManagementDataItems = [
//   MenuItem(Constants.keyManagementMaster, AppIcon.keyManagementDataIcon, 0),
//   MenuItem(
//       Constants.keyManagementIssuance, AppIcon.keyManagementIssuanceIcon, 0),
//   MenuItem(
//       Constants.keyLossDestructionList, AppIcon.keyLossDestructionListIcon, 0),
//   // MenuItem(Constants.keyReconciliationList, AppIcon.guardingMasterRatesIcon, 0),
// ];

// const shiftSchedulingDataItems = [
//   MenuItem(Constants.attendance, AppIcon.attendanceIcon, 0),
//   MenuItem(Constants.dutyPostMaster, AppIcon.dutyPostMasterIcon, 0),
//   MenuItem(Constants.dutyPostNameMaster, AppIcon.dutyPostNameMasterIcon, 0),
//   MenuItem(Constants.shiftSchedule, AppIcon.shiftScheduleIcon, 0),
//   // MenuItem(Constants.attendanceReportBilling, AppIcon.keyManagementListIcon, 0),
// ];

const passTileDrawerItems = [
  MenuItem(
      Constants.dayPassManagement, AppIcon.dayPassManagementRegisterIcon, 0),
  MenuItem(Constants.daypassregister, AppIcon.dayPassManagementRegisterIcon, 0),
  MenuItem(Constants.sezpassmgmt, AppIcon.sezPassManagementRegisterIcon, 0),
  MenuItem(Constants.sezpassregister, AppIcon.sezPassManagementRegisterIcon, 0),
  MenuItem(
      Constants.vendorpassmgmt, AppIcon.vendorPassManagementRegisterIcon, 0),
  MenuItem(Constants.vendorpassregister,
      AppIcon.vendorPassManagementRegisterIcon, 0),
  MenuItem(
      Constants.visitorpassmgmt, AppIcon.visitorPassManagementRegisterIcon, 0),
  MenuItem(Constants.visitorpassregister,
      AppIcon.visitorPassManagementRegisterIcon, 0),
];

const sCRIItems = [
  MenuItem(Constants.vVipVisitorsTitle, AppIcon.incidentIcon, 0),
];
