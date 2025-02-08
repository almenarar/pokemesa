import 'package:flutter/material.dart';

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
      home: ProfilePage(),
      debugShowCheckedModeBanner: false,

    );
  }
}

class ProfilePage extends StatelessWidget {
  final String userName = "Ash Ketchum";
  final int totalCards = 250;
  final String avatar = "images/ash.jpg";
  final List<String> highlightCards = [
    "https://assets.tcgdex.net/en/xy/xyp/XY78/high.png",
    "https://assets.tcgdex.net/en/xy/xyp/XY78/high.png",
    "https://assets.tcgdex.net/en/xy/xyp/XY78/high.png",
    "https://assets.tcgdex.net/en/xy/xyp/XY78/high.png",
    "https://assets.tcgdex.net/en/xy/xyp/XY78/high.png",
  ];
  final List<String> allCards = List.generate(20, (index) => "https://assets.tcgdex.net/en/xy/xyp/XY78/low.png");

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PokeMesa")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/grass.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
        ),
      child:
SingleChildScrollView(child:  Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildUserInfo(),
                    SizedBox(height: 16),
                    Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text("Melhores cartas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:  Colors.white)),
                    ),
                    SizedBox(height: 12),
                    _buildHighlightCards(),
                    SizedBox(height: 16),
                    Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text("Todas as cartas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:  Colors.white)),
                    ),
                    _buildAllCards(),
                  ],
                ),
              ),
            ),
          ),
      );
  }

  Widget _buildUserInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(radius: 40, backgroundImage: AssetImage(avatar)),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            Text("Total de cartas: $totalCards", style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
      ],
    );
  }

  Widget _buildHighlightCards() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: highlightCards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () => _showImagePopup(context, highlightCards[index]),
              child: Image.network(highlightCards[index], width: 200, height: 220),
            )
          );
        },
      ),
    );
  }

  Widget _buildAllCards() {
    return LayoutBuilder(
        builder: (context, constraints) {
          // Calculate the number of columns based on screen width
          double screenWidth = constraints.maxWidth;
          int crossAxisCount = screenWidth > 1400 ? 6 : (screenWidth > 1000 ? 5 : (screenWidth > 600 ? 4 : (screenWidth > 400 ? 3 : 2)));

          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount, 
              crossAxisSpacing: 8, 
              mainAxisSpacing: 8
            ),
            itemCount: allCards.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _showImagePopup(context, highlightCards[index]),
                child: Image.network(allCards[index], width: 80, height: 100),
              );
          }
        );
        },
    );
  }

  void _showImagePopup(BuildContext context, String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child:  Image.network(
            image, // replace with your image URL
            fit: BoxFit.cover,
          ),
          );
        
      },
    );
  }
}

