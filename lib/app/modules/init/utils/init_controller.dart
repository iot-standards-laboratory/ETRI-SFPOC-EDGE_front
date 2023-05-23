import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:front/constants.dart';

Future<(int, String?)> submitInit(String mqttAddr, String consulAddr) async {
  final uriGetter = Uri.base.scheme == 'http' ? Uri.http : Uri.https;

  try {
    var resp = await http.post(uriGetter(serverAddr, '/init'),
        body: jsonEncode({
          "mqttAddr": mqttAddr,
          "consulAddr": consulAddr,
        }));

    return (resp.statusCode, resp.body);
  } catch (e) {
    print(e.toString());
  }

  return (-1, null);
}
