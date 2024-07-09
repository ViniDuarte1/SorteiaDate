import 'dart:math';

import 'package:sorteiadate/controller/database/database_helper.dart';
import 'package:sorteiadate/model/lanche_tarde.dart';
import 'package:sorteiadate/controller/repository/lanche_tarde_repository.dart';

class LancheTardeRepositoryImpl implements LancheTardeRepository {
  @override
  Future<int> insertLancheTarde(LancheTarde lancheTarde) async {
    final db = await DatabaseHelper.database;
    return await db.insert('lanche_tarde', lancheTarde.toMap());
  }

  @override
  Future<List<LancheTarde>> getAllLancheTarde() async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('lanche_tarde');
    return List.generate(maps.length, (i) {
      return LancheTarde(
        id: maps[i]['id'],
        descricao: maps[i]['descricao'],
        climaId: maps[i]['clima_id'],
      );
    });
  }

  @override
  Future<List<LancheTarde>> getAllLancheTardePorClima(int climaId) async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'lanche_tarde',
      where: 'clima_id = ?',
      whereArgs: [climaId],
    );
    return List.generate(maps.length, (i) {
      return LancheTarde(
        id: maps[i]['id'],
        descricao: maps[i]['descricao'],
        climaId: maps[i]['clima_id'],
      );
    });
  }

  @override
  Future<LancheTarde> sortearLancheTardePorClima(int climaId) async {
    final lanchesTarde = await getAllLancheTardePorClima(climaId);
    if (lanchesTarde.isEmpty) {
      throw Exception('Não há lanches disponíveis para esse clima.');
    }
    final random = Random();
    final int index = random.nextInt(lanchesTarde.length);
    return lanchesTarde[index];
  }
  

  @override
  Future<int> updateLancheTarde(LancheTarde lancheTarde) async {
    final db = await DatabaseHelper.database;
    return await db.update(
      'lanche_tarde',
      lancheTarde.toMap(),
      where: 'id = ?',
      whereArgs: [lancheTarde.id],
    );
  }

  @override
  Future<int> deleteLancheTarde(int id) async {
    final db = await DatabaseHelper.database;
    return await db.delete(
      'lanche_tarde',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
