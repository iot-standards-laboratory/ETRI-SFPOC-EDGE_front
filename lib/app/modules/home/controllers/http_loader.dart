import 'dart:convert';

import 'package:front/app/model/controller.dart';
import 'package:front/app/model/service_image.dart';
import 'package:front/constants.dart';
import 'package:http/http.dart' as http;

final uriGetter = Uri.base.scheme == 'http' ? Uri.http : Uri.https;

Future<List<ServiceImage>> loadServices() async {
  var resp = await http.get(uriGetter(serverAddr, '/api/v2/svcs'));

  var body = jsonDecode(resp.body);

  var services = List.generate(
    body.length,
    (index) => ServiceImage.fromJson((body[index])),
  ).toList();

  return services;
  // return <Service>[];
}

Future<List<Controller>> loadAgents() async {
  var resp = await http.get(uriGetter(serverAddr, '/api/v2/agents'));

  var body = jsonDecode(resp.body);

  var agents = List.generate(body.length, (index) {
    return Controller.fromJson(body[index]);
  }).toList();

  return agents;
}

Future<List<Controller>> loadCtrls() async {
  var resp = await http.get(uriGetter(serverAddr, '/api/v2/ctrls'));

  var body = jsonDecode(resp.body);
  print(body);

  var ctrls = List.generate(body.length, (index) {
    return Controller.fromJson(body[index]);
  }).toList();

  return ctrls;
}

Future<int> deleteSvc(ServiceImage svc) async {
  var resp = await http.delete(
    uriGetter(serverAddr, '/api/v2/svcs'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'service_id': svc.id.toString(),
    },
  );

  return resp.statusCode;
}

Future<(int, dynamic)> loadInitInformation() async {
  var resp = await http.get(
    uriGetter(serverAddr, '/api/v2/home'),
  );

  try {
    print(resp.body);
    var obj = jsonDecode(resp.body);

    return (resp.statusCode, obj);
  } catch (e) {
    print(e.toString());
  }
  return (-1, null);
}
