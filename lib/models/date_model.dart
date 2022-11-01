import 'package:cloud_firestore/cloud_firestore.dart';

const dateModelFieldTimestamp = 'timestamp';
const dateModelFieldDay = 'day';
const dateModelFieldMonth = 'month';
const dateModelFieldYear = 'year';

class DateModel {
  Timestamp timestamp;
  num day, month, year;

  DateModel({
    required this.timestamp,
    required this.day,
    required this.month,
    required this.year,
  });

  //: implement map key constants,toMap, fromMap || no collection
  Map<String, dynamic> toMap() => <String, dynamic>{
        dateModelFieldTimestamp: timestamp,
        dateModelFieldDay: day,
        dateModelFieldMonth: month,
        dateModelFieldYear: year,
      };

  factory DateModel.fromMap(Map<String, dynamic> map) => DateModel(
        timestamp: map[dateModelFieldTimestamp],
        day: map[dateModelFieldDay],
        month: map[dateModelFieldMonth],
        year: map[dateModelFieldYear],
      );
}
