class ServiceImage {
  final String id;
  final String? name, imageId;
  final String? status;
  final String? createdAt;

  ServiceImage({
    required this.id,
    this.name,
    this.imageId,
    this.status,
    this.createdAt,
  });

  factory ServiceImage.fromJson(dynamic json) {
    return ServiceImage(
      id: json['id'],
      name: json['img_name'],
      imageId: json['img_id'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_name': name,
      'image_id': imageId,
      'status': status,
    };
  }
}
