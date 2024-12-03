import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'presentation/home_page.dart';

void main() {
  runApp(BarbershopApp());
}

class BarbershopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Barbershops',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: BarbershopHomePage(),
    );
  }
}
