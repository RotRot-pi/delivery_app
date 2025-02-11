import 'package:delivery_app/core/constants/colors.dart';
import 'package:delivery_app/core/constants/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtomAuth extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomButtomAuth({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppSpacing.addEdgeInsetsOnly(top: h10),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(r20)),
        padding: AppSpacing.addEdgeInsetsSymmetric(vertical: r12),
        onPressed: onPressed,
        color: AppColors.primaryColor,
        textColor: Colors.white,
        child: Text(text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: s16.sp)),
      ),
    );
  }
}
