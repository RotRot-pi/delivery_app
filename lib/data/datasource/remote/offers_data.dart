import 'package:delivery_app/core/classes/crud.dart';

import 'package:delivery_app/core/constants/api_link.dart';

class OffersData {
  Crud crud;
  OffersData({
    required this.crud,
  });

  getData() async {
    var response = await crud.post(ApiLink.offers, {});
    print("OffersData {");
    return response.fold((l) => l, (r) => r);
  }
}
