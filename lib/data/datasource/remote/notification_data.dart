import 'package:delivery_app/core/classes/crud.dart';

import 'package:delivery_app/core/constants/api_link.dart';

class NotificationData {
  Crud crud;
  NotificationData({
    required this.crud,
  });

  getData(var userId) async {
    var response = await crud
        .post(ApiLink.notificationView, {'user_id': userId.toString()});
    print("NotificationData");
    return response.fold((l) => l, (r) => r);
  }
}
