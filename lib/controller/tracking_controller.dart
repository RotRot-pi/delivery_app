import 'dart:async';

import 'package:delivery_app/core/classes/request_status.dart';
import 'package:delivery_app/core/services/services.dart';
import 'package:delivery_app/data/model/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class TrackingController extends GetxController {
  //Note:You can animate the camera to follow the delivery location using google maps

  StreamSubscription<Position>? _positionStreamSubscription;
  final AppServices _appServices = Get.find();
  late MapController mapController;
  late MapCamera mapCamera;
  late Order order;
  double zoom = 10;

  List<Marker> markers = [];
  double currentLat = 0;
  double currentLng = 0;

  double destLat = 0;
  double destLng = 0;

  List data = [];
  late RequestStatus requestStatus;
  getCurrentLocation() {
    _positionStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      print("===============++TRACKING++===============");
      print(position.latitude);
      print(position.longitude);
      print("===============++TRACKING++===============");
      markers.add(
        Marker(
          key: const Key("Destination Marker"),
          point: LatLng(order.addressLat!, order.addressLong!),
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

  setMarker(LatLng latLng) {
    if (order.orderType == 0) {
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
    getCurrentLocation();
    order = Get.arguments['order'];
    mapController = MapController();
    super.onInit();
  }
}
