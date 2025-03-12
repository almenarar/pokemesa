import 'package:flutter/material.dart';
import 'package:pokemesa/domains/cards/core/domain.dart';
import 'package:pokemesa/domains/cards/infra/db.dart';
import 'package:pokemesa/views/private_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final CardService cardService = CardService(CardDB());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeMesa',
      theme: ThemeData.dark(),
      home: PrivateHomePage(cardService: cardService,),
      debugShowCheckedModeBanner: false,
    );
  }
}



