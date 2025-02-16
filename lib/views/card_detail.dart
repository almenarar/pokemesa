import 'package:flutter/material.dart';
import 'package:pokemesa/domains/cards/core/card.dart';

class CardDetailPage extends StatefulWidget {
  final PokemonCard card;

  CardDetailPage({super.key, required this.card});

  @override
  _CardDetailPageState createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  // State variables for tracking button clicks (e.g., Collection, Wishlist)
  bool isInCollection = false;
  bool isInWishlist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.card.pokemon),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Large Image
            Center(
              child: Image.network(
                widget.card.imageURL,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),

            // Detailed Information
            Text(
              "Collection: ${widget.card.collection}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Rarity: ${widget.card.rarity}",
              style: TextStyle(fontSize: 16, color: Colors.orange),
            ),
            SizedBox(height: 10),
            Text(
              "Price: \$${widget.card.price.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 20),
            Text(
              "Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus imperdiet, nulla et dictum interdum, nisi lorem egestas odio, vitae scelerisque enim ligula venenatis dolor. Maecenas nisl est, ultrices nec congue eget, auctor vitae massa. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut placerat orci. Nullam at arcu a est sollicitudin euismod. Phasellus a est sit amet magna feugiat.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),

            // Buttons Row (Include in Collection, Wishlist, See Seller)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isInCollection = !isInCollection;
                    });
                    print(isInCollection ? "Added to Collection" : "Removed from Collection");
                  },
                 style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreenAccent),
                  child: Text(isInCollection ? "Remover da coleção" : "Incluir na coleção",style:  TextStyle(color: Colors.black),),
                ),
                SizedBox(height: 12,),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isInWishlist = !isInWishlist;
                    });
                    print(isInWishlist ? "Incluir na lista de desejos" : "Remover da lista de desejos",);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreenAccent),
                  child: Text(isInWishlist ? "Remover da lista de desejos" : "Lista de desejos",style:  TextStyle(color: Colors.black),),
                ),
                SizedBox(height: 12,),
                ElevatedButton(
                  onPressed: () {
                    print("See who is selling ${widget.card.pokemon}");
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreenAccent),
                  child: Text("Ver quem está vendendo",style:  TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }
}
