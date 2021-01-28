class ApplyEntity {
  int id;
  String applicant;
  String position;
  String accompany;
  String reason;
  String fundsFrom;
  String startTime;
  String endTime;
  String departure;
  String destination;
  String transport;
  String transportBeyond;
  String advise;
  String approval;
  int status;
  String applyTime;


  ApplyEntity(
      {this.id,
        this.applicant,
        this.position,
        this.accompany,
        this.reason,
        this.fundsFrom,
        this.startTime,
        this.endTime,
        this.departure,
        this.destination,
        this.transport,
        this.transportBeyond,
        this.advise,
        this.approval,
        this.status,
        this.applyTime}){
  }

  ApplyEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicant = json['applicant'];
    position = json['position'];
    accompany = json['accompany'];
    reason = json['reason'];
    fundsFrom = json['fundsFrom'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    departure = json['departure'];
    destination = json['destination'];
    transport = json['transport'];
    transportBeyond = json['transportBeyond'];
    advise = json['advise'];
    approval = json['approval'];
    status = json['status'];
    applyTime = json['applyTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['applicant'] = this.applicant;
    data['position'] = this.position;
    data['accompany'] = this.accompany;
    data['reason'] = this.reason;
    data['fundsFrom'] = this.fundsFrom;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['departure'] = this.departure;
    data['destination'] = this.destination;
    data['transport'] = this.transport;
    data['transportBeyond'] = this.transportBeyond;
    data['advise'] = this.advise;
    data['approval'] = this.approval;
    data['status'] = this.status;
    data['applyTime'] = this.applyTime;
    return data;
  }
  static List<ApplyEntity> fromJsonList(List list) {
    List<ApplyEntity> res = List();
    list.forEach((element) {res.add(ApplyEntity.fromJson(element));});
    return res;
  }
}