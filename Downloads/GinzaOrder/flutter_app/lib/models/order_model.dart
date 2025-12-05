import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderLineItem {
  final String id;
  final String category;
  final String itemName;
  final String? manualItemName;
  final String color;
  final String width;
  final String uom;
  final String quantity;
  final double rate;
  final double discount;
  final DateTime deliveryDate;
  final String? remark;

  OrderLineItem({
    required this.id,
    required this.category,
    required this.itemName,
    this.manualItemName,
    required this.color,
    required this.width,
    required this.uom,
    required this.quantity,
    required this.rate,
    required this.discount,
    required this.deliveryDate,
    this.remark,
  });

  factory OrderLineItem.fromJson(Map<String, dynamic> json) =>
      _$OrderLineItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderLineItemToJson(this);

  double get total => (double.tryParse(quantity) ?? 0) * rate - discount;
}

@JsonSerializable()
class OrderFormData {
  final String branch;
  final String salesPerson;
  final String salesContactNo;
  final String customerName;
  final String customerEmail;
  final String customerContactNo;
  final String billingAddress;
  final String deliveryAddress;
  final DateTime orderDate;
  final List<OrderLineItem> items;

  OrderFormData({
    required this.branch,
    required this.salesPerson,
    required this.salesContactNo,
    required this.customerName,
    required this.customerEmail,
    required this.customerContactNo,
    required this.billingAddress,
    required this.deliveryAddress,
    required this.orderDate,
    required this.items,
  });

  factory OrderFormData.fromJson(Map<String, dynamic> json) =>
      _$OrderFormDataFromJson(json);
  Map<String, dynamic> toJson() => _$OrderFormDataToJson(this);

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);
}

@JsonSerializable()
class SubmittedOrder {
  final String id;
  final OrderFormData data;
  final DateTime submittedAt;
  final String? spreadsheetUrl;
  final String? supabaseId;

  SubmittedOrder({
    required this.id,
    required this.data,
    required this.submittedAt,
    this.spreadsheetUrl,
    this.supabaseId,
  });

  factory SubmittedOrder.fromJson(Map<String, dynamic> json) =>
      _$SubmittedOrderFromJson(json);
  Map<String, dynamic> toJson() => _$SubmittedOrderToJson(this);
}

@JsonSerializable()
class Customer {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String branch;
  final String? address;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.branch,
    this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
