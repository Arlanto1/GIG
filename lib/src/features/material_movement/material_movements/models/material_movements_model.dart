class MaterialMovementsModel {
  List<MaterialMovementModel>? items;
  int? totalCount;
  int? currentPageNo;
  int? totalPageCount;

  MaterialMovementsModel({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  MaterialMovementsModel.fromJson(Map<String, dynamic> json)
      : items = (json['list'] as List?)?.map((dynamic e) => MaterialMovementModel.fromJson(e as Map<String,dynamic>)).toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'list' : items?.map((e) => e.toJson()).toList(),
    'totalCount' : totalCount,
    'currentPageNo' : currentPageNo,
    'totalPageCount' : totalPageCount
  };
}

class MaterialMovementModel {
  int? id;
  String? slNo;
  String? inputDate;
  Location? location;
  LocationRegion? locationRegion;
  List<dynamic>? entities;
  bool? inwardMovement;
  bool? returnable;
  String? challanNo;
  String? materialComingFrom;
  String? materialFromAddress;
  String? materialDescription;
  int? quantity;
  List<dynamic>? images;
  String? receiverEmail;
  String? receiverEmployeeId;
  EntrySecurity? entrySecurity;
  int? status;
  String? modifiedBy;
  List<History>? history;
  String? requestorEmail;
  String? requestorEmployeeId;
  RequestorDepartment? requestorDepartment;
  String? sentTo;
  String? address;
  String? purpose;
  String? modelInfo;
  Unit? unit;
  String? preparedBy;
  PreparedByDepartment? preparedByDepartment;
  String? approver1Email;
  Approver1Department? approver1Department;
  String? approver2Email;
  Approver2Department? approver2Department;
  String? takenOutEmail;
  String? takenOutContactNo;
  String? materialReturnedChallanNo;
  String? returnReceiverMailId;
   String? poNumber;
  bool? originalReceiver;
  String? otherReceiverName;
  String? otherReceiverEmployeeId;
  bool? materialPhysicallyChecked;
  String? materialNotCheckedComment;
  String? takenOutAddress;
  String? entrySecurityName;
  String? receiverDepartmenttName;

  MaterialMovementModel({
    this.id,
    this.slNo,
    this.inputDate,
    this.location,
    this.locationRegion,
    this.entities,
    this.inwardMovement,
    this.returnable,
    this.challanNo,
    this.materialComingFrom,
    this.materialFromAddress,
    this.materialDescription,
    this.quantity,
    this.images,
    this.receiverEmail,
    this.receiverEmployeeId,
    this.entrySecurity,
    this.status,
    this.modifiedBy,
    this.history,
    this.requestorEmail,
    this.requestorEmployeeId,
    this.requestorDepartment,
    this.sentTo,
    this.address,
    this.purpose,
    this.modelInfo,
    this.unit,
    this.preparedBy,
    this.preparedByDepartment,
    this.approver1Email,
    this.approver1Department,
    this.approver2Email,
    this.approver2Department,
    this.takenOutEmail,
    this.takenOutContactNo,
    this.materialReturnedChallanNo,
    this.returnReceiverMailId,
    this.poNumber,
    this.originalReceiver = false,
    this.otherReceiverName,
    this.otherReceiverEmployeeId,
    this.materialPhysicallyChecked,
    this.materialNotCheckedComment,
    this.takenOutAddress,
    this.entrySecurityName,
    this.receiverDepartmenttName,
  });

  MaterialMovementModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slNo = json['slNo'] as String?,
        inputDate = json['inputDate'] as String?,
        location = (json['location'] as Map<String,dynamic>?) != null ? Location.fromJson(json['location'] as Map<String,dynamic>) : null,
        locationRegion = (json['locationRegion'] as Map<String,dynamic>?) != null ? LocationRegion.fromJson(json['locationRegion'] as Map<String,dynamic>) : null,
        entities = json['entities'] as List?,
        inwardMovement = json['inwardMovement'] as bool?,
        returnable = json['returnable'] as bool?,
        challanNo = json['challanNo'] as String?,
        materialComingFrom = json['materialComingFrom'] as String?,
        materialFromAddress = json['materialFromAddress'] as String?,
        materialDescription = json['materialDescription'] as String?,
        quantity = json['quantity'] as int?,
        images = json['images'] as List?,
        receiverEmail = json['receiverEmail'] as String?,
        receiverEmployeeId = json['receiverEmployeeId'] as String?,
        entrySecurity = (json['entrySecurity'] as Map<String,dynamic>?) != null ? EntrySecurity.fromJson(json['entrySecurity'] as Map<String,dynamic>) : null,
        status = json['status'] as int?,
        modifiedBy = json['modifiedBy'] as String?,
        history = (json['history'] as List?)?.map((dynamic e) => History.fromJson(e as Map<String,dynamic>)).toList(),
        requestorEmail = json['requestorEmail'] as String?,
        requestorEmployeeId = json['requestorEmployeeId'] as String?,
        requestorDepartment = (json['requestorDepartment'] as Map<String,dynamic>?) != null ? RequestorDepartment.fromJson(json['requestorDepartment'] as Map<String,dynamic>) : null,
        sentTo = json['sentTo'] as String?,
        address = json['address'] as String?,
        purpose = json['purpose'] as String?,
        modelInfo = json['modelInfo'] as String?,
        unit = (json['unit'] as Map<String,dynamic>?) != null ? Unit.fromJson(json['unit'] as Map<String,dynamic>) : null,
        preparedBy = json['preparedBy'] as String?,
        preparedByDepartment = (json['preparedByDepartment'] as Map<String,dynamic>?) != null ? PreparedByDepartment.fromJson(json['preparedByDepartment'] as Map<String,dynamic>) : null,
        approver1Email = json['approver1Email'] as String?,
        approver1Department = (json['approver1Department'] as Map<String,dynamic>?) != null ? Approver1Department.fromJson(json['approver1Department'] as Map<String,dynamic>) : null,
        approver2Email = json['approver2Email'] as String?,
        approver2Department = (json['approver2Department'] as Map<String,dynamic>?) != null ? Approver2Department.fromJson(json['approver2Department'] as Map<String,dynamic>) : null,
        takenOutEmail = json['takenOutEmail'] as String?,
        takenOutContactNo = json['takenOutContactNo'] as String?,
        materialReturnedChallanNo = json['materialReturnedChallanNo'] as String?,
        returnReceiverMailId = json['returnReceiverMailId'] as String?,
        poNumber = json['poNumber'] as String?,
        originalReceiver = json['originalReceiver'] as bool?,
        otherReceiverName = json['otherReceiverName'] as String?,
        otherReceiverEmployeeId = json['otherReceiverEmployeeId'] as String?,
        materialPhysicallyChecked = json['materialPhysicallyChecked'] as bool?,
        materialNotCheckedComment = json['materialNotCheckedComment'] as String?,
        takenOutAddress = json['takenOutAddress'] as String?,
        entrySecurityName = json['entrySecurityName'] as String?,
        receiverDepartmenttName = json['receiverDepartmenttName'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'slNo' : slNo,
    'inputDate' : inputDate,
    'location' : location?.toJson(),
    'locationRegion' : locationRegion?.toJson(),
    'entities' : entities,
    'inwardMovement' : inwardMovement,
    'returnable' : returnable,
    'challanNo' : challanNo,
    'materialComingFrom' : materialComingFrom,
    'materialFromAddress' : materialFromAddress,
    'materialDescription' : materialDescription,
    'quantity' : quantity,
    'images' : images,
    'receiverEmail' : receiverEmail,
    'receiverEmployeeId' : receiverEmployeeId,
    'entrySecurity' : entrySecurity?.toJson(),
    'status' : status,
    'modifiedBy' : modifiedBy,
    'history' : history?.map((e) => e.toJson()).toList(),
    'requestorEmail' : requestorEmail,
    'requestorEmployeeId' : requestorEmployeeId,
    'requestorDepartment' : requestorDepartment?.toJson(),
    'sentTo' : sentTo,
    'address' : address,
    'purpose' : purpose,
    'modelInfo' : modelInfo,
    'unit' : unit?.toJson(),
    'preparedBy' : preparedBy,
    'preparedByDepartment' : preparedByDepartment?.toJson(),
    'approver1Email' : approver1Email,
    'approver1Department' : approver1Department?.toJson(),
    'approver2Email' : approver2Email,
    'approver2Department' : approver2Department?.toJson(),
    'takenOutEmail' : takenOutEmail,
    'takenOutContactNo' : takenOutContactNo,
    'materialReturnedChallanNo' : materialReturnedChallanNo,
    'returnReceiverMailId' : returnReceiverMailId,
    'poNumber' : poNumber,
    'originalReceiver' : originalReceiver,
    'otherReceiverName' : otherReceiverName,
    'otherReceiverEmployeeId' : otherReceiverEmployeeId,
    'materialPhysicallyChecked' : materialPhysicallyChecked,
    'materialNotCheckedComment' : materialNotCheckedComment,
    'takenOutAddress' : takenOutAddress,
    'entrySecurityName' : entrySecurityName,
    'receiverDepartmenttName' : receiverDepartmenttName
  };
}

class Location {
  int? id;
  String? name;

  Location({
    this.id,
    this.name,
  });

  Location.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name
  };
}

