import 'dart:convert';

import 'package:equatable/equatable.dart';

class PokemonCard extends Equatable {
  final int id;
  final String pokemon;
  final String collection;
  final String imageURL;
  final double price;
  final String rarity;

  const PokemonCard({
    required this.id,
    required this.pokemon,
    required this.collection,
    required this.imageURL,
    required this.price,
    required this.rarity,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['ID'] as int,
      pokemon: Utf8Decoder().convert(json['Pokemon'].toString().codeUnits),
      collection: json['Collection'] as String,
      imageURL: json['ImageURL'] as String,
      price: json['Price'] as double,
      rarity: json['Rarity'] as String,
    );
  }

  @override
  List<Object> get props =>
      [id, pokemon, collection];
}