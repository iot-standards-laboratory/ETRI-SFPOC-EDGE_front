import 'package:flutter/material.dart';
import 'package:front/app/model/controller.dart';
import 'package:front/app/model/device.dart';
import 'package:front/app/model/service_image.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  // supabase settings
  final supabase = Supabase.instance.client;
  @override
  void onInit() {
    super.onInit();
    // supabase.from('etri').select().eq('id', 1);
    supabase.from('etri_list_svcs').stream(primaryKey: ['id']).listen(
      (List<Map<String, dynamic>> data) {
        svcs.clear();
        svcs.addAll(data.map((e) => ServiceImage.fromJson(e)));
      },
    );
    supabase.from('etri_list_ctrls').stream(primaryKey: ['id']).listen(
      (List<Map<String, dynamic>> data) {
        ctrls.clear();
        ctrls.addAll(data.map((e) => Controller.fromJson(e)));
      },
    );
  }

  // data
  var menuIdx = 0.obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var svcs = <ServiceImage>[].obs;
  var ctrls = <Controller>[].obs;

  void installService(ServiceImage svc) async {
    var resp = await supabase.from('etri_list_svcs').insert(
      {
        'image_name': svc.name,
        'image_id': svc.imageId,
        'status': 'installing',
      },
    );

    print(resp);
  }

  void deleteService(ServiceImage svc) async {
    var resp = await supabase.from('etri_list_svcs').delete().eq('id', svc.id);

    print(resp);
  }
}
