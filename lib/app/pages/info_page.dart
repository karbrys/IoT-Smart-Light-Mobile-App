import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: _buildBody(context),
      ),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return Stack(
    children: [
      Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 250.0,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: buildBoxDecoration(context, 10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'SmartLight Mobile App',
                    style: GoogleFonts.arsenal(
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'This app was created as a term project at the Silesian University of Technology.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.arsenal(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 90.0,
                  ),
                  Text(
                    '© 2022',
                    style: GoogleFonts.arsenal(
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
