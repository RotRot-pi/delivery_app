import 'package:delivery_app/core/classes/crud.dart';
import 'package:delivery_app/core/constants/api_link.dart';

class FavoriteData {
  final Crud crud;

  FavoriteData(this.crud);

  getData(var userId) async {
    print("id from crud:$userId");
    var response = await crud.post(ApiLink.favoriteView, {
      "users_id": userId.toString(),
    });
    print("FavoriteData");
    return response.fold((l) => l, (r) => r);
  }

  deleteData(var favoriteId) async {
    var response = await crud.post(ApiLink.deleteFavorite, {
      "favorite_id": favoriteId.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
