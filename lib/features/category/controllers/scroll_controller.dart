//
// import 'package:get/get.dart';
// import 'package:note_app_flutter/features/category/controllers/category_controller.dart';
//
// import '../../../data/models/category.dart';
//
// class ScrollControllerr extends GetxController {
//   CategoryController categoryController = Get.put(CategoryController());
//
//   var items = <Category>[].obs;
//   var currentPage = 0.obs;
//   var hasReachedEnd = false.obs;
//
//   void fetchMore() async {
//     if (hasReachedEnd.value) return;
//
//     currentPage.value++;
//     List<Category> newItems = await categoryController.getAllCategory();
//
//     if (newItems.isEmpty) {
//       hasReachedEnd.value = true;
//     } else {
//       items.addAll(newItems);
//     }
//   }
//
//   @override
//   void onInit() {
//     fetchMore();
//     super.onInit();
//   }
// }
