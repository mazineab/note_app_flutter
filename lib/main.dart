import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/routes/routes.dart';
import 'package:note_app_flutter/routes/routes_names.dart';

import 'core/services/tokenManager.dart';
import 'core/utils/localStorage/shared_pref_manager.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
  final prefs = await Get.putAsync(() => SharedPrefManager().init());
  Get.put(TokenManager(prefs));
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      getPages:AppRoutes.appRoutes(),
      initialRoute:RoutesNames.homePage,
      // initialRoute: RoutesNames.pageHome,
    );
  }
}

