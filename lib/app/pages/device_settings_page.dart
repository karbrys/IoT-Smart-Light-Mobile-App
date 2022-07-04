import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../utils/color.dart';
import '../utils/requests.dart';
import 'home_page.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DeviceSettings extends StatefulWidget {
  Global global;

  DeviceSettings({Key? key, required this.global}) : super(key: key);

  @override
  State<DeviceSettings> createState() => _DeviceSettingsState(global);
}

class _DeviceSettingsState extends State<DeviceSettings> {
  var redrawObject = Object();
  Global global;

  _DeviceSettingsState(this.global);

  Timer? _debounce;

  _onColorChanged(Color colorTemp) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      postDataColor(colorTemp);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Device Settings',
          style: GoogleFonts.arsenal(fontSize: 28.0),
        ),
      ),
      body: _buildBody(context),
    );
  }

  SingleChildScrollView _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: Stack(
            //fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 120.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/images/lamp.png'),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 40.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Lamp #1',
                      style: GoogleFonts.arsenal(fontSize: 28.0),
                    ),
                  ),
                  SizedBox(height: 50.0),
                  IgnorePointer(
                    ignoring: this.global.isSwitchedAutoMode ||
                        this.global.isNotConnected,
                    child: SleekCircularSlider(
                      initialValue: this.global.circularSliderValue,
                      max: 100,
                      appearance: CircularSliderAppearance(
                        infoProperties: InfoProperties(
                          mainLabelStyle: GoogleFonts.arsenal(fontSize: 28.0),
                          topLabelStyle: GoogleFonts.arsenal(fontSize: 23.0),
                          topLabelText: "Brightness",
                        ),
                        angleRange: 300,
                        startAngle: 120,
                        size: MediaQuery.of(context).size.width * 0.5,
                        customColors: CustomSliderColors(
                          dotColor: this.global.isSwitchedAutoMode ||
                                  this.global.isNotConnected
                              ? Color.fromRGBO(197, 197, 197, 1.0)
                              : Color.fromRGBO(255, 207, 115, 1.0),
                          hideShadow: true,
                          progressBarColor: this.global.isSwitchedAutoMode ||
                                  this.global.isNotConnected
                              ? Color.fromRGBO(197, 197, 197, 1.0)
                              : Color.fromRGBO(255, 207, 115, 1.0),
                          trackColor: Color.fromRGBO(217, 217, 217, 1.0),
                        ),
                        customWidths: CustomSliderWidths(
                          progressBarWidth: 8.0,
                          handlerSize: 10.0,
                        ),
                      ),
                      onChange: (value) {
                        setState(() {
                          value = value / 100;
                          String valueString = value.toStringAsFixed(2);
                          double valueRounded = double.parse(valueString);
                          this.global.color =
                              HSLColor.fromColor(this.global.color)
                                  .withLightness(valueRounded)
                                  .toColor();
                          redrawObject = Object();
                          this.global.circularSliderValue = valueRounded * 100;
                          _onColorChanged(this.global.color);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Container(
                    height: 50.0,
                    decoration: buildBoxDecoration(context, 10.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'Auto mode',
                                style: GoogleFonts.arsenal(fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Transform.scale(
                            scale: 0.7,
                            child: IgnorePointer(
                              ignoring: this.global.isNotConnected,
                              child: CupertinoSwitch(
                                activeColor: Color.fromRGBO(50, 74, 154, 1.0),
                                value: this.global.isSwitchedAutoMode,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      this.global.isSwitchedAutoMode = value;
                                    },
                                  );
                                  int val = (value) ? 1 : 0;
                                  redrawObject = Object();
                                  postDataAutoMode(val);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    height: 50.0,
                    decoration: buildBoxDecoration(context, 10.0),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Text(
                          'Warm',
                          style: GoogleFonts.arsenal(fontSize: 18.0),
                        ),
                        Expanded(
                          child: IgnorePointer(
                            ignoring: this.global.isNotConnected,
                            child: Slider(
                              value: this.global.warmColdSliderValue,
                              min: 1800,
                              max: 10000,
                              activeColor: Color.fromRGBO(197, 197, 197, 1.0),
                              inactiveColor: Color.fromRGBO(215, 215, 215, 1.0),
                              onChanged: (value) => setState(
                                () {
                                  this.global.warmColdSliderValue = value;
                                  this.global.colorTemperature = colorTempToRGB(
                                      this.global.warmColdSliderValue);
                                  this.global.color =
                                      this.global.colorTemperature;
                                  redrawObject = Object();
                                  _onColorChanged(this.global.color);
                                },
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Cold',
                          style: GoogleFonts.arsenal(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    height: 250.0,
                    decoration: buildBoxDecoration(context, 10.0),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Color',
                                style: GoogleFonts.arsenal(fontSize: 20.0),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: this.global.color,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                        ),
                        IgnorePointer(
                          ignoring: this.global.isNotConnected,
                          child: buildColorPicker(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildColorPicker() {
    return SlidePicker(
        key: ValueKey<Object>(redrawObject),
        pickerColor: this.global.color,
        enableAlpha: false,
        showIndicator: false,
        onColorChanged: (color) => setState(() {
              this.global.color = color;
              _onColorChanged(this.global.color);
            }));
  }

  _handleGoBack() {
    Navigator.pop(context, global);
  }
}
