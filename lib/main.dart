import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front/app/routes/app_pages.dart';
import 'package:front/colors.dart';
import 'package:front/constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

Future<String> load() async {
  final uriGetter = Uri.base.scheme == 'http' ? Uri.http : Uri.https;
  var resp = await http.get(uriGetter(serverAddr, '/loading'));
  var body = jsonDecode(resp.body);
  return body["page"];
}

void main() async {
  serverAddr = kIsWeb && !kDebugMode
      ? '${Uri.base.host}:${Uri.base.port}'
      : 'etri.godopu.com:3000';

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
