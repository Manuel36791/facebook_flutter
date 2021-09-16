import 'package:facebook_flutter/modules/navigation_screen/navigation_screen.dart';
import 'package:facebook_flutter/shared/colors/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facebook UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: MyPallette.scaffold,
      ),
      // ignore: prefer_const_constructors
      home: NavigationScreen(),
    );
  }
}
