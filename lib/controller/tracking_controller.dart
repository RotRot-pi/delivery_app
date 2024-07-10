import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/controller/order/accepted.dart';
import 'package:delivery_app/core/classes/request_status.dart';
import 'package:delivery_app/core/constants/routes_name.dart';
import 'package:delivery_app/core/functions/handing_data.dart';
import 'package:delivery_app/core/services/services.dart';
import 'package:delivery_app/data/model/order.dart';
import 'package:delivery_app/data/model/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class TrackingController extends GetxController {
  //Note:You can animate the camera to follow the delivery location using google maps

  StreamSubscription<Position>? _positionStreamSubscription;
  final AppServices _appServices = Get.find();
  final AcceptedOrderController acceptedOrderController =
      Get.put(AcceptedOrderController());
  late MapController mapController;
  late MapCamera mapCamera;
  late OrderDetails orderDetails;
  Timer? timer;
  double zoom = 10;
  List<Marker> markers = [];
  double currentLat = 0;
  double currentLng = 0;

  double destLat = 0;
  double destLng = 0;
  List<Polyline> polylines = [];

  List data = [];
  late RequestStatus requestStatus;
  getCurrentLocation() {
    // markers.clear();
    _positionStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      print("===============++TRACKING++===============");
      print(position.latitude);
      print(position.longitude);
      print("===============++TRACKING++===============");

      destLat = orderDetails.addressLat!;
      destLng = orderDetails.addressLong!;
      print("destination lat: $destLat");
      print("destination lng: $destLng");
      currentLat = position.latitude;
      currentLng = position.longitude;
      polylines.clear();
      polylines.add(Polyline(
        points: [
          LatLng(currentLat, currentLng),
          LatLng(destLat, destLng),
        ],
      ));
      markers.removeWhere(
          (element) => element.key == const Key("Destination Marker"));
      markers.add(
        Marker(
          key: const Key("Destination Marker"),
          point: LatLng(orderDetails.addressLat!, orderDetails.addressLong!),
          child: const Icon(Icons.location_on),
        ),
      );
      // Add the camera animation here
      markers
          .removeWhere((element) => element.key == const Key("Current Marker"));
      markers.add(
        Marker(
          key: const Key("Current Marker"),
          point: LatLng(position.latitude, position.longitude),
          child: const Icon(Icons.location_on),
        ),
      );
    });
    print(_positionStreamSubscription);

    update();
  }

  refreshLocation() async {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      FirebaseFirestore.instance
          .collection("delivery")
          .doc("${orderDetails.orderId}")
          .set({
        "lat": currentLat.toString(),
        "lng": currentLng.toString(),
        "deliveryId": _appServices.sharedPreferences.getInt("id").toString()
      });
    });
  }

  deliveryDone() async {
    requestStatus = RequestStatus.loading;
    update();
    var response = await acceptedOrderController.orderDone(
        orderDetails.orderUserId, orderDetails.orderId);
    requestStatus = handelingData(response);
    update();
    Get.offAllNamed(AppRoutes.home);
  }

  setMarker(LatLng latLng) {
    if (orderDetails.orderType == 0) {
      markers.clear();
      markers.add(
        Marker(
          point: latLng,
          child: const Icon(Icons.location_on),
        ),
      );

      // lat = order.addressLat ?? latLng.latitude;
      // lng = order.addressLong ?? latLng.longitude;
    }
    update();
  }

  zoomIn() {
    if (zoom < 150) {
      zoom += 0.5;

      print("Zoom: $zoom");
    }
    update();
  }

  zoomOut() {
    if (zoom > 1) {
      zoom -= 0.5;

      print("Zoom: $zoom");
    }
    update();
  }

  @override
  void onInit() {
    requestStatus = RequestStatus.notInitialized;
    orderDetails = Get.arguments['order'];
    mapController = MapController();
    getCurrentLocation();
    refreshLocation();

    super.onInit();
  }

  @override
  void onClose() {
    _positionStreamSubscription!.cancel();
    mapController.dispose();
    timer!.cancel();
    super.onClose();
  }
}
