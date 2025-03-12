import 'package:flutter/material.dart';
import 'package:pokemesa/domains/cards/core/card.dart';
import 'package:pokemesa/domains/cards/core/domain.dart';
import 'package:pokemesa/views/card_detail.dart';

class EditCollectionPage extends StatefulWidget {
  const EditCollectionPage({super.key, required this.cardService});

  final CardService cardService;

  @override
  _EditCollectionPageState createState() => _EditCollectionPageState();
}

class _EditCollectionPageState extends State<EditCollectionPage> {
  TextEditingController _searchController = TextEditingController();

  Future<List<PokemonCard>> _fetchResults() async {
    return widget.cardService.getAllCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar coleção'),
      ),
      body:  SingleChildScrollView( child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Buscar por pokemon, coleção ou id',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
            )),
            SizedBox(height: 16.0),
            SizedBox(
              height: 700,
            child: FutureBuilder<List<PokemonCard>>(
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
                                      onPressed: () => widget.cardService.deleteCard(card.id),
                                      child: Text("Remover da coleção"),
                                    ),
                                    SizedBox(height: 13),
                                    ElevatedButton(
                                      onPressed: () => widget.cardService.createHighlightCard(card),
                                      child: Text("Adicionar aos favoritos"),
                                    ),
                                    SizedBox(height: 13),
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
        )],
        ),
      ),
    );
  }
}