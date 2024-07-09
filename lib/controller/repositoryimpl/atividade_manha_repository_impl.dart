import 'dart:math';

import 'package:sorteiadate/controller/database/database_helper.dart';
import 'package:sorteiadate/model/atividade_manha.dart';
import 'package:sorteiadate/controller/repository/atividade_manha_repository.dart';

class AtividadeManhaRepositoryImpl implements AtividadeManhaRepository {
  @override
  Future<int> insertAtividadeManha(AtividadeManha atividadeManha) async {
    final db = await DatabaseHelper.database;
    return await db.insert('atividade_manha', atividadeManha.toMap());
  }

  @override
  Future<List<AtividadeManha>> getAllAtividadeManha() async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('atividade_manha');
    return List.generate(maps.length, (i) {
      return AtividadeManha(
        id: maps[i]['id'],
        descricao: maps[i]['descricao'],
        climaId: maps[i]['clima_id'],
      );
    });
  }

  @override
  Future<List<AtividadeManha>> getAllAtividadeManhaPorClima(int climaId) async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'atividade_manha',
      where: 'clima_id = ?',
      whereArgs: [climaId],
    );
    return List.generate(maps.length, (i) {
      return AtividadeManha(
        id: maps[i]['id'],
        descricao: maps[i]['descricao'],
        climaId: maps[i]['clima_id'],
      );
    });
  }

  @override
  Future<AtividadeManha> sortearAtividadeManhaPorClima(int climaId) async {
    final atividadesManha = await getAllAtividadeManhaPorClima(climaId);
    if (atividadesManha.isEmpty) {
      throw Exception('Não há atividades disponíveis para esse clima.');
    }
    final random = Random();
    final int index = random.nextInt(atividadesManha.length);
    return atividadesManha[index];
  }

  @override
  Future<int> updateAtividadeManha(AtividadeManha atividadeManha) async {
    final db = await DatabaseHelper.database;
    return await db.update(
      'atividade_manha',
      atividadeManha.toMap(),
      where: 'id = ?',
      whereArgs: [atividadeManha.id],
    );
  }

  @override
  Future<int> deleteAtividadeManha(int id) async {
    final db = await DatabaseHelper.database;
    return await db.delete(
      'atividade_manha',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
