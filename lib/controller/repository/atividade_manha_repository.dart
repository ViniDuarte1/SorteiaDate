import 'package:sorteiadate/model/atividade_manha.dart';

abstract class AtividadeManhaRepository {
  Future<int> insertAtividadeManha(AtividadeManha atividadeManha);
  Future<List<AtividadeManha>> getAllAtividadeManha();
   Future<List<AtividadeManha>> getAllAtividadeManhaPorClima(int climaId);
  Future<AtividadeManha> sortearAtividadeManhaPorClima(int climaId);
  Future<int> updateAtividadeManha(AtividadeManha atividadeManha);
  Future<int> deleteAtividadeManha(int id);
}
