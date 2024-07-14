import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/features/home/controllers/home_controller.dart';
import 'package:note_app_flutter/features/home/screens/home.dart';
import 'package:note_app_flutter/features/user/controllers/text_field_controller.dart';
import 'package:note_app_flutter/routes/routes.dart';
import 'package:note_app_flutter/routes/routes_names.dart';

import 'core/services/tokenManager.dart';
import 'core/utils/localStorage/shared_pref_manager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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

