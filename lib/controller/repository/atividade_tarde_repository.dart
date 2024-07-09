import 'package:sorteiadate/model/atividade_tarde.dart';

abstract class AtividadeTardeRepository {
  Future<int> insertAtividadeTarde(AtividadeTarde atividadeTarde);
  Future<List<AtividadeTarde>> getAllAtividadeTarde();
  Future<List<AtividadeTarde>> getAllAtividadeTardePorClima(int climaId);
  Future<AtividadeTarde> sortearAtividadeTardePorClima(int climaId);
  Future<int> updateAtividadeTarde(AtividadeTarde atividadeTarde);
  Future<int> deleteAtividadeTarde(int id);
}
