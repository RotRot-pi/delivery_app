import 'package:delivery_app/core/classes/crud.dart';

import 'package:delivery_app/core/constants/api_link.dart';

class TestData {
  Crud crud;
  TestData({
    required this.crud,
  });

  getData() async {
    var response = await crud.post(ApiLink.test, {});
    print("TestData");
    return response.fold((l) => l, (r) => r);
  }
}
