import 'package:flutter/material.dart';
import 'package:pokemesa/domains/cards/core/domain.dart';
import 'package:pokemesa/views/commons.dart';
import 'package:pokemesa/views/edit_collection.dart';
import 'package:pokemesa/views/profile.dart';
import 'package:pokemesa/views/search_results.dart';

class PrivateHomePage extends StatefulWidget {
  final CardService cardService;

  const PrivateHomePage({super.key, required this.cardService});

  @override
  State<PrivateHomePage> createState() => _PrivateHomePageState();
}

class _PrivateHomePageState extends State<PrivateHomePage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> actions = [
    "Ver meu perfil público", 
    "Editar minha coleção",
    "Lista de desejos",
    "Minhas conversas",
    "Meus amigos",
    "Gerenciar minha conta",
  ];

  final List<IconData> actionIcons = [
    Icons.watch,
    Icons.edit,
    Icons.edit,
    Icons.edit,
    Icons.edit,
    Icons.edit
  ];

  late List<Widget> actionDestinations;

  @override
  void initState() {
    super.initState();
    actionDestinations = [
      ProfilePage(cardService: widget.cardService,),
      EditCollectionPage(cardService: widget.cardService,),
      ProfilePage(cardService: widget.cardService,),
      ProfilePage(cardService: widget.cardService,),
      ProfilePage(cardService: widget.cardService,),
      ProfilePage(cardService: widget.cardService,),
    ];
  }

  void _search(BuildContext context) {
    String query = _searchController.text.trim();
    if (query.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchResultsPage(query: query, cardService: widget.cardService,)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PokeMesa")),
      body: Container(
        height: 900,
        decoration: backgroundDecoration(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              searchBar(),
              actionsGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return  Padding(
      padding: EdgeInsets.all(10),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 350,
            child:TextField(
              controller: _searchController,
              onSubmitted: (_) => _search(context),
              decoration: InputDecoration(
                labelText: "Digite id, nome ou coleção",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),  
          ),
          SizedBox(width: 8,),
          ElevatedButton(
            onPressed: () => _search(context),
            child: Text("Buscar"),
          ),
        ],
      ),
    );
  }

  Widget actionsGrid() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double screenWidth = constraints.maxWidth;
        int crossAxisCount = screenWidth > 1200 ? 4 : (screenWidth > 700 ? 3 : (screenWidth > 450 ? 2 : 2));

        return GridView.builder(
            padding: EdgeInsets.all(15.0),
            shrinkWrap: true,
            //physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:crossAxisCount, 
              crossAxisSpacing: 15, 
              mainAxisSpacing: 15,
              childAspectRatio: 2
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => actionDestinations[index]),
                ),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    color: Colors.lightGreenAccent.withValues(alpha: 80)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(actionIcons[index]),
                      SizedBox(width: 8,),
                      Text(
                        actions[index],
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54    ,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ]
                  ),
                ),
              );
          }
        );
      }
    );
  }
}