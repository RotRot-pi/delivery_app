import 'package:delivery_app/core/classes/request_status.dart';
import 'package:delivery_app/core/constants/routes_name.dart';
import 'package:delivery_app/core/functions/handing_data.dart';
import 'package:delivery_app/data/datasource/remote/auth/verify_signup_code_data.dart';
import 'package:get/get.dart';

abstract class VerifySignUpCodeController extends GetxController {
  verfiyCode(String verificationCode);
  resendVerifyCode();
  goToSuccessSignUp();
}

class VerifySignUpCodeControllerImpl extends VerifySignUpCodeController {
  //Work on The conroller of VerifySignUpCode
  late String email;
  VerfiySinUpCodeData verfiySinUpCodeData =
      VerfiySinUpCodeData(crud: Get.find());
  RequestStatus requestStatus = RequestStatus.notInitialized;
  @override
  verfiyCode(
    String verificationCode,
  ) async {
    requestStatus = RequestStatus.loading;
    update();
    print("verificationCode:$verificationCode");
    print("email:$email");
    var response = await verfiySinUpCodeData.postData(email, verificationCode);

    requestStatus = handelingData(response);
    print("requestStatus:$requestStatus");
    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      print("response :${response['status']}");

      goToSuccessSignUp();
    } else {
      Get.defaultDialog(
        title: "warning".tr,
        middleText: "verification_code_not_correct".tr,
      );
      requestStatus;
    }
    update();
  }

  @override
  goToSuccessSignUp() {
    Get.toNamed(AppRoutes.successSignUp);
  }

  @override
  resendVerifyCode() async {
    await verfiySinUpCodeData.resentData(email);
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }
}
