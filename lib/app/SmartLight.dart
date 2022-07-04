import 'package:flutter/material.dart';
import 'package:iotss_app/app/pages/base_page.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';

class SmartLight extends StatelessWidget {
  const SmartLight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          home: BasePage(),
        );
      },
    );
  }
}
