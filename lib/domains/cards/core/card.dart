import 'dart:convert';

import 'package:equatable/equatable.dart';

class Cards extends Equatable {
  final String id;
  final String pokemon;
  final String collection;
  final String imageURL;

  const Cards({
    required this.id,
    required this.pokemon,
    required this.collection,
    required this.imageURL,
  });

  factory Cards.fromJson(Map<String, dynamic> json) {
    return Cards(
      id: json['ID'] as String,
      pokemon: Utf8Decoder().convert(json['Pokemon'].toString().codeUnits),
      collection: json['Collection'] as String,
      imageURL: json['ImageURL'] as String,
    );
  }

  @override
  List<Object> get props =>
      [id, pokemon, collection];
}