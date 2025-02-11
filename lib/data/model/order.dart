import 'package:delivery_app/data/model/address.dart';
import 'package:delivery_app/data/model/cart.dart';

class Orders extends Address {
  int? orderId;
  int? orderAddressId;
  int? orderUserId;
  int? orderType;
  int? orderDeliveryPrice;
  int? orderCouponId;
  String? orderDateTime;
  int? orderPrice;
  double? orderTotalprice;
  int? orderPaymentType;
  int? orderStatus;
  int? orderRating;
  String? orderNotating;

  Orders({
    this.orderId,
    this.orderAddressId,
    this.orderUserId,
    this.orderType,
    this.orderDeliveryPrice,
    this.orderCouponId,
    this.orderDateTime,
    this.orderPrice,
    this.orderTotalprice,
    this.orderPaymentType,
    this.orderStatus,
    this.orderRating,
    this.orderNotating,
  });

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderAddressId = json['order_address_id'];
    orderUserId = json['order_user_id'];
    orderType = json['order_type'];
    orderDeliveryPrice = json['order_delivery_price'];
    orderCouponId = json['order_coupon_id'];
    orderDateTime = json['order_date_time'];
    orderPrice = json['order_price'];
    orderTotalprice = json['order_totalprice'].toDouble() as double;
    orderPaymentType = json['order_payment_type'];
    orderStatus = json['order_status'];
    orderRating = json['order_rating'];
    orderNotating = json['order_notating'];
    addressId = json['address_id'];
    addressCity = json['address_city'];
    addressName = json['address_name'];
    addressStreet = json['address_street'];

    addressLat = json['address_lat'].toDouble();

    addressLat = json['address_long'].toDouble();

    addressUserId = json['address_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = orderId;
    data['order_address_id'] = orderAddressId;
    data['order_user_id'] = orderUserId;
    data['order_type'] = orderType;
    data['order_delivery_price'] = orderDeliveryPrice;
    data['order_coupon_id'] = orderCouponId;
    data['order_date_time'] = orderDateTime;
    data['order_price'] = orderPrice;
    data['order_totalprice'] = orderTotalprice;
    data['order_payment_type'] = orderPaymentType;
    data['order_status'] = orderStatus;
    return data;
  }
}
