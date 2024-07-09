import 'package:sorteiadate/model/lanche_tarde.dart';

abstract class LancheTardeRepository {
  Future<int> insertLancheTarde(LancheTarde lancheTarde);
  Future<List<LancheTarde>> getAllLancheTarde();
  Future<List<LancheTarde>> getAllLancheTardePorClima(int climaId);
  Future<LancheTarde> sortearLancheTardePorClima(int climaId);
  Future<int> updateLancheTarde(LancheTarde lancheTarde);
  Future<int> deleteLancheTarde(int id);
}
