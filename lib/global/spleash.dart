import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/routes/routes_names.dart';
import '../core/utils/constant.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), () {
        Get.offNamed(RoutesNames.homePage);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(Constants.imageNote)),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: const Text(
                "Memo",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
