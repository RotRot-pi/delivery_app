import 'package:delivery_app/controller/order/details.dart';
import 'package:delivery_app/core/constants/colors.dart';
import 'package:delivery_app/core/constants/routes_name.dart';
import 'package:delivery_app/core/constants/spaces.dart';
import 'package:delivery_app/data/model/order_details.dart';
import 'package:delivery_app/view/widgets/handeling_data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class OrdersDetailsScreen extends StatelessWidget {
  const OrdersDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersDetailsController());
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Order Details",
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
        body: Container(
          padding:
              AppSpacing.addEdgeInsetsSymmetric(vertical: p16, horizontal: p32),
          child: GetBuilder<OrdersDetailsController>(builder: (controller) {
            return HandelingDataView(
              requestStatus: controller.requestStatus,
              child: Column(
                children: [
                  Card(
                    color: AppColors.whiteTextColor,
                    child: Container(
                      padding: AppSpacing.addEdgeInsetsAll(p12),
                      child: Table(children: [
                        const TableRow(children: [
                          Text("Item",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor)),
                          Text("QTY",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor)),
                          Text("Price",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor))
                        ]),
                        ...List.generate(controller.data.length, (index) {
                          OrderDetails orderDetails = controller.data[index];
                          return TableRow(children: [
                            Text(
                              "${orderDetails.orderId}",
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${orderDetails.cartItemCount}",
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${orderDetails.itemsPrice}",
                              textAlign: TextAlign.center,
                            ),
                          ]);
                        })
                      ]),
                    ),
                  ),
                  AppSpacing.addHeigh(h10),
                  Card(
                    color: AppColors.whiteTextColor,
                    child: Container(
                      padding: AppSpacing.addEdgeInsetsAll(p12),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Total: ${controller.orderDetails?.orderPrice}\$",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.addHeigh(h10),
                  if (controller.orderDetails?.orderType == 0)
                    Card(
                      color: AppColors.whiteTextColor,
                      child: ListTile(
                          title: const Text(
                            "Shipping Address",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${controller.orderDetails?.addressStreet}, ${controller.orderDetails?.addressCity}",
                            style: const TextStyle(color: AppColors.greyColor),
                          )),
                    ),
                  AppSpacing.addHeigh(h10),
                  if (controller.orderDetails?.orderType == 0)
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: GetBuilder<OrdersDetailsController>(
                        builder: (controller) => Stack(
                          children: [
                            FlutterMap(
                              mapController: controller.mapController,
                              options: MapOptions(
                                onMapReady: () => controller.setMarker(LatLng(
                                    controller.orderDetails?.addressLat ?? 0.0,
                                    controller.orderDetails?.addressLong ??
                                        0.0)),
                                initialCenter: LatLng(
                                  controller.orderDetails?.addressLat ?? 0.0,
                                  controller.orderDetails?.addressLong ?? 0.0,
                                ),
                                initialZoom: controller.zoom,
                                minZoom: controller.zoom,
                                maxZoom: controller.zoom,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.example.app',
                                ),
                                MarkerLayer(markers: controller.markers),
                                RichAttributionWidget(
                                  attributions: [
                                    TextSourceAttribution(
                                      'OpenStreetMap contributors',
                                      onTap: () => launchUrl(Uri.parse(
                                          'https://openstreetmap.org')),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                                bottom: 10,
                                left: 10,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          controller.zoomIn();
                                        },
                                        child: const Icon(Icons.add),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          controller.zoomOut();
                                        },
                                        child: const Icon(Icons.remove),
                                      ),
                                    ]))
                          ],
                        ),
                      ),
                    ),
                  AppSpacing.addHeigh(h12),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.trackOrder,
                            arguments: {'order': controller.orderDetails});
                      },
                      child: const Text("Track Order"))
                ],
              ),
            );
          }),
        ));
  }
}
