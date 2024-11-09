class GUCard {
  final int id;
  final String name;
  final String effect;
  final String god;
  final String rarity;
  final Tribe tribe;
  final int mana;
  final int attack;
  final int health;
  final String type;
  final String set;
  final bool collectable;
  final bool live;
  final String artId;
  final String libId;

  String img() {
    return "https://card.godsunchained.com/?q=1&id=$id";
  }

  GUCard({
    required this.id,
    required this.name,
    required this.effect,
    required this.god,
    required this.rarity,
    required this.tribe,
    required this.mana,
    required this.attack,
    required this.health,
    required this.type,
    required this.set,
    required this.collectable,
    required this.live,
    required this.artId,
    required this.libId,
  });

  // Fungsi untuk membuat objek GUCard dari JSON
  factory GUCard.fromJson(Map<String, dynamic> json) {
    return GUCard(
      id: json['id'],
      name: json['name'],
      effect: json['effect'],
      god: json['god'],
      rarity: json['rarity'],
      tribe: Tribe.fromJson(json['tribe']),
      mana: json['mana'],
      attack: json['attack']['Int64'],
      health: json['health']['Int64'],
      type: json['type'],
      set: json['set'],
      collectable: json['collectable'],
      live: json['live'] == 'true',
      artId: json['art_id'],
      libId: json['lib_id'],
    );
  }

  // Fungsi untuk mengonversi objek GUCard ke dalam format JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'effect': effect,
      'god': god,
      'rarity': rarity,
      'tribe': tribe.toJson(),
      'mana': mana,
      'attack': {'Int64': attack},
      'health': {'Int64': health},
      'type': type,
      'set': set,
      'collectable': collectable,
      'live': live ? 'true' : 'false',
      'art_id': artId,
      'lib_id': libId,
    };
  }
}

class Tribe {
  final String tribe;
  final bool valid;

  Tribe({
    required this.tribe,
    required this.valid,
  });

  factory Tribe.fromJson(Map<String, dynamic> json) {
    return Tribe(
      tribe: json['String'],
      valid: json['Valid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'String': tribe,
      'Valid': valid,
    };
  }
}
