import 'package:flutter/material.dart';
import 'package:qr_code/pages/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0XFF152542),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0XFF476499))),
      home: const QrHomePage(),
    );
  }
}
