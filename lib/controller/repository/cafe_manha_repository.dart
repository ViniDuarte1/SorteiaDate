import 'package:sorteiadate/model/cafe_manha.dart';

abstract class CafeManhaRepository {
  Future<int> insertCafeManha(CafeManha cafeManha);
  Future<List<CafeManha>> getAllCafeManha();
  Future<List<CafeManha>> getAllCafeManhaPorClima(int climaId);
  Future<CafeManha> sortearCafeManhaPorClima(int climaId);
  Future<int> updateCafeManha(CafeManha cafeManha);
  Future<int> deleteCafeManha(int id);
}
