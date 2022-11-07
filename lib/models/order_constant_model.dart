const String collectionOrderConstant = 'orderConstant';
const String orderConstantFieldDiscount = 'discount';
const String orderConstantFieldVat = 'vat';
const String orderConstantFieldDeliveryCharge = 'deliveryCharge';

class OrderConstantModel {
  num discount;
  num vat;
  num deliveryCharge;

  OrderConstantModel({
    required this.discount,
    required this.vat,
    required this.deliveryCharge,
  });

//: implement map key constants,toMap, fromMap

  Map<String, dynamic> toMap() => <String, dynamic>{
        orderConstantFieldDiscount: discount,
        orderConstantFieldVat: vat,
        orderConstantFieldDeliveryCharge: deliveryCharge,
      };

  factory OrderConstantModel.fromMap(Map<String, dynamic> map) =>
      OrderConstantModel(
        discount: map[orderConstantFieldDiscount],
        vat: map[orderConstantFieldVat],
        deliveryCharge: map[orderConstantFieldDeliveryCharge],
      );
}
