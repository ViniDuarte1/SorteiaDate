import 'package:sorteiadate/model/atividade_noite.dart';

abstract class AtividadeNoiteRepository {
  Future<int> insertAtividadeNoite(AtividadeNoite atividadeNoite);
  Future<List<AtividadeNoite>> getAllAtividadeNoite();
  Future<List<AtividadeNoite>> getAllAtividadeNoitePorClima(int climaId);
  Future<AtividadeNoite> sortearAtividadeNoitePorClima(int climaId);
  Future<int> updateAtividadeNoite(AtividadeNoite atividadeNoite);
  Future<int> deleteAtividadeNoite(int id);
}
