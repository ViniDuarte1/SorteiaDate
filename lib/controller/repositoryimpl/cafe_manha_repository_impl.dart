import 'dart:math';

import 'package:sorteiadate/controller/database/database_helper.dart';
import 'package:sorteiadate/model/cafe_manha.dart';
import 'package:sorteiadate/controller/repository/cafe_manha_repository.dart';

class CafeManhaRepositoryImpl implements CafeManhaRepository {
  @override
  Future<int> insertCafeManha(CafeManha cafeManha) async {
    final db = await DatabaseHelper.database;
    return await db.insert('cafe_manha', cafeManha.toMap());
  }

  @override
  Future<List<CafeManha>> getAllCafeManha() async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('cafe_manha');
    return List.generate(maps.length, (i) {
      return CafeManha(
        id: maps[i]['id'],
        descricao: maps[i]['descricao'],
        climaId: maps[i]['clima_id'],
      );
    });
  }

  @override
  Future<List<CafeManha>> getAllCafeManhaPorClima(int climaId) async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cafe_manha',
      where: 'clima_id = ?',
      whereArgs: [climaId],
    );
    return List.generate(maps.length, (i) {
      return CafeManha(
        id: maps[i]['id'],
        descricao: maps[i]['descricao'],
        climaId: maps[i]['clima_id'],
      );
    });
  }

  @override
  Future<CafeManha> sortearCafeManhaPorClima(int climaId) async {
    final cafesManha = await getAllCafeManhaPorClima(climaId);
    if (cafesManha.isEmpty) {
      throw Exception('Não há cafés da manhã disponíveis para esse clima.');
    }
    final random = Random();
    final int index = random.nextInt(cafesManha.length);
    return cafesManha[index];
  }

  @override
  Future<int> updateCafeManha(CafeManha cafeManha) async {
    final db = await DatabaseHelper.database;
    return await db.update(
      'cafe_manha',
      cafeManha.toMap(),
      where: 'id = ?',
      whereArgs: [cafeManha.id],
    );
  }

  @override
  Future<int> deleteCafeManha(int id) async {
    final db = await DatabaseHelper.database;
    return await db.delete(
      'cafe_manha',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
