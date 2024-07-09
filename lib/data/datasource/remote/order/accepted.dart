import 'package:delivery_app/core/classes/crud.dart';

import 'package:delivery_app/core/constants/api_link.dart';

class AcceptedOrderData {
  Crud crud;
  AcceptedOrderData({
    required this.crud,
  });

  getData(var deliveryId) async {
    var response =
        await crud.post(ApiLink.viewAcceptedOrder, {'delivery_id': deliveryId});
    print("AccetepedOrder");
    return response.fold((l) => l, (r) => r);
  }

  orderDone(var userId, var orderId) async {
    var response = await crud
        .post(ApiLink.orderDone, {'user_id': userId, 'order_id': orderId});
    print("AccetepedOrder");
    return response.fold((l) => l, (r) => r);
  }
}
