import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../drawer/header_drawer.dart';
import '../utils/app_pages.dart';
import 'home_page.dart';
import 'info_page.dart';
import 'settings_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  var currentPage = DrawerSections.home;

  @override
  Widget build(BuildContext context) {
    var container;

    switch (currentPage) {
      case DrawerSections.home:
        container = HomePage();
        break;
      case DrawerSections.settings:
        container = SettingsPage();
        break;
      case DrawerSections.info:
        container = InfoPage();
        break;
    }

    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        child: container,
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                HeaderDrawer(),
                ListDrawer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ListDrawer() {
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          MenuItem(0, 'Home', Icons.home_filled,
              currentPage == DrawerSections.home ? true : false),
          MenuItem(1, 'Settings', Icons.settings_rounded,
              currentPage == DrawerSections.settings ? true : false),
          MenuItem(2, 'Info', Icons.info_outline_rounded,
              currentPage == DrawerSections.info ? true : false),
        ],
      ),
    );
  }

  Widget MenuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            switch (id) {
              case 0:
                currentPage = DrawerSections.home;
                break;
              case 1:
                currentPage = DrawerSections.settings;
                break;
              case 2:
                currentPage = DrawerSections.info;
                break;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 25.0,
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.arsenal(fontSize: 25.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        'SmartLight',
        style: GoogleFonts.arsenal(fontSize: 32.0),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Transform.scale(
            scale: 0.8,
            child: Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? 'assets/images/icon_no_background_no_circle_white.png'
                  : 'assets/images/icon_no_background_no_circle_black.png',
            ),
          ),
        )
      ],
      toolbarHeight: 70,
    );
  }
}
