import 'package:delivery_app/bindings/init_binding.dart';
import 'package:delivery_app/core/constants/routes_name.dart';
import 'package:delivery_app/core/localization/change_local.dart';
import 'package:delivery_app/core/localization/translation.dart';
import 'package:delivery_app/core/services/services.dart';
import 'package:delivery_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await ScreenUtil.ensureScreenSize();
  // var s = await SharedPreferences.getInstance();
  // await s.setInt("id", 1);

  // s.clear();
  // print("DID: ${s.getInt("id")}");
  await initializeServices();

  runApp(const MyApp());
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    screenInit(context, width, height);
    LocalizationController localizationController = Get.put(
      LocalizationController(),
    );
    return ScreenUtilInit(
      designSize: Size(width, height),

      // minTextAdapt: true,
      builder: (context, widget) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          translations: AppTranslation(),
          locale: localizationController.language,
          theme: localizationController.appTheme,
          getPages: getPages,
          initialBinding: InitialAppBindings(),
          initialRoute: AppRoutes.home,
        );
      },
    );
  }
}

screenInit(var context, var width, var height) {
  ScreenUtil.init(
    context,
    designSize: Size(width, height),
    minTextAdapt: true,
  );
}
