import 'package:flutter/material.dart';
import 'package:pokemesa/domains/cards/core/card.dart';
import 'package:pokemesa/domains/cards/core/domain.dart';
import 'package:pokemesa/views/card_detail.dart';
import 'package:pokemesa/views/commons.dart';
import 'package:pokemesa/views/private_home.dart';

class SearchResultsPage extends StatefulWidget {


  const SearchResultsPage({super.key, required this.query, required this.cardService});

  final CardService cardService;
  final String query;

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  Future<List<PokemonCard>> _fetchResults() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    List<PokemonCard> database = [
      PokemonCard(
        id: 0,
        pokemon: "Pikachu",
        imageURL: "https://assets.tcgdex.net/pt/sv/sv08.5/179",
        collection: "Base Set",
        price: 25.99,
        rarity: "Common",
      ),
      PokemonCard(
        id: 0,
        pokemon: "Pupitar",
        imageURL: "https://assets.tcgdex.net/pt/sv/sv03/106",
        collection: "Fates Collide",
        rarity: "Rare",
        price: 18.99,
      ),
      PokemonCard(
        id: 0,
        pokemon: "Prinlup",
        imageURL: "https://assets.tcgdex.net/pt/xy/xy8/37",
        collection: "Cosmic Eclipse",
        rarity: "Ultra Rare",
        price: 39.99,
      ),
      PokemonCard(
        id: 0,
        pokemon: "Charizard",
        imageURL: "https://assets.tcgdex.net/pt/sv/sv03.5/006",
        collection: "Base Set",
        price: 299.99,
        rarity: "Rare Holo",
      ),
      PokemonCard(
        id: 0,
        pokemon: "Bulbasaur",
        imageURL: "https://assets.tcgdex.net/pt/swsh/swsh10.5/001",
        collection: "Base Set",
        price: 10.50,
        rarity: "Common",
      ),
    ];
    return database
        .where((card) => card.pokemon.toLowerCase().startsWith(widget.query.toLowerCase()))
        .toList();
  }

  void addInMyCollection(BuildContext context, PokemonCard card) async {
    await showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text("${card.pokemon} adicionado à sua coleção"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Valeu!"),
          ),
        ],
      );
    });
    await widget.cardService.createCard(card);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resultados para '${widget.query}'")),
      body: FutureBuilder<List<PokemonCard>>(
        future: _fetchResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhuma carta Pokemon encontrada."));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              PokemonCard card = snapshot.data![index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      // Large Image
                      SizedBox(
                        width: 120, // Increase width
                        height: 160, // Increase height
                        child: Image.network(
                          "${card.imageURL}/low.png",
                          fit: BoxFit.contain, // Ensure full image is visible
                        ),
                      ),
                      SizedBox(width: 10), // Space between image and text
                      // Card Details
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Card Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(card.pokemon, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Text("Coleção: ${card.collection}"),
                                  Text("Raridade: ${card.rarity}", style: TextStyle(color: Colors.orange)),
                                  SizedBox(height: 5),
                                  Text("\$${card.price.toStringAsFixed(2)}",
                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                                ],
                              ),
                            ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CardDetailPage(card: card), // Navigate to the detail page
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreenAccent),
                                child: Text("Ver detalhes", style:  TextStyle(color: Colors.black),)
                              ),
                              SizedBox(height: 13),
                              ElevatedButton(
                                onPressed: () => addInMyCollection(context, card),
                                child: Text("Minha coleção"),
                              ),
                              SizedBox(height: 13),
                              ElevatedButton(
                                onPressed: () => print("Added ${card.pokemon} to wishlist"),
                                child: Text("Lista de desejos"),
                              ),
                            ],
                          ),
                        ],
                      ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}