import 'package:delivery_app/controller/auth/forget password/verfiy_code_controller.dart';
import 'package:delivery_app/view/widgets/handeling_data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

import 'package:delivery_app/core/constants/colors.dart';
import 'package:delivery_app/core/constants/spaces.dart';
import 'package:delivery_app/view/widgets/auth/customtextbodyauth.dart';

import 'package:delivery_app/view/widgets/auth/customtexttitleauth.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyCodeControllerImpl());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.whiteTextColor,
        elevation: 0.0,
        title: Text('verification_code'.tr,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColors.greyColor)),
      ),
      body: GetBuilder<VerifyCodeControllerImpl>(builder: (controller) {
        return HandelingDataView(
            requestStatus: controller.requestStatus,
            child: VerfyCodePage(controller: controller));
      }),
    );
  }
}

class VerfyCodePage extends StatelessWidget {
  const VerfyCodePage({
    super.key,
    required this.controller,
  });
  final VerifyCodeControllerImpl controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          AppSpacing.addEdgeInsetsSymmetric(vertical: p16, horizontal: p32),
      child: ListView(children: [
        AppSpacing.addHeigh(h24),
        CustomTextTitleAuth(text: "verification_code".tr),
        AppSpacing.addHeigh(h12),
        CustomTextBodyAuth(text: "enter_verification_code".tr),
        AppSpacing.addHeigh(h24),
        OtpTextField(
            numberOfFields: 5,
            fieldWidth: w48,
            borderColor: AppColors.greyColor,
            showFieldAsBox: true,
            borderRadius: BorderRadius.circular(r16),
            onSubmit: (String verificationCode) {
              controller.verifyCode(verificationCode);
            }),
      ]),
    );
  }
}