class LocationRegion {
  int? id;
  String? name;

  LocationRegion({
    this.id,
    this.name,
  });

  LocationRegion.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name
  };
}

class EntrySecurity {
  int? userId;
  String? userName;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  List<Roles>? roles;
  List<RoleExtensions>? roleExtensions;
  List<dynamic>? notApprovedRoles;
  List<dynamic>? notApprovedRoleExtensions;
  String? name;
  String? userStatus;

  EntrySecurity({
    this.userId,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.roles,
    this.roleExtensions,
    this.notApprovedRoles,
    this.notApprovedRoleExtensions,
    this.name,
    this.userStatus,
  });

  EntrySecurity.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int?,
        userName = json['userName'] as String?,
        email = json['email'] as String?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?,
        phone = json['phone'] as String?,
        roles = (json['roles'] as List?)?.map((dynamic e) => Roles.fromJson(e as Map<String,dynamic>)).toList(),
        roleExtensions = (json['roleExtensions'] as List?)?.map((dynamic e) => RoleExtensions.fromJson(e as Map<String,dynamic>)).toList(),
        notApprovedRoles = json['notApprovedRoles'] as List?,
        notApprovedRoleExtensions = json['notApprovedRoleExtensions'] as List?,
        name = json['name'] as String?,
        userStatus = json['userStatus'] as String?;

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'userName' : userName,
    'email' : email,
    'firstName' : firstName,
    'lastName' : lastName,
    'phone' : phone,
    'roles' : roles?.map((e) => e.toJson()).toList(),
    'roleExtensions' : roleExtensions?.map((e) => e.toJson()).toList(),
    'notApprovedRoles' : notApprovedRoles,
    'notApprovedRoleExtensions' : notApprovedRoleExtensions,
    'name' : name,
    'userStatus' : userStatus
  };
}

