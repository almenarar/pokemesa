import 'package:flutter/material.dart';
import 'package:pokemesa/domains/cards/core/card.dart';
import 'package:pokemesa/views/card_detail.dart';
import 'package:pokemesa/views/commons.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({super.key, required this.query});

  final String query;

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  Future<List<PokemonCard>> _fetchResults() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    List<PokemonCard> database = [
      PokemonCard(
        id: "",
        pokemon: "Pikachu",
        imageURL: "https://images.pokemontcg.io/base1/58.png",
        collection: "Base Set",
        price: 25.99,
        rarity: "Common",
      ),
      PokemonCard(
        id: "",
        pokemon: "Pikachu",
        imageURL: "https://images.pokemontcg.io/xy10/42.png",
        collection: "Fates Collide",
        rarity: "Rare",
        price: 18.99,
      ),
      PokemonCard(
        id: "",
        pokemon: "Pikachu",
        imageURL: "https://images.pokemontcg.io/sm12/55.png",
        collection: "Cosmic Eclipse",
        rarity: "Ultra Rare",
        price: 39.99,
      ),
      PokemonCard(
        id: "",
        pokemon: "Pikachu",
        imageURL: "https://images.pokemontcg.io/base1/4.png",
        collection: "Base Set",
        price: 299.99,
        rarity: "Rare Holo",
      ),
      PokemonCard(
        id: "",
        pokemon: "Pikachu",
        imageURL: "https://images.pokemontcg.io/base1/44.png",
        collection: "Base Set",
        price: 10.50,
        rarity: "Common",
      ),
    ];
    return database
        .where((card) => card.pokemon.toLowerCase().startsWith(widget.query.toLowerCase()))
        .toList();
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
                          card.imageURL,
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
                                onPressed: () => print("Added ${card.pokemon} to collection"),
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