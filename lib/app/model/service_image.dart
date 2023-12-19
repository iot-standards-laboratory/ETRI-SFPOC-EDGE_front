class ServiceImage {
  final int id;
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
      name: json['image_name'],
      imageId: json['image_id'],
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
