import 'package:flutter/material.dart';
import 'package:front/app/controller/mqttclient.dart';
import 'package:front/app/model/agent.dart';
import 'package:front/app/model/controller.dart';
import 'package:front/app/model/service_image.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'http_loader.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var menuIdx = 0.obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var images = <ServiceImage>[
    ServiceImage(
      name: 'test',
      id: 'id',
      cid: 'cid',
      status: 'status',
    ),
    ServiceImage(
      name: 'test',
      id: 'id',
      cid: 'cid',
      status: 'status',
    ),
  ].obs;
  var agents = <Agent>[].obs;
  var ctrls = <Controller>[].obs;

  // centrifuge.Client? client = null;
  // void initCentrifuge() async {
  //   client = await newCentrifugeClient();
  // }

  MqttBrowserClient? mqttClient;
  void mqttInit() async {
    var (code, info) = await loadInitInformation();

    if (code != 200) {
      return;
    }

    var mqttAddr = info['mqttAddr'];
    var parsedAddress = Uri.parse(mqttAddr);
    print(parsedAddress.path);
    mqttClient = newMqttClient(
      uri: parsedAddress,
    );

    final connMess = MqttConnectMessage()
        // .withClientIdentifier('etri/etrismartfarm')
        .withWillTopic(
            'public/statuschanged') // If you set this you must set a will message
        .withWillMessage('I am user')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    mqttClient!.connectionMessage = connMess;

    try {
      await mqttClient!.connect('etrimqtt', 'fainal2311');
    } on Exception catch (e) {
      print('client exception - $e');
      mqttClient!.disconnect();
      return;
    }

    Subscribe(
      client: mqttClient!,
      topic: "public/statuschanged",
      onUpdate: (topic, payload) {
        loadData();
      },
    );
  }

  void loadData() async {
    agents.value = await loadAgents();
    // images.value = await loadServices();
    ctrls.value = await loadCtrls();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
    mqttInit();
  }

  @override
  void onClose() {
    super.onClose();
    mqttClient!.disconnect();
  }
}
