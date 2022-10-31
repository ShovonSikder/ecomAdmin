import 'package:ecom_admin/models/date_model.dart';

class PurchaseMode {
  String? purchaseId;
  String? productId;
  num purchaseQuantity;
  num purchasePrice;
  DateModel dateModel;

  PurchaseMode({
    this.purchaseId,
    this.productId,
    required this.purchaseQuantity,
    required this.purchasePrice,
    required this.dateModel,
  });

//TODO: implement map key constants,toMap, fromMap
}
