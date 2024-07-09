import 'package:delivery_app/core/classes/crud.dart';

import 'package:delivery_app/core/constants/api_link.dart';

class ItemData {
  Crud crud;
  ItemData({
    required this.crud,
  });

  getData(var categoryId, var usersId) async {
    var response = await crud.post(ApiLink.items, {
      'categories_id': categoryId.toString(),
      'users_id': usersId.toString()
    });
    print("ItemData");
    return response.fold((l) => l, (r) => r);
  }
}
