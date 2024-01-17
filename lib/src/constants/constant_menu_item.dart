import 'package:db_atom/index.dart';

const mainDrawerItems = [
  MenuItem(Constants.dashboard, AppIcon.dashboardselect, 0),
  MenuItem(Constants.securityFunctions, AppIcon.securityprotection, 1),
  //  const MenuItem(Constants.administration, AppIcon.maninsuitandtie, 0),
  //const MenuItem(Constants.settings, AppIcon.settings, 0),
  MenuItem(Constants.logout, AppIcon.logout, 0),
];
const securityItems = [
  MenuItem(Constants.operations, AppIcon.operatingsystem, 1),
  MenuItem(Constants.securitySystems, AppIcon.operatingsystem, 1),
];

const securitySystemExpansionTileDrawerItems = [
  MenuItem(Constants.securitySystemTickets, AppIcon.clipboardImage, 1),
];

const materialMovementDrawerItems = [
  MenuItem(
      Constants.materialMovementInward, AppIcon.materialMovementInwardIcon, 0),
  MenuItem(Constants.materialMovementOutward,
      AppIcon.materialMovementOutwardIcon, 0),
];

const securitySystemTicketsItems = [
  MenuItem(Constants.incident, AppIcon.materialMovementOutwardIcon, 1),
];
const securitySystemTicketsIncidentItems = [
  MenuItem(Constants.ticketLifeCycle, AppIcon.materialMovementOutwardIcon, 0),
  MenuItem(Constants.externalVendor, AppIcon.materialMovementOutwardIcon, 0),
];

const guardingOperationDrawerItems = [
  MenuItem(Constants.guardingMasterData, AppIcon.guardingMasterDataIcon, 0),
  MenuItem(Constants.guardingMasterReport, AppIcon.guardingMasterReportIcon, 0),
  MenuItem(Constants.guardingRate, AppIcon.guardingMasterRatesIcon, 0),
  //const MenuItem(Constants.femaleDropPickUp, AppIcon.femalePickUpDropIcon, 0),
  MenuItem(Constants.keyManagementData, AppIcon.keyManagementListIcon, 1),
  MenuItem(Constants.shiftSchedule, AppIcon.keyManagementListIcon, 1),
  MenuItem(Constants.occurrence, AppIcon.occurence, 0),
  MenuItem(Constants.slaViolationPenalty, AppIcon.occurence, 0),
  MenuItem(Constants.contactDetails, AppIcon.guardingMasterRatesIcon, 0),
];

const keyManagementDataItems = [
  MenuItem(Constants.keyManagementMaster, AppIcon.guardingMasterDataIcon, 0),
  MenuItem(
      Constants.keyManagementIssuance, AppIcon.guardingMasterReportIcon, 0),
  MenuItem(Constants.keyReconciliationList, AppIcon.guardingMasterRatesIcon, 0),
  MenuItem(Constants.keyLossDestructionList, AppIcon.femalePickUpDropIcon, 0),
];

const shiftSchedulingDataItems = [
  MenuItem(Constants.dutyPostMaster, AppIcon.keyManagementListIcon, 0),
  MenuItem(Constants.dutyPostNameMaster, AppIcon.keyManagementListIcon, 0),
  MenuItem(Constants.attendance, AppIcon.keyManagementListIcon, 0),
  MenuItem(Constants.shiftScheduling, AppIcon.keyManagementListIcon, 0),
];

const passTileDrawerItems = [
  MenuItem(Constants.daypassmgmt, AppIcon.daypassmgmticon, 0),
  MenuItem(Constants.daypassregister, AppIcon.daypassregicon, 0),
  MenuItem(Constants.visitorpassmgmt, AppIcon.visitorpassmgmticon, 0),
  MenuItem(Constants.visitorpassregister, AppIcon.visitorpassregicon, 0),
  MenuItem(Constants.vendorpassmgmt, AppIcon.vendorpassmgmticon, 0),
  MenuItem(Constants.vendorpassregister, AppIcon.vendorpassregicon, 0),
  MenuItem(Constants.sezpassmgmt, AppIcon.sezpassmgmticon, 0),
  MenuItem(Constants.sezpassregister, AppIcon.segpassregicon, 0),
];
