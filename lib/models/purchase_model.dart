import 'package:ecom_admin/models/date_model.dart';

const String collectionPurchase = 'purchase';
const String purchaseFieldPurchaseId = 'purchaseId';
const String purchaseFieldProductId = 'productId';
const String purchaseFieldPurchaseQuantity = 'purchaseQuantity';
const String purchaseFieldPurchasePrice = 'purchasePrice';
const String purchaseFieldDateModel = 'dateModel';

class PurchaseModel {
  String? purchaseId;
  String? productId;
  num purchaseQuantity;
  num purchasePrice;
  DateModel dateModel;

  PurchaseModel({
    this.purchaseId,
    this.productId,
    required this.purchaseQuantity,
    required this.purchasePrice,
    required this.dateModel,
  });

//: implement map key constants,toMap, fromMap
  Map<String, dynamic> toMap() => <String, dynamic>{
        purchaseFieldPurchaseId: purchaseId,
        purchaseFieldProductId: productId,
        purchaseFieldPurchaseQuantity: purchaseQuantity,
        purchaseFieldPurchasePrice: purchasePrice,
        purchaseFieldDateModel: dateModel.toMap(),
      };

  factory PurchaseModel.fromMap(Map<String, dynamic> map) => PurchaseModel(
        purchaseId: map[purchaseFieldProductId],
        productId: map[purchaseFieldProductId],
        purchaseQuantity: map[purchaseFieldPurchaseQuantity],
        purchasePrice: map[purchaseFieldPurchasePrice],
        dateModel: DateModel.fromMap(map[purchaseFieldDateModel]),
      );
}
