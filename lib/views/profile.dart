import 'package:flutter/material.dart';
import 'package:pokemesa/domains/cards/core/card.dart';
import 'package:pokemesa/domains/cards/core/domain.dart';
import 'package:pokemesa/views/commons.dart';

class ProfilePage extends StatefulWidget {
  final CardService cardService;

  const ProfilePage({super.key, required this.cardService});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int amountOfTabs = 3;

  List<PokemonCard> full = [];

  List<PokemonCard> highlightCards = [];

  final String userName = "Ash Ketchum";
  final int totalCards = 250;
  final String avatar = "images/ash.jpg";


  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    var lowcard = await widget.cardService.getAllCards();
      var highcard = await widget.cardService.getAllHighlightCards();
    setState(() {
      full = lowcard;
      highlightCards = highcard;
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
        itemCount: highlightCards.isEmpty ? 1 : highlightCards.length,
        itemBuilder: (context, index) {
          if (highlightCards.isEmpty) {
                return Text("Você ainda não possui cartas");
              }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () => _showImagePopup(context, highlightCards[index].imageURL),
              child: Image.network("${highlightCards[index].imageURL}/low.png", width: 200, height: 220),
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
            itemCount: full.isEmpty ? 1 : full.length,
            itemBuilder: (context, index) {
              if (full.isEmpty) {
                return Text("Você ainda não possui cartas");
              }
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