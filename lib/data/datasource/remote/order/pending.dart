import 'package:delivery_app/core/classes/crud.dart';

import 'package:delivery_app/core/constants/api_link.dart';

class PendingOrderData {
  Crud crud;
  PendingOrderData({
    required this.crud,
  });

  getData() async {
    var response = await crud.post(ApiLink.viewPendingOrder, {});
    print("PendingOrder");
    return response.fold((l) => l, (r) => r);
  }

  approveOrder(String deliveryId, String userId, String orderId) async {
    var response = await crud.post(ApiLink.approveOrder,
        {"delivery_id": deliveryId, "user_id": userId, "order_id": orderId});
    print("PendingOrder");
    return response.fold((l) => l, (r) => r);
  }
}
