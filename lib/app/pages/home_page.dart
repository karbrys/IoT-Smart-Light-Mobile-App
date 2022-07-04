import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:iotss_app/app/pages/device_settings_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/requests.dart';

import 'package:http/http.dart' as http;

import '../utils/start_status.dart';

getDataStartStatus() async {
  try {
    var response = await http.post(Uri.parse("https://"),
        body: json.encode({
          "methodName": "getStatus",
          "responseTimeoutInSeconds": 5,
        }));

    if (response.statusCode == 200) {
      StartStatus data = StartStatus.fromJson(jsonDecode(response.body));
      Global.shared.isSwitchedOnOff = data.isSwitchedOnOff;
      Global.shared.color =
          Color.fromRGBO(data.colorR, data.colorG, data.colorB, 1.0);
      Global.shared.isSwitchedAutoMode = data.isSwitchedAutoMode;
      Global.shared.isNotConnected = false;
    } else {
      Fluttertoast.showToast(
          msg: "Device is not available :(",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  } catch (e) {
    print("Error: $e");
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<StartStatus> startStatus;
  var redrawObject = Object();

  @override
  void initState() {
    super.initState();
    startStatus = fetchStartStatus();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StartStatus>(
        future: startStatus,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Global.shared.isSwitchedOnOff = snapshot.data!.isSwitchedOnOff;
            Global.shared.color = Color.fromRGBO(snapshot.data!.colorR,
                snapshot.data!.colorG, snapshot.data!.colorB, 1.0);
            Global.shared.isSwitchedAutoMode =
                snapshot.data!.isSwitchedAutoMode;
            Global.shared.isNotConnected = false;
          }
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2));
              getDataStartStatus();
            },
            color: Color.fromRGBO(50, 74, 154, 1.0),
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            child: ListView(
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 16.0, top: 30.0, right: 16.0, bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
                          child: Text(
                            'Your devices',
                            style: GoogleFonts.arsenal(
                              fontSize: 28.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 5.0),
                          child: Container(
                            height: 130.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: buildBoxDecoration(context, 25.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: _buildDeviceCard(),
                              onTap: () async {
                                final newGlobal =
                                    await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DeviceSettings(global: Global.shared),
                                  ),
                                );
                                if (newGlobal == Global()) {
                                  setState(() {
                                    Global.shared.isSwitchedOnOff =
                                        newGlobal.isSwitchedOnOff;
                                    Global.shared.color = newGlobal.color;
                                    Global.shared.isSwitchedAutoMode =
                                        newGlobal.isSwitchedAutoMode;
                                    Global.shared.colorTemperature =
                                        newGlobal.colorTemperature;
                                    Global.shared.warmColdSliderValue =
                                        newGlobal.warmColdSliderValue;
                                    Global.shared.circularSliderValue =
                                        newGlobal.circularSliderValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

BoxDecoration buildBoxDecoration(BuildContext context, double radius) {
  return BoxDecoration(
    color: Theme.of(context).primaryColor,
    borderRadius: BorderRadius.all(
      Radius.circular(radius),
    ),
    boxShadow: [
      BoxShadow(
        color: Theme.of(context).shadowColor,
        blurRadius: 10.0,
        spreadRadius: 5.0,
      )
    ],
  );
}

Container _buildDeviceCard() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Row(
          children: [
            Column(
              children: <Widget>[
                Container(
                  height: 100.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/images/lamp.png'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lamp #1',
                  style: GoogleFonts.arsenal(
                    fontSize: 24.0,
                  ),
                ),
                Text(
                  'Brightness:',
                  style: GoogleFonts.arsenal(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.0),
                Text(
                  Global.shared.circularSliderValue.toString() + "%",
                  style: GoogleFonts.arsenal(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: SwitchScreen(),
        ),
      ],
    ),
  );
}

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({Key? key}) : super(key: key);

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  @override
  Widget build(BuildContext context) {
    bool isSwitchedOnOff = Global.shared.isSwitchedOnOff;
    return Transform.scale(
      scale: 0.8,
      child: IgnorePointer(
        ignoring: Global.shared.isNotConnected,
        child: CupertinoSwitch(
          activeColor: Color.fromRGBO(50, 74, 154, 1.0),
          value: isSwitchedOnOff,
          onChanged: (value) {
            setState(
              () {
                Global.shared.isSwitchedOnOff = value;
              },
            );
            int val = (value) ? 1 : 0;
            postDataOnOff(val);
          },
        ),
      ),
    );
  }
}

class Global {
  static final shared = Global();
  bool isSwitchedOnOff = false;
  double warmColdSliderValue = 5900;
  Color color = Color.fromRGBO(255, 0, 0, 1.0);
  Color colorTemperature = Colors.white;
  bool isSwitchedAutoMode = false;
  double circularSliderValue = 50;
  bool isNotConnected = true;
}
