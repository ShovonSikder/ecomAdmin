import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin/models/address_model.dart';

const String collectionUser = 'users';
const String userFieldUserId = 'userId';
const String userFieldDisplayName = 'displayName';
const String userFieldAddressModel = 'addressModel';
const String userFieldUserCreationTime = 'userCreationTime';
const String userFieldUserImageUrl = 'userImageUrl';
const String userFieldGender = 'gender';
const String userFieldAge = 'age';
const String userFieldPhone = 'phone';
const String userFieldEmail = 'email';

class UserModel {
  String? userId;
  String? displayName;
  AddressModel? addressModel;
  Timestamp? userCreationTime;
  String? userImageUrl;
  String? gender;
  num? age;
  String? phone;
  String email;

  UserModel({
    this.userId,
    this.displayName,
    this.addressModel,
    this.userCreationTime,
    this.userImageUrl,
    this.gender,
    this.age,
    this.phone,
    required this.email,
  });

//: implement map key constants,toMap, fromMap
  Map<String, dynamic> toMap() => <String, dynamic>{
        userFieldUserId: userId,
        userFieldDisplayName: displayName,
        userFieldAddressModel: addressModel?.toMap(),
        userFieldUserCreationTime: userCreationTime,
        userFieldUserImageUrl: userImageUrl,
        userFieldGender: gender,
        userFieldAge: age,
        userFieldPhone: phone,
        userFieldEmail: email,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        userId: map[userFieldUserId],
        addressModel: map[userFieldAddressModel] != null
            ? AddressModel.fromMap(map[userFieldAddressModel])
            : null,
        age: map[userFieldAge],
        displayName: map[userFieldDisplayName],
        gender: map[userFieldGender],
        phone: map[userFieldPhone],
        userCreationTime: map[userFieldUserCreationTime],
        userImageUrl: map[userFieldUserImageUrl],
        email: map[userFieldEmail],
      );
}
