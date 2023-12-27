import 'package:flutter/material.dart';
import 'package:front/app/model/controller.dart';
import 'package:front/app/model/service_image.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  // supabase settings
  static HomeController get to => Get.find();
  final supabase = Supabase.instance.client;
  @override
  void onInit() {
    super.onInit();
    // print('uri base: ${Uri.base.queryParameters}');

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
    supabase
        .from('etri_map_ctrls_svcs')
        .stream(primaryKey: ['svc_id', 'ctrl_id']).listen(
      (List<Map<String, dynamic>> data) async {
        mapCtrlsSvcs.clear();

        var resp = await supabase
            .from('etri_map_ctrls_svcs')
            .select('etri_list_ctrls(id), etri_list_svcs(*)');

        for (var e in resp) {
          var l = mapCtrlsSvcs[e['etri_list_ctrls']['id']];
          l ??= [];
          l.add(e['etri_list_svcs']);

          mapCtrlsSvcs[e['etri_list_ctrls']['id']] = l;
        }
        print(mapCtrlsSvcs);
      },
    );
  }

  // data
  var menuIdx = 0.obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var svcs = <ServiceImage>[].obs;
  var ctrls = <Controller>[].obs;
  var mapCtrlsSvcs = <String, List<Map<String, dynamic>>>{}.obs;

  void installService(String imgId) async {
    await supabase.rpc("etri_func_install_svc", params: {"_uuid": imgId});
    // var resp = await supabase.from('etri_list_svcs').insert(
    //   {
    //     'image_name': svc.name,
    //     'image_id': svc.imageId,
    //     'status': 'installing',
    //   },
    // );

    // print(resp);
  }

  void deleteService(ServiceImage svc) async {
    var resp = await supabase.from('etri_list_svcs').delete().eq('id', svc.id);

    print(resp);
  }

  void registerService(String svcId, ctrlId) async {
    var resp = await supabase.from('etri_map_ctrls_svcs').insert(
      {
        'svc_id': svcId,
        'ctrl_id': ctrlId,
      },
    );

    print(resp);
  }

  void unregisterService(String svcId, ctrlId) async {
    var resp = await supabase
        .from('etri_map_ctrls_svcs')
        .delete()
        .eq('svc_id', svcId)
        .eq('ctrl_id', ctrlId);

    print(resp);
  }
}
