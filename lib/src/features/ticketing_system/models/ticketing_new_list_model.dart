class TicketingNewListModelResponse {
  TicketingNewListModelResponse({
     this.items,
     this.totalCount,
     this.currentPageNo,
     this.totalPageCount,
  });
   List<TicketingNewListModel>? items;
   int? totalCount;
   int? currentPageNo;
   int? totalPageCount;

  TicketingNewListModelResponse.fromJson(Map<String, dynamic> json){
    items = List.from(json['data']).map((e)=>TicketingNewListModel.fromJson(e)).toList();
    totalCount = json['totalCount'];
    currentPageNo = json['currentPageNo'];
    totalPageCount = json['totalPageCount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = items?.map((e)=>e.toJson()).toList();
    _data['totalCount'] = totalCount;
    _data['currentPageNo'] = currentPageNo;
    _data['totalPageCount'] = totalPageCount;
    return _data;
  }
}

class TicketingNewListModel {
  TicketingNewListModel({
     this.id,
     this.status,
     this.statusName,
     this.assigneeName,
     this.priorityId,
     this.priorityName,
     this.title,
     this.projectName,
     this.projectId,
     this.assigneeId,
     this.tracker,
     this.createdBy,
     this.startDate,
     this.overdue,
  });
   int? id;
   int? status;
   String? statusName;
   String? assigneeName;
   int? priorityId;
   String? priorityName;
   String? title;
   String? projectName;
   int? projectId;
   int? assigneeId;
   Tracker? tracker;
   String? createdBy;
   int? startDate;
   bool? overdue;

  TicketingNewListModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    status = json['status'];
    statusName = json['statusName'];
    assigneeName = json['assigneeName'];
    priorityId = json['priorityId'];
    priorityName = json['priorityName'];
    title = json['title'];
    projectName = json['projectName'];
    projectId = json['projectId'];
    assigneeId = json['assigneeId'];
    tracker = Tracker.fromJson(json['tracker']);
    createdBy = json['createdBy'];
    startDate = json['startDate'];
    overdue = json['overdue'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['status'] = status;
    _data['statusName'] = statusName;
    _data['assigneeName'] = assigneeName;
    _data['priorityId'] = priorityId;
    _data['priorityName'] = priorityName;
    _data['title'] = title;
    _data['projectName'] = projectName;
    _data['projectId'] = projectId;
    _data['assigneeId'] = assigneeId;
    _data['tracker'] = tracker?.toJson();
    _data['createdBy'] = createdBy;
    _data['startDate'] = startDate;
    _data['overdue'] = overdue;
    return _data;
  }
}

class Tracker {
  Tracker({
     this.id,
     this.name,
  });
   int? id;
   String? name;

  Tracker.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}