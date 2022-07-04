import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/change_theme_widget.dart';
import 'home_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:
            EdgeInsets.only(left: 16.0, top: 30.0, right: 16.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              child: Text(
                'Settings',
                style: GoogleFonts.arsenal(
                  fontSize: 28.0,
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
              child: Container(
                height: 60.0,
                decoration: buildBoxDecoration(context, 10.0),
                child: _buildSettingsCard(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildSettingsCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Dark mode',
              style: GoogleFonts.arsenal(
                fontSize: 22.0,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Transform.scale(
              scale: 0.8,
              child: ChangeThemeWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
