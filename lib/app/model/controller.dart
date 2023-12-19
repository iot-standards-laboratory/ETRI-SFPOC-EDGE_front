class Controller {
  final String uuid;
  final String name;
  final bool status;

  int numberOfDevices = 0;
  Controller({required this.name, required this.uuid, required this.status});
  factory Controller.fromJson(dynamic json) {
    return Controller(
      name: json['name'],
      uuid: json['uuid'],
      status: json['status'],
    );
  }
}
