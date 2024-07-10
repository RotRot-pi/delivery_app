class OrderDetails {
  // Items
  int itemsId;
  String itemsName;
  String itemsNameAr;
  int itemsPrice;
  int? itemsDiscount;
  int itemsActive;
  int itemsCount;
  String itemsImage;
  String itemsDescription;
  String itemsDescriptionAr;
  String itemsDatetime;
  int itemsCategory;
  double itemsDiscountPrice;

  // Cart
  int cartId;
  int cartUserId;
  int cartItemId;
  int cartItemCount;
  int cartOrderId;
  // double totalPrice;

  // Order
  int orderId;
  int orderAddressId;
  int orderUserId;
  int orderType;
  double orderDeliveryPrice;
  int orderCouponId;
  String orderDateTime;
  double orderPrice;
  double orderTotalPrice;
  int orderPaymentType;
  int orderStatus;
  int orderRating;
  String orderNotating;
  int orderDelivery;

  // Address
  int? addressId;
  String? addressCity;
  String? addressName;
  String? addressStreet;
  double? addressLat;
  double? addressLong;
  int? addressUserId;

  OrderDetails({
    required this.itemsId,
    required this.itemsName,
    required this.itemsNameAr,
    required this.itemsPrice,
    this.itemsDiscount,
    required this.itemsActive,
    required this.itemsCount,
    required this.itemsImage,
    required this.itemsDescription,
    required this.itemsDescriptionAr,
    required this.itemsDatetime,
    required this.itemsCategory,
    required this.itemsDiscountPrice,
    required this.cartId,
    required this.cartUserId,
    required this.cartItemId,
    required this.cartItemCount,
    required this.cartOrderId,
    // required this.totalPrice,
    required this.orderId,
    required this.orderAddressId,
    required this.orderUserId,
    required this.orderType,
    required this.orderDeliveryPrice,
    required this.orderCouponId,
    required this.orderDateTime,
    required this.orderPrice,
    required this.orderTotalPrice,
    required this.orderPaymentType,
    required this.orderStatus,
    required this.orderRating,
    required this.orderNotating,
    required this.orderDelivery,
    this.addressId,
    this.addressCity,
    this.addressName,
    this.addressStreet,
    this.addressLat,
    this.addressLong,
    this.addressUserId,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> map) {
    return OrderDetails(
      itemsId: map['items_id'] as int,
      itemsName: map['items_name'] as String,
      itemsNameAr: map['items_name_ar'] as String,
      itemsPrice: map['items_price'] as int,
      itemsDiscount: map['items_discount'] as int?,
      itemsActive: map['items_active'] as int,
      itemsCount: map['items_count'] as int,
      itemsImage: map['items_image'] as String,
      itemsDescription: map['items_description'] as String,
      itemsDescriptionAr: map['items_description_ar'] as String,
      itemsDatetime: map['items_datetime'] as String,
      itemsCategory: map['items_category'] as int,
      itemsDiscountPrice: map['items_discount_price'] as double,
      cartId: map['cart_id'] as int,
      cartUserId: map['cart_user_id'] as int,
      cartItemId: map['cart_item_id'] as int,
      cartItemCount: map['cart_item_count'] as int,
      cartOrderId: map['cart_order_id'] as int,
      // totalPrice: (map['total_price'] as int).toDouble(),
      orderId: map['order_id'] as int,
      orderAddressId: map['order_address_id'] as int,
      orderUserId: map['order_user_id'] as int,
      orderType: map['order_type'] as int,
      orderDeliveryPrice: map['order_delivery_price'].toDouble(),
      orderCouponId: map['order_coupon_id'] as int,
      orderDateTime: map['order_date_time'] as String,
      orderPrice: map['order_price'].toDouble(),
      orderTotalPrice: map['order_totalprice'].toDouble(),
      orderPaymentType: map['order_payment_type'] as int,
      orderStatus: map['order_status'] as int,
      orderRating: map['order_rating'] as int,
      orderNotating: map['order_notating'] as String,
      orderDelivery: map['order_delivery'] as int,
      addressId: map['address_id'] as int?,
      addressCity: map['address_city'] as String?,
      addressName: map['address_name'] as String?,
      addressStreet: map['address_street'] as String?,
      addressLat: (map['address_lat'] as num?)?.toDouble(),
      addressLong: (map['address_long'] as num?)?.toDouble(),
      addressUserId: map['address_user_id'] as int?,
    );
  }
}
