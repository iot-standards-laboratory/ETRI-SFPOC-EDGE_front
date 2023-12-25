class Controller {
  final String id;
  final String name;
  final bool status;

  int numberOfDevices = 0;
  Controller({
    required this.id,
    required this.name,
    required this.status,
  });
  factory Controller.fromJson(dynamic json) {
    return Controller(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}
