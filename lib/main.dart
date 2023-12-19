import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front/app/routes/app_pages.dart';
import 'package:front/colors.dart';
import 'package:front/constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

Future<String> load() async {
  final uriGetter = Uri.base.scheme == 'http' ? Uri.http : Uri.https;
  var resp = await http.get(uriGetter(serverAddr, '/loading'));
  var body = jsonDecode(resp.body);
  return body["page"];
}

void main() async {
  await Supabase.initialize(
    url: 'https://supabase.godopu.com',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyAgCiAgICAicm9sZSI6ICJhbm9uIiwKICAgICJpc3MiOiAic3VwYWJhc2UtZGVtbyIsCiAgICAiaWF0IjogMTY0MTc2OTIwMCwKICAgICJleHAiOiAxNzk5NTM1NjAwCn0.dc_X5iR_VP_qT0zsiyj_I_OZ2T9FtRU2BBNWN8Bu4GE',
  );

  serverAddr = kIsWeb && !kDebugMode
      ? '${Uri.base.host}:${Uri.base.port}'
      : 'code.godopu.com:9995';

  var page = await load();
  runApp(MyApp(page: page));
}

class MyApp extends StatelessWidget {
  final String page;
  const MyApp({super.key, required this.page});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ETRI-Edge master',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      initialRoute: page,
    );
  }
}
