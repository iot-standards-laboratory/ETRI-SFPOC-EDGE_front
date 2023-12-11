class Service {
  final String? name, id, cid;
  final String? status;

  Service({this.name, this.id, this.cid, this.status});

  factory Service.fromJson(dynamic json) {
    return Service(
      name: json['name'],
      id: json['id'],
      cid: json['cid'],
      status: json['status'],
    );
  }
}
