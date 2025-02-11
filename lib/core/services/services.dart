import 'package:delivery_app/core/functions/fcm_config.dart';
import 'package:delivery_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:delivery_app/firebase_options.dart';

class AppServices extends GetxService {
  late SharedPreferences sharedPreferences;
  late FirebaseApp firebaseinit;
  late FirebaseMessaging messaging;
  late Position position;
  AppServices();

  Future<AppServices> init() async {
    print("Init AppServices");
    sharedPreferences = await SharedPreferences.getInstance();
    firebaseinit = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    messaging = await requestNotificationPermission();
    fcmConfig();
    position = await getCurrentPosition();
    return this;
  }
}

initializeServices() async {
  try {
    print('==============++INITIALIZING SERVICES++==============');
    await Get.putAsync(() => AppServices().init());
    print('Done');
  } catch (e) {
    print('Error: $e');
  }
}

Future<Position> getCurrentPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.

      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  print("position: ${await Geolocator.getCurrentPosition()}");
  return Geolocator.getCurrentPosition();
}
