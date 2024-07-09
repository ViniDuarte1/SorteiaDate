import 'dart:math';

import 'package:sorteiadate/controller/database/database_helper.dart';
import 'package:sorteiadate/model/atividade_tarde.dart';
import 'package:sorteiadate/controller/repository/atividade_tarde_repository.dart';

class AtividadeTardeRepositoryImpl implements AtividadeTardeRepository {
  @override
  Future<int> insertAtividadeTarde(AtividadeTarde atividadeTarde) async {
    final db = await DatabaseHelper.database;
    return await db.insert('atividade_tarde', atividadeTarde.toMap());
  }

  @override
  Future<List<AtividadeTarde>> getAllAtividadeTarde() async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('atividade_tarde');
    return List.generate(maps.length, (i) {
      return AtividadeTarde(
        id: maps[i]['id'],
        descricao: maps[i]['descricao'],
        climaId: maps[i]['clima_id'],
      );
    });
  }

  @override
  Future<List<AtividadeTarde>> getAllAtividadeTardePorClima(int climaId) async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'atividade_tarde',
      where: 'clima_id = ?',
      whereArgs: [climaId],
    );
    return List.generate(maps.length, (i) {
      return AtividadeTarde(
        id: maps[i]['id'],
        descricao: maps[i]['descricao'],
        climaId: maps[i]['clima_id'],
      );
    });
  }

  @override
  Future<AtividadeTarde> sortearAtividadeTardePorClima(int climaId) async {
    final atividadesTarde = await getAllAtividadeTardePorClima(climaId);
    if (atividadesTarde.isEmpty) {
      throw Exception('Não há atividades disponíveis para esse clima.');
    }
    final random = Random();
    final int index = random.nextInt(atividadesTarde.length);
    return atividadesTarde[index];
  }
  

  @override
  Future<int> updateAtividadeTarde(AtividadeTarde atividadeTarde) async {
    final db = await DatabaseHelper.database;
    return await db.update(
      'atividade_tarde',
      atividadeTarde.toMap(),
      where: 'id = ?',
      whereArgs: [atividadeTarde.id],
    );
  }

  @override
  Future<int> deleteAtividadeTarde(int id) async {
    final db = await DatabaseHelper.database;
    return await db.delete(
      'atividade_tarde',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
