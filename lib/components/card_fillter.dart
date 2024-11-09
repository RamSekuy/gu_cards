import 'package:flutter/material.dart';
import 'package:gu_cards/components/dropdown_fillter.dart';

class CardFilters extends StatefulWidget {
  const CardFilters({
    super.key,
    required this.onFilteredCardsChanged,
    required this.selectedSet,
    required this.selectedRarity,
    required this.selectedTribe,
    required this.selectedGod,
  });

  final void Function(String, String, String, String) onFilteredCardsChanged;
  final String selectedSet;
  final String selectedRarity;
  final String selectedTribe;
  final String selectedGod;

  @override
  State<CardFilters> createState() => _CardFiltersState();
}

class _CardFiltersState extends State<CardFilters> {
  late String selectedSet;
  late String selectedTribe;
  late String selectedRarity;
  late String selectedGod;

  final List<String> cardSets = [
    "All",
    "Genesis",
    "Trial of the Gods",
    "Divine Order",
    "Mortal Judgment",
    "Winter Wanderlands",
    "Band of the Wolf",
    "Tides of Fate",
    "Dread Awakening",
    "Tower of dread"
  ];

  final List<String> cardTribes = [
    "All",
    "Amazon",
    "Atlantean",
    "Dragon",
    "Guild",
    "Mystic",
    "Nether",
    "Olympian",
    "Anubian",
    "Viking",
  ];

  final List<String> cardRarities = [
    "All",
    "Common",
    "Rare",
    "Epic",
    "Legendary",
  ];

  final List<String> cardGods = [
    "All",
    "Nature",
    "Light",
    "Death",
    "War",
    "Magic",
    "Deception",
  ];

  @override
  void initState() {
    super.initState();
    selectedSet = widget.selectedSet;
    selectedRarity = widget.selectedRarity;
    selectedTribe = widget.selectedTribe;
    selectedGod = widget.selectedGod;
  }

  void _applyFilters() {
    widget.onFilteredCardsChanged(
        selectedSet, selectedRarity, selectedTribe, selectedGod);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownFilter(
          label: "Set",
          value: selectedSet,
          items: cardSets,
          onChanged: (value) {
            setState(() {
              selectedSet = value!;
            });
            _applyFilters();
          },
        ),
        DropdownFilter(
          label: "Rarity",
          value: selectedRarity,
          items: cardRarities,
          onChanged: (value) {
            setState(() {
              selectedRarity = value!;
            });
            _applyFilters();
          },
        ),
        DropdownFilter(
          label: "Tribe",
          value: selectedTribe,
          items: cardTribes,
          onChanged: (value) {
            setState(() {
              selectedTribe = value!;
            });
            _applyFilters();
          },
        ),
        DropdownFilter(
          label: "God",
          value: selectedGod,
          items: cardGods,
          onChanged: (value) {
            setState(() {
              selectedGod = value!;
            });
            _applyFilters();
          },
        ),
      ],
    );
  }
}
