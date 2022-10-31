import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin/models/address_model.dart';

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

//TODO: implement map key constants,toMap, fromMap
}