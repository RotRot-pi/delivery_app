import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/core/classes/request_status.dart';
import 'package:delivery_app/core/constants/colors.dart';
import 'package:delivery_app/core/functions/handing_data.dart';
import 'package:delivery_app/core/services/services.dart';
import 'package:delivery_app/data/datasource/remote/order/details.dart';
import 'package:delivery_app/data/model/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class OrdersDetailsController extends GetxController {
  final AppServices _appServices = Get.find();
  final OrderDetailsData orderDetailsData = OrderDetailsData(crud: Get.find());
  late MapController mapController;
  late MapCamera mapCamera;
  late Position position;
  late String orderId;
  OrderDetails? orderDetails; // Change to nullable
  double zoom = 10;

  List<Marker> markers = [];
  double lat = 0;
  double lng = 0;

  List<OrderDetails> data = []; // Change to List<OrderDetails>
  late RequestStatus requestStatus;

  getData() async {
    requestStatus = RequestStatus.loading;
    update();

    print("ORDER ID: $orderId");
    var response = await orderDetailsData.getData(orderId);
    requestStatus = handelingData(response);
    print("status: $requestStatus");

    if (requestStatus == RequestStatus.success &&
        response['status'] == 'success') {
      print("response: $response");
      if (response['data'] != null && response['data'].isNotEmpty) {
        orderDetails = OrderDetails.fromJson(response['data'][0]);
        data = [orderDetails!];
        print("Order Details: $orderDetails");
      } else {
        requestStatus = RequestStatus.failure;
        print("No data received from the server");
      }
    } else {
      requestStatus = RequestStatus.failure;
      print("Request failed or returned unsuccessful status");
    }
    update();
  }

  setMarker(LatLng latLng) {
    if (data.isNotEmpty && data[0].orderType == 0) {
      markers.clear();
      markers.add(
        Marker(
          point: latLng,
          child: const Icon(
            Icons.location_on,
          ),
        ),
      );
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
  void onInit() async {
    orderId = Get.arguments['orderId'].toString();
    await getData();
    mapController = MapController();
    position = _appServices.position;
    super.onInit();
  }

  @override
  void onClose() {
    mapController.dispose();
    super.onClose();
  }
}


// import 'package:delivery_app/core/classes/request_status.dart';
// import 'package:delivery_app/core/constants/colors.dart';
// import 'package:delivery_app/core/functions/handing_data.dart';
// import 'package:delivery_app/core/services/services.dart';
// import 'package:delivery_app/data/datasource/remote/order/details.dart';
// import 'package:delivery_app/data/model/order_details.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:latlong2/latlong.dart';

// class OrdersDetailsController extends GetxController {
//   final AppServices _appServices = Get.find();
//   final OrderDetailsData orderDetailsData = OrderDetailsData(crud: Get.find());
//   late MapController mapController;
//   late MapCamera mapCamera;
//   late Position position;
//   late String orderId;
//   late OrderDetails orderDetails;
//   double zoom = 10;

//   List<Marker> markers = [];
//   double lat = 0;
//   double lng = 0;

//   List data = [];
//   late RequestStatus requestStatus;
//   getData() async {
//     print("status1:$requestStatus");
//     print("ORDER ID:${orderId}");
//     var response = await orderDetailsData.getData(orderId);
//     requestStatus = handelingData(response);
//     print("status2:$requestStatus");
//     if (requestStatus == RequestStatus.success &&
//         response['status'] == 'success') {
//       print("response:$response ");
//       data.add(OrderDetails.fromJson(response['data'][0]));
//       print("Cart Status 3:${requestStatus}");

//       update();
//     } else {
//       requestStatus = RequestStatus.failure;
//     }
//     update();
//   }

//   setMarker(LatLng latLng) {
//     if (data[0].orderType == 0) {
//       markers.clear();
//       markers.add(
//         Marker(
//           point: latLng,
//           child: const Icon(
//             Icons.location_on,
//           ),
//         ),
//       );

//       // lat = order.addressLat ?? latLng.latitude;
//       // lng = order.addressLong ?? latLng.longitude;
//     }
//     update();
//   }

//   zoomIn() {
//     if (zoom < 150) {
//       zoom += 0.5;

//       print("Zoom: $zoom");
//     }
//     update();
//   }

//   zoomOut() {
//     if (zoom > 1) {
//       zoom -= 0.5;

//       print("Zoom: $zoom");
//     }
//     update();
//   }

//   @override
//   void onInit() async {
//     requestStatus = RequestStatus.loading;
//     orderId = Get.arguments['orderId'].toString();
//     await getData();
//     orderDetails = data[0];
//     mapController = MapController();
//     position = _appServices.position;
//     super.onInit();
//   }
// }
