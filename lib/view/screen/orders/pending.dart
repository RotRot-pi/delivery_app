import 'package:delivery_app/view/widgets/order/order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/order/pending.dart';
import '../../../../data/model/order.dart';
import '../../widgets/handeling_data_view.dart';

class PendingOrdersScreen extends StatelessWidget {
  const PendingOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PendingOrderController());
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("Pending"),
        // ),
        body: GetBuilder<PendingOrderController>(
            builder: (controller) => HandelingDataView(
                requestStatus: controller.requestStatus,
                child: ListView.builder(
                    itemCount: controller.data.length,
                    itemBuilder: (context, index) {
                      Orders order = controller.data[index];
                      return OrderCard(
                        order: order,
                        controller: controller,
                      );
                    }))));
  }
}
