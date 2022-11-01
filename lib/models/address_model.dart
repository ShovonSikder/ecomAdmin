const String addressFieldAddressLine1 = 'addressLine1';
const String addressFieldAddressLine2 = 'addressLine2';
const String addressFieldCity = 'city';
const String addressFieldZipCode = 'zipCode';

class AddressModel {
  String addressLine1;
  String addressLine2;
  String city;
  String zipCode;

  AddressModel({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.zipCode,
  });
//: implement map key constants,toMap, fromMap || no collection
  Map<String, dynamic> toMap() => <String, dynamic>{
        addressFieldAddressLine1: addressLine1,
        addressFieldAddressLine2: addressLine2,
        addressFieldCity: city,
        addressFieldZipCode: zipCode,
      };

  factory AddressModel.fromMap(Map<String, dynamic> map) => AddressModel(
        addressLine1: map[addressFieldAddressLine1],
        addressLine2: map[addressFieldAddressLine2],
        city: map[addressFieldCity],
        zipCode: map[addressFieldZipCode],
      );
}
