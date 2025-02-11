import 'package:delivery_app/core/classes/request_status.dart';
import 'package:delivery_app/core/constants/routes_name.dart';
import 'package:delivery_app/core/functions/handing_data.dart';
import 'package:delivery_app/data/datasource/remote/forget_password/reset_password_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ResetPasswordController extends GetxController {
  resetPassword();
  showPassword();
  goToSuccessPasswordReset();
}

class ResetPasswordControllerImpl extends ResetPasswordController {
  ResetPasswordData resetPasswordData = ResetPasswordData(crud: Get.find());
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RequestStatus requestStatus = RequestStatus.notInitialized;
  late String email;
  bool val = true;
  String newPasswordMustBeDiffrent = "new_password_must_be_different".tr;
  @override
  resetPassword() async {
    if (formKey.currentState!.validate() &&
        passwordController.text == confirmPasswordController.text) {
      print("=========ResetPassword is valid=========");
      print("email:$email, password:${passwordController.text}");
      requestStatus = RequestStatus.loading;
      update();
      var response =
          await resetPasswordData.postData(email, passwordController.text);
      requestStatus = handelingData(response);

      if (requestStatus == RequestStatus.success &&
          response['status'] == 'success') {
        goToSuccessPasswordReset();
      } else {
        Get.defaultDialog(
          title: "error".tr,
          middleText: "reset_password_fail".tr,
          content: Text(newPasswordMustBeDiffrent),
        );
        //requestStatus = RequestStatus.failure;
      }
    } else {
      Get.defaultDialog(
        title: "warning".tr,
        middleText: "check_your_fields".tr,
      );
    }
    update();
  }

  @override
  goToSuccessPasswordReset() {
    Get.toNamed(AppRoutes.successPasswordReset);
  }

  @override
  showPassword() {
    val == false ? val = true : val = false;
    update();
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
}
