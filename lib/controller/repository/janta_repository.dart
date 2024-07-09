import 'package:sorteiadate/model/janta.dart';

abstract class JantaRepository {
  Future<int> insertJanta(Janta janta);
  Future<List<Janta>> getAllJanta();
  Future<List<Janta>> getAllJantaPorClima(int climaId);
  Future<Janta> sortearJantaPorClima(int climaId);
  Future<int> updateJanta(Janta janta);
  Future<int> deleteJanta(int id);
}
