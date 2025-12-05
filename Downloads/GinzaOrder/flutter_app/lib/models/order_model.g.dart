// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderLineItem _$OrderLineItemFromJson(Map<String, dynamic> json) =>
    OrderLineItem(
      id: json['id'] as String,
      category: json['category'] as String,
      itemName: json['itemName'] as String,
      manualItemName: json['manualItemName'] as String?,
      color: json['color'] as String,
      width: json['width'] as String,
      uom: json['uom'] as String,
      quantity: json['quantity'] as String,
      rate: (json['rate'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      deliveryDate: DateTime.parse(json['deliveryDate'] as String),
      remark: json['remark'] as String?,
    );

Map<String, dynamic> _$OrderLineItemToJson(OrderLineItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'itemName': instance.itemName,
      'manualItemName': instance.manualItemName,
      'color': instance.color,
      'width': instance.width,
      'uom': instance.uom,
      'quantity': instance.quantity,
      'rate': instance.rate,
      'discount': instance.discount,
      'deliveryDate': instance.deliveryDate.toIso8601String(),
      'remark': instance.remark,
    };

OrderFormData _$OrderFormDataFromJson(Map<String, dynamic> json) =>
    OrderFormData(
      branch: json['branch'] as String,
      salesPerson: json['salesPerson'] as String,
      salesContactNo: json['salesContactNo'] as String,
      customerName: json['customerName'] as String,
      customerEmail: json['customerEmail'] as String,
      customerContactNo: json['customerContactNo'] as String,
      billingAddress: json['billingAddress'] as String,
      deliveryAddress: json['deliveryAddress'] as String,
      orderDate: DateTime.parse(json['orderDate'] as String),
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderLineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderFormDataToJson(OrderFormData instance) =>
    <String, dynamic>{
      'branch': instance.branch,
      'salesPerson': instance.salesPerson,
      'salesContactNo': instance.salesContactNo,
      'customerName': instance.customerName,
      'customerEmail': instance.customerEmail,
      'customerContactNo': instance.customerContactNo,
      'billingAddress': instance.billingAddress,
      'deliveryAddress': instance.deliveryAddress,
      'orderDate': instance.orderDate.toIso8601String(),
      'items': instance.items,
    };

SubmittedOrder _$SubmittedOrderFromJson(Map<String, dynamic> json) =>
    SubmittedOrder(
      id: json['id'] as String,
      data: OrderFormData.fromJson(json['data'] as Map<String, dynamic>),
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      spreadsheetUrl: json['spreadsheetUrl'] as String?,
      supabaseId: json['supabaseId'] as String?,
    );

Map<String, dynamic> _$SubmittedOrderToJson(SubmittedOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'submittedAt': instance.submittedAt.toIso8601String(),
      'spreadsheetUrl': instance.spreadsheetUrl,
      'supabaseId': instance.supabaseId,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      branch: json['branch'] as String,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'branch': instance.branch,
      'address': instance.address,
    };
