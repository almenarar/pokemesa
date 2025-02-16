import 'package:flutter/material.dart';
import 'package:pokemesa/domains/cards/core/card.dart';
import 'package:pokemesa/views/commons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int amountOfTabs = 3;

  List<PokemonCard> full = [];

  final List<String> highlightCards = [
    "https://assets.tcgdex.net/en/xy/xyp/XY78",
    "https://assets.tcgdex.net/en/xy/xyp/XY78",
    "https://assets.tcgdex.net/en/xy/xyp/XY78",
    "https://assets.tcgdex.net/en/xy/xyp/XY78",
    "https://assets.tcgdex.net/en/xy/xyp/XY78",
  ];

  final String userName = "Ash Ketchum";
  final int totalCards = 250;
  final String avatar = "images/ash.jpg";


  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      full = [
        PokemonCard(id: "1", pokemon: "Chespin", collection: "xyp-XY88", imageURL: "https://assets.tcgdex.net/en/xy/xyp/XY88", price: 10, rarity: "Common"),
        PokemonCard(id: "1", pokemon: "Pikachu", collection: "xyp-XY89", imageURL: "https://assets.tcgdex.net/en/xy/xyp/XY89", price: 10, rarity: "Common"),
        PokemonCard(id: "1", pokemon: "Sableye", collection: "xyp-XY92", imageURL: "https://assets.tcgdex.net/en/xy/xyp/XY92", price: 10, rarity: "Common"),
        PokemonCard(id: "1", pokemon: "Umbreon", collection: "xyp-XY96", imageURL: "https://assets.tcgdex.net/en/xy/xyp/XY96", price: 10, rarity: "Common"),
        PokemonCard(id: "1", pokemon: "Regigigas", collection: "xyp-XY82", imageURL: "https://assets.tcgdex.net/en/xy/xyp/XY82", price: 10, rarity: "Common"),
        PokemonCard(id: "1", pokemon: "Pikachu EX", collection: "xyp-XY84", imageURL: "https://assets.tcgdex.net/en/xy/xyp/XY84", price: 10, rarity: "Common"),
        PokemonCard(id: "1", pokemon: "Champions Festival", collection: "xyp-XY91", imageURL: "https://assets.tcgdex.net/en/xy/xyp/XY91", price: 10, rarity: "Common")
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PokeMesa")),
      body: Container(
        decoration: backgroundDecoration(),
        child: SingleChildScrollView(
          child: DefaultTabController( 
            length: 3,
            child:Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildUserInfo(),
                  SizedBox(height: 16),
                 Text("Cartas favoritas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:  Colors.white)),
                 Divider(color: Colors.white,),
                  SizedBox(height: 12),
                  _buildHighlightCards(),
                  SizedBox(height: 16),
                  _tabBar(),
                  SizedBox(
                    height: 400,
                    child: TabBarView(
                      children: [
                        itemGridView(),
                        itemGridView(),
                        itemGridView()
                      ]
                    ),
                  )
                ],
              )
            ),
          )
        )
      )
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
    return Center(child:SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: highlightCards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () => _showImagePopup(context, highlightCards[index]),
              child: Image.network("${highlightCards[index]}/low.png", width: 200, height: 220),
            )
          );
        },
      ),
    ));
  }

  void _showImagePopup(BuildContext context, String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child:  Image.network(
            "$image/high.png", // replace with your image URL
            fit: BoxFit.cover,
          ),
          );
        
      },
    );
  }

  Widget _tabBar() {
    return  TabBar(
        labelPadding: const EdgeInsets.only(left: 18),
        tabAlignment: TabAlignment.center,
        unselectedLabelColor: Colors.white,
        dividerColor: Colors.white,
        labelColor: Colors.black,
        indicatorColor: Colors.white,
        indicator: const BoxDecoration(
          color: Colors.white,
        ),
        isScrollable: true, // Allows scrolling if there are too many tabs
        tabs: [
          Text("Minhas cartas", style: TextStyle( fontSize: 18),),
          Text("Cartas repetidas", style: TextStyle( fontSize: 18),),
          Text("Cartas desejadas", style: TextStyle( fontSize: 18),),
        ], 
      );
  }

  Widget itemGridView() {
    return LayoutBuilder(
        builder: (context, constraints) {
          // Calculate the number of columns based on screen width
          double screenWidth = constraints.maxWidth;
          int crossAxisCount = screenWidth > 1400 ? 6 : (screenWidth > 1000 ? 5 : (screenWidth > 600 ? 4 : (screenWidth > 400 ? 3 : 2)));
    
          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            shrinkWrap: true,
            //physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount, 
              crossAxisSpacing: 8, 
              mainAxisSpacing: 8
            ),
            itemCount: full.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _showImagePopup(context, full[index].imageURL),
                child: Image.network("${full[index].imageURL}/low.png", width: 80, height: 100),
              );
          }
        );
        },
    );
  }
}