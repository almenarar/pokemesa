import 'package:pokemesa/domains/cards/infra/db.dart';
import 'package:pokemesa/domains/cards/core/card.dart';

class CardService {
  final CardDB _cardDB;

  CardService(this._cardDB);

  Future<void> createCard(PokemonCard card) async {
    _cardDB.addCard(card);
    return;
  }

  Future<void> createHighlightCard(PokemonCard card) async {
    _cardDB.addHighlightCard(card);
    return;
  }

  Future<PokemonCard?> getCardById(int id) async {
    return _cardDB.getCard(id);
  }

  Future<List<PokemonCard>> getAllCards() async {
    return _cardDB.getAllCards();
  }

  Future<List<PokemonCard>> getAllHighlightCards() async {
    return _cardDB.getAllHighLightCards();
  }

  Future<void> updateCard(int id, PokemonCard card) async {
    _cardDB.updateCard(id, card);
    return ;
  }

  Future<void> deleteCard(int id) async {
     _cardDB.deleteCard(id);
  }
}