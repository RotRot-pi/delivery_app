// lib/view/screen/language.dart
import 'package:delivery_app/core/constants/routes_name.dart';
import 'package:delivery_app/core/constants/spaces.dart';
import 'package:delivery_app/core/localization/change_local.dart';
import 'package:delivery_app/view/widgets/language/custom_language_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageScreen extends GetView<LocalizationController> {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'choose_language'.tr,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            AppSpacing.addHeigh(h32),
            LanguageButton(
              language: 'English',
              onPressed: () async {
                controller.changeLanguage('en');
                await Future.delayed(const Duration(milliseconds: 400), () {});
                Get.toNamed(AppRoutes.login);
              },
            ),
            AppSpacing.addHeigh(h16),
            LanguageButton(
              language: 'Arabic',
              onPressed: () async {
                controller.changeLanguage('ar');
                await Future.delayed(const Duration(milliseconds: 400), () {});
                Get.toNamed(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
