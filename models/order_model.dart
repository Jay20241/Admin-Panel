import 'dart:convert';

class OrderModel {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String productName;
  final int productPrice;
  final int quantity;
  final String category;
  final String image;
  final String buyerId;
  final String vendorId;
  final bool processing;
  final bool delivered;

  OrderModel({required this.id, required this.fullName, required this.email, required this.state, required this.city, required this.locality, required this.productName, required this.productPrice, required this.quantity, required this.category, required this.image, required this.buyerId, required this.vendorId, required this.processing, required this.delivered});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email':email,
      'state':state,
      'city':city,
      'locality':locality,
      'productName':productName,
      'productPrice':productPrice,
      'quantity':quantity,
      'category':category,
      'image':image,
      'buyerId':buyerId,
      'vendorId':vendorId,
      'processing':processing,
      'delivered':delivered
    };
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(Map<String, dynamic> map) {
    return OrderModel(
      id: map['_id'] as String? ?? "",
      fullName: map['fullName'] as String? ?? "unknown name",
      email: map['email'] as String? ?? "",
      city: map['city'] as String? ?? "",
      state: map['state'] as String? ?? "",
      locality: map['locality'] as String? ?? "",
      productName: map['productName'] as String? ?? "",
      productPrice: map['productPrice'] as int? ?? 0,
      quantity: map['quantity'] as int? ?? 0,
      category: map['category'] as String? ?? "",
      image: map['image'] as String? ?? "",
      buyerId: map['buyerId'] as String? ?? "",
      vendorId: map['vendorId'] as String? ?? "",
      processing: map['processing'] as bool? ?? true,
      delivered: map['delivered'] as bool? ?? false,
    );
  }

  //This line will not convert the data correctly
  //factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

//Code serialization and deserialization.