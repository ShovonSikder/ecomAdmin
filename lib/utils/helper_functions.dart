import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
        ),
      ),
    );

getFormattedDate(DateTime date, {String pattern = 'dd//MM//yyyy'}) =>
    DateFormat(pattern).format(date);

Future<bool> isConnectedToInternet() async {
  var result = await Connectivity().checkConnectivity();
  return result == ConnectivityResult.wifi ||
      result == ConnectivityResult.mobile;
}
