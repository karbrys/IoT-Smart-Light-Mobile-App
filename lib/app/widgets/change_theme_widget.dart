import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:iotss_app/app/providers/theme_provider.dart';

class ChangeThemeWidget extends StatelessWidget {
  const ChangeThemeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return CupertinoSwitch(
      activeColor: Color.fromRGBO(255, 207, 115, 1.0),
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}
