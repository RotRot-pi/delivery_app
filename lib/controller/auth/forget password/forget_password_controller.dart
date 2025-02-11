import 'package:delivery_app/core/constants/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ForgetPasswordController extends GetxController {
  forgetPassword();
  goToVerifyCode();
}

class ForgetPasswordControllerImpl extends ForgetPasswordController {
  late TextEditingController emailController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  forgetPassword() {
    if (formKey.currentState!.validate()) {
      print("=========ForgetPassword is valid=========");
    } else {
      print("=========ForgetPassword is not valid=========");
    }
  }

  @override
  goToVerifyCode() {
    Get.toNamed(AppRoutes.verifyCode);
  }

  @override
  void onInit() {
    emailController = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }
}
