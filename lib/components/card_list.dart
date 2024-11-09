import 'package:flutter/material.dart';
import 'package:gu_cards/models/card.model.dart';

class CardList extends StatelessWidget {
  final List<GUCard> cards;

  const CardList({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards.isEmpty ? 1 : cards.length,
      itemBuilder: (context, index) {
        if (cards.isEmpty) {
          return const Center(child: Text("No Card"));
        }
        return CardDisplay(card: cards[index]);
      },
    );
  }
}

class CardDisplay extends StatelessWidget {
  const CardDisplay({super.key, required this.card});
  final GUCard card;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          card.img(),
          height: 400,
        ),
      ],
    );
  }
}