class Roles {
  int? roleId;
  String? application;
  String? roleName;
  List<RoleExtensions>? roleExtensions;
  String? name;

  Roles({
    this.roleId,
    this.application,
    this.roleName,
    this.roleExtensions,
    this.name,
  });

  Roles.fromJson(Map<String, dynamic> json)
      : roleId = json['roleId'] as int?,
        application = json['application'] as String?,
        roleName = json['roleName'] as String?,
        roleExtensions = (json['roleExtensions'] as List?)?.map((dynamic e) => RoleExtensions.fromJson(e as Map<String,dynamic>)).toList(),
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'roleId' : roleId,
    'application' : application,
    'roleName' : roleName,
    'roleExtensions' : roleExtensions?.map((e) => e.toJson()).toList(),
    'name' : name
  };
}

class RoleExtensions {
  int? roleExtensionId;
  int? roleId;
  String? displayName;
  String? area;
  String? filter;
  dynamic rootNodeId;
  dynamic nodeId;
  dynamic accessRight;

  RoleExtensions({
    this.roleExtensionId,
    this.roleId,
    this.displayName,
    this.area,
    this.filter,
    this.rootNodeId,
    this.nodeId,
    this.accessRight,
  });

  RoleExtensions.fromJson(Map<String, dynamic> json)
      : roleExtensionId = json['roleExtensionId'] as int?,
        roleId = json['roleId'] as int?,
        displayName = json['displayName'] as String?,
        area = json['area'] as String?,
        filter = json['filter'] as String?,
        rootNodeId = json['rootNodeId'],
        nodeId = json['nodeId'],
        accessRight = json['accessRight'];

  Map<String, dynamic> toJson() => {
    'roleExtensionId' : roleExtensionId,
    'roleId' : roleId,
    'displayName' : displayName,
    'area' : area,
    'filter' : filter,
    'rootNodeId' : rootNodeId,
    'nodeId' : nodeId,
    'accessRight' : accessRight
  };
}


class History {
  int? id;
  int? state;
  int? action;
  String? email;
  int? actiontime;
  String? parameters;

  History({
    this.id,
    this.state,
    this.action,
    this.email,
    this.actiontime,
    this.parameters,
  });

  History.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        state = json['state'] as int?,
        action = json['action'] as int?,
        email = json['email'] as String?,
        actiontime = json['actiontime'] as int?,
        parameters = json['parameters'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'state' : state,
    'action' : action,
    'email' : email,
    'actiontime' : actiontime,
    'parameters' : parameters
  };
}

class RequestorDepartment {
  int? id;
  String? name;

  RequestorDepartment({
    this.id,
    this.name,
  });

  RequestorDepartment.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name
  };
}

class Unit {
  int? id;
  String? name;

  Unit({
    this.id,
    this.name,
  });

  Unit.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name
  };
}

class PreparedByDepartment {
  int? id;
  String? name;

  PreparedByDepartment({
    this.id,
    this.name,
  });

  PreparedByDepartment.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name
  };
}

class Approver1Department {
  int? id;
  String? name;

  Approver1Department({
    this.id,
    this.name,
  });

  Approver1Department.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name
  };
}

class Approver2Department {
  int? id;
  String? name;

  Approver2Department({
    this.id,
    this.name,
  });

  Approver2Department.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name
  };
}