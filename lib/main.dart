import 'package:flutter/material.dart';
import 'package:pokemesa/domains/cards/core/card.dart';
import 'package:pokemesa/views/private_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeMesa',
      theme: ThemeData.dark(),
      home: PrivateHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}



