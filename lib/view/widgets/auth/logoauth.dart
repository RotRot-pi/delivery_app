import 'package:delivery_app/core/constants/image_assets.dart';
import 'package:delivery_app/core/constants/spaces.dart';
import 'package:flutter/material.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: r72,
        backgroundColor: Colors.red,
        child: Padding(
          padding: AppSpacing.addEdgeInsetsAll(zero), // Border radius
          child: ClipOval(
            child: Image.asset(AppImageAssets.logo),
          ),
        ));
  }
}
