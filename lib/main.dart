import 'package:flutter/material.dart';
import 'package:latihanresponsipam/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Space Flight News',
      home: MenuPage(),
    );
  }
}