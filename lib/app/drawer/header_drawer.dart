import 'package:flutter/material.dart';

class HeaderDrawer extends StatefulWidget {
  const HeaderDrawer({Key? key}) : super(key: key);

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 207, 115, 1.0),
      width: double.infinity,
      height: 200,
      padding:EdgeInsets.only(top: 20.0),
    );
  }
}
