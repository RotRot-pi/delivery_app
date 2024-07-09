import 'package:delivery_app/core/classes/crud.dart';

import 'package:delivery_app/core/constants/api_link.dart';

class ArchiveOrderData {
  Crud crud;
  ArchiveOrderData({
    required this.crud,
  });

  getData(var deliveryId) async {
    var response =
        await crud.post(ApiLink.viewArchiveOrder, {'delivery_id': deliveryId});
    print("ArchiveOrder");
    return response.fold((l) => l, (r) => r);
  }
}
