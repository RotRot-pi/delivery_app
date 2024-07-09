import 'package:delivery_app/core/constants/colors.dart';
import 'package:delivery_app/core/constants/routes_name.dart';
import 'package:delivery_app/core/services/services.dart';
import 'package:delivery_app/view/screen/home_page.dart';
import 'package:delivery_app/view/screen/orders/accepted.dart';
import 'package:delivery_app/view/screen/orders/archive.dart';
import 'package:delivery_app/view/screen/orders/pending.dart';
// import 'package:delivery_app/view/screen/cart.dart';
// import 'package:delivery_app/view/screen/home_page.dart';
// import 'package:delivery_app/view/screen/notification.dart';
// import 'package:delivery_app/view/screen/offers.dart';
// import 'package:delivery_app/view/screen/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int index);
  isPageActive(int index);
  showBackDialog(BuildContext context);
}

class HomeScreenControllerImpl extends HomeScreenController {
  int currentPageIndex = 0;
  int? pageIndex;
  List pages = [
    PendingOrdersScreen(),
    AcceptedOrdersScreen(),
    ArchiveOrdersScreen()
    // OffersScreen(),
    // NotificationScreen(),
    // SettingsScreen()
  ];
  List bottomAppBarItems = [
    {
      "icon": Icons.pending_actions_outlined,
      "name": "Pending".tr,
    },
    {
      "icon": Icons.assignment_outlined,
      "name": "Accepted".tr,
    },
    {
      "icon": Icons.archive_outlined,
      "name": "Archive".tr,
    }
  ];
  @override
  changePage(int index) {
    currentPageIndex = index;
    update();
  }

  goToCart() {
    Get.toNamed(AppRoutes.cart);
  }

  @override
  Future<bool?> showBackDialog(BuildContext context) {
    return Get.defaultDialog(
      backgroundColor: AppColors.whiteTextColor,
      cancelTextColor: Colors.blue,
      title: 'Are you sure?',
      content: const Text(
        'Are you sure you want to leave the app?',
      ),
      actions: <Widget>[
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: const BorderSide(
            color: AppColors.secondaryColor,
          )),
          child: Text(
            'cancel',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: AppColors.primaryColor),
          ),
          onPressed: () {
            Get.back(result: false);
          },
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: const BorderSide(
            color: AppColors.secondaryColor,
          )),
          child: Text(
            'Leave',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: AppColors.primaryColor),
          ),
          onPressed: () {
            Get.back(result: true);
          },
        ),
      ],
    );
  }

  @override
  isPageActive(int index) {
    return currentPageIndex == index;
  }

  @override
  void onInit() {
    AppServices _appServices = Get.find();
    _appServices.sharedPreferences
      ..setInt("id", 1)
      ..setString('username', "delivery")
      ..setString('email', "delivery@gmail.com")
      ..setString('phone', "123456789")
      ..setInt('step', 2);
    print("app services: ${_appServices.sharedPreferences.getInt("id")}");
    super.onInit();
  }
}
