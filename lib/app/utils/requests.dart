import 'dart:convert';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'color.dart';
import 'start_status.dart';

Future<StartStatus> fetchStartStatus() async {
  final response = await http.post(Uri.parse("https://"),
      body: json.encode({
        "methodName": "getStatus",
        "responseTimeoutInSeconds": 5,
      }));

  if (response.statusCode == 200) {
    return StartStatus.fromJson(jsonDecode(response.body));
  } else {
    Fluttertoast.showToast(
        msg: "Device is not available :(",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
    throw Exception('Failed to load start status.');
  }
}

postDataColor(Color color) async {
  final colorFormat = changeColorFormat(color.red, color.green, color.blue);
  try {
    var response = await http.post(Uri.parse("https://"),
        body: json.encode({
          "methodName": "setColor",
          "responseTimeoutInSeconds": 5,
          "payload": colorFormat,
        }));
  } catch (e) {
    print("Error: $e");
  }
}

postDataAutoMode(int value) async {
  try {
    var response = await http.post(Uri.parse("https://"),
        body: json.encode({
          "methodName": "setMode",
          "responseTimeoutInSeconds": 5,
          "payload": value.toString(),
        }));
  } catch (e) {
    print("Error: $e");
  }
}

postDataOnOff(int value) async {
  try {
    var response = await http.post(Uri.parse("https://"),
        body: json.encode({
          "methodName": "toggleLed",
          "responseTimeoutInSeconds": 5,
          "payload": value.toString(),
        }));
  } catch (e) {
    print("Error: $e");
  }
}
