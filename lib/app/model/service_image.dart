class ServiceImage {
  final int? id;
  final String? name, imageId;
  final String? status;
  final String? createdAt;

  ServiceImage({this.id, this.name, this.imageId, this.status, this.createdAt});

  factory ServiceImage.fromJson(dynamic json) {
    return ServiceImage(
      name: json['image_name'],
      id: json['id'],
      imageId: json['image_id'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }
}
