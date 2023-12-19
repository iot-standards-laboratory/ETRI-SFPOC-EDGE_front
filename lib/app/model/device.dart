class SGDevice {
  final String name;
  final String id;
  final String agentId;

  int numberOfDevices = 0;
  SGDevice({required this.name, required this.id, required this.agentId});
  factory SGDevice.fromJson(dynamic json) {
    return SGDevice(
      name: json['name'],
      id: json['id'],
      agentId: json['agent_id'],
    );
  }
}
