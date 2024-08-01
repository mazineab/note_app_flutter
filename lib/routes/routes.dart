import 'package:get/get.dart';
import 'package:note_app_flutter/features/category/screens/add_note_page.dart';
import 'package:note_app_flutter/features/category/screens/app_home.dart';
import 'package:note_app_flutter/features/category/screens/note_details.dart';
import 'package:note_app_flutter/features/home/bindings/home_binding.dart';
import 'package:note_app_flutter/features/home/screens/home.dart';
import 'package:note_app_flutter/features/user/bindings/user_binding.dart';
import 'package:note_app_flutter/features/user/screens/login.dart';
import 'package:note_app_flutter/features/user/screens/page_home.dart';
import 'package:note_app_flutter/features/user/screens/register.dart';
import 'package:note_app_flutter/routes/routes_names.dart';

import '../core/services/auth_middleware.dart';
import '../global/spleash.dart';

class AppRoutes{
  static appRoutes()=>[
    GetPage(
      name: RoutesNames.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
        name:RoutesNames.homePage,
        page:()=>HomePage(),
        binding: HomeBinding(),
        middlewares:[AuthMiddleware()]
    ),
    GetPage(
        name: RoutesNames.loginPage,
        page:()=>LoginScreen(),
    ),
    GetPage(
        name: RoutesNames.registerPage,
        page: ()=>Register(),
        binding: UserBinding()
    ),
    GetPage(
        name: RoutesNames.pageHome,
        page: ()=> PageHome(),
        binding: UserBinding()
    ),
    GetPage(
        name:RoutesNames.appHome ,
        page:()=> AppHome(),
        binding: UserBinding()
    ),
    GetPage(
        name:RoutesNames.addNotePage,
        page:()=> AddNotePage(),
        binding: UserBinding()
    ),
    GetPage(
        name: RoutesNames.noteDetail,
        page: ()=>const NoteDetails(),
      binding: UserBinding()
    )
  ];
}