class ServiceImage {
  final String? name, id, cid;
  final String? status;

  ServiceImage({this.name, this.id, this.cid, this.status});

  factory ServiceImage.fromJson(dynamic json) {
    return ServiceImage(
      name: json['name'],
      id: json['id'],
      cid: json['cid'],
      status: json['status'],
    );
  }
}
