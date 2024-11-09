import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gu_cards/components/card_list.dart';
import 'package:gu_cards/components/card_fillter.dart';
import 'package:gu_cards/models/card.model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<GUCard> cards = [];
  List<GUCard> filteredCards = [];
  final TextEditingController _searchController = TextEditingController();

  String searchQuery = "";
  String selectedSet = "All";
  String selectedRarity = "All";
  String selectedTribe = "All";
  String selectedGod = "All";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final String response = await rootBundle.loadString('assets/cards.json');
    final data = json.decode(response) as List<dynamic>;
    final converted = data.map((e) => GUCard.fromJson(e)).toList();
    setState(() {
      cards = converted;
      filteredCards = List.from(cards);
    });
  }

  void _onSearchSubmitted(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      List<GUCard> result = cards;
      if (searchQuery.isNotEmpty) {
        result = cards
            .where((card) => card.name.toLowerCase().contains(searchQuery))
            .toList();
      }

      filteredCards = result.where((card) {
        final matchesSet = selectedSet == "All" ||
            selectedSet.toLowerCase().contains(card.set);
        final matchesRarity = selectedRarity == "All" ||
            card.rarity.toLowerCase() == selectedRarity.toLowerCase();
        final matchesTribe = selectedTribe == "All" ||
            card.tribe.tribe.toLowerCase() == selectedTribe.toLowerCase();
        final matchesGod = selectedGod == "All" ||
            card.god.toLowerCase() == selectedGod.toLowerCase();
        return matchesSet && matchesRarity && matchesTribe && matchesGod;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 234, 234, 234),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: TextFormField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: "Search cards...",
              border: InputBorder.none,
            ),
            onFieldSubmitted: _onSearchSubmitted,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Filters",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                CardFilters(
                  selectedSet: selectedSet,
                  selectedRarity: selectedRarity,
                  selectedTribe: selectedTribe,
                  selectedGod: selectedGod,
                  onFilteredCardsChanged: (set, rarity, tribe, god) {
                    setState(() {
                      selectedSet = set;
                      selectedRarity = rarity;
                      selectedTribe = tribe;
                      selectedGod = god;
                    });
                    _applyFilters();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: CardList(cards: filteredCards),
      ),
    );
  }
}
