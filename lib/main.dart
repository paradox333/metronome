import 'package:flutter/material.dart';
import 'package:iacc_metronomo/screen.dart';
import 'package:iacc_metronomo/screen1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'screen',
      routes: {
        'screen': (_) => ScreenPage1()
      }
        
      );
  }
}