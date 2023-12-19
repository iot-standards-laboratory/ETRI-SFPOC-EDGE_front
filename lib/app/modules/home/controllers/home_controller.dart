import 'package:flutter/material.dart';
import 'package:front/app/model/controller.dart';
import 'package:front/app/model/device.dart';
import 'package:front/app/model/service_image.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var menuIdx = 0.obs;
  final supabase = Supabase.instance.client;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var images = <ServiceImage>[].obs;
  var controllers = <Controller>[].obs;
  var ctrls = <Controller>[].obs;

  @override
  void onInit() {
    super.onInit();
    // supabase.from('etri').select().eq('id', 1);
    supabase.from('etri_images').stream(primaryKey: ['id']).listen(
      (List<Map<String, dynamic>> data) {
        images.clear();
        images.addAll(data.map((e) => ServiceImage.fromJson(e)));
      },
    );
    supabase.from('etri_controllers').stream(primaryKey: ['id']).listen(
      (List<Map<String, dynamic>> data) {
        controllers.clear();
        controllers.addAll(data.map((e) => Controller.fromJson(e)));
      },
    );
  }
}
