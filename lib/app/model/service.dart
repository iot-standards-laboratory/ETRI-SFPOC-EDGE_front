class Service {
  final String? name, id, cid;
  final int? numOfCtrls;
  final String? status;

  Service({this.name, this.id, this.cid, this.numOfCtrls, this.status});

  factory Service.fromJson(dynamic json) {
    return Service(
      name: json['name'],
      id: json['id'],
      cid: json['cid'],
      numOfCtrls: json['num_clnts'],
      status: json['status'],
    );
  }
}
