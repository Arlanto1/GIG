class TicketingSystemListResponse {
  final List<TicketingSystems>? items;
  final int? totalCount;
  final int? currentPageNo;
  final int? totalPageCount;

  TicketingSystemListResponse({
    this.items,
    this.totalCount,
    this.currentPageNo,
    this.totalPageCount,
  });

  TicketingSystemListResponse.fromJson(Map<String, dynamic> json)
      : items = (json['data'] as List?)?.map((dynamic e) => TicketingSystems.fromJson(e as Map<String,dynamic>)).toList(),
        totalCount = json['totalCount'] as int?,
        currentPageNo = json['currentPageNo'] as int?,
        totalPageCount = json['totalPageCount'] as int?;

  Map<String, dynamic> toJson() => {
    'data' : items?.map((e) => e.toJson()).toList(),
    'totalCount' : totalCount,
    'currentPageNo' : currentPageNo,
    'totalPageCount' : totalPageCount
  };
}

class TicketingSystems {
   int? id;
   String? statusName;
   String? assigneeName;
   String? priorityName;
   String? title;
   String? projectName;

  TicketingSystems({
    this.id,
    this.statusName,
    this.assigneeName,
    this.priorityName,
    this.title,
    this.projectName,
  });

  TicketingSystems.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        statusName = json['statusName'] as String?,
        assigneeName = json['assigneeName'] as String?,
        priorityName = json['priorityName'] as String?,
        title = json['title'] as String?,
        projectName = json['projectName'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'statusName' : statusName,
    'assigneeName' : assigneeName,
    'priorityName' : priorityName,
    'title' : title,
    'projectName' : projectName
  };
}