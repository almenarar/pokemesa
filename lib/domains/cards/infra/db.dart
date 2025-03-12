import 'package:pokemesa/domains/cards/core/card.dart';

class CardDB {
  final Map<int, PokemonCard> _cards = {};
  final Map<int, PokemonCard> _highlightCards = {};
  int _currentId = 0;

  int addCard(PokemonCard card) {
    _currentId++;
    _cards[_currentId] = card;
    return _currentId;
  }

  int addHighlightCard(PokemonCard card) {
    _currentId++;
    _highlightCards[_currentId] = card;
    return _currentId;
  }

  PokemonCard? getCard(int id) {
    return _cards[id];
  }

  bool updateCard(int id, PokemonCard card) {
    if (_cards.containsKey(id)) {
      _cards[id] = card;
      return true;
    }
    return false;
  }

  bool deleteCard(int id) {
    return _cards.remove(id) != null;
  }

  List<PokemonCard> getAllCards() {
    return _cards.values.toList();
  }

  List<PokemonCard> getAllHighLightCards() {
    return _highlightCards.values.toList();
  }
}