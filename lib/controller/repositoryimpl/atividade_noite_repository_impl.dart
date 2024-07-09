import 'dart:math';

import 'package:sorteiadate/controller/database/database_helper.dart';
import 'package:sorteiadate/model/atividade_noite.dart';
import 'package:sorteiadate/controller/repository/atividade_noite_repository.dart';

class AtividadeNoiteRepositoryImpl implements AtividadeNoiteRepository {
  @override
  Future<int> insertAtividadeNoite(AtividadeNoite atividadeNoite) async {
    final db = await DatabaseHelper.database;
    return await db.insert('atividade_noite', atividadeNoite.toMap());
  }

  @override
  Future<List<AtividadeNoite>> getAllAtividadeNoite() async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('atividade_noite');
    return List.generate(maps.length, (i) {
      return AtividadeNoite(
        id: maps[i]['id'],
        descricao: maps[i]['descricao'],
        climaId: maps[i]['clima_id'],
      );
    });
  }

  @override
  Future<List<AtividadeNoite>> getAllAtividadeNoitePorClima(int climaId) async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'atividade_noite',
      where: 'clima_id = ?',
      whereArgs: [climaId],
    );
    return List.generate(maps.length, (i) {
      return AtividadeNoite(
        id: maps[i]['id'],
        descricao: maps[i]['descricao'],
        climaId: maps[i]['clima_id'],
      );
    });
  }

  @override
  Future<AtividadeNoite> sortearAtividadeNoitePorClima(int climaId) async {
    final atividadesNoite = await getAllAtividadeNoitePorClima(climaId);
    if (atividadesNoite.isEmpty) {
      throw Exception('Não há atividades disponíveis para esse clima.');
    }
    final random = Random();
    final int index = random.nextInt(atividadesNoite.length);
    return atividadesNoite[index];
  }

  @override
  Future<int> updateAtividadeNoite(AtividadeNoite atividadeNoite) async {
    final db = await DatabaseHelper.database;
    return await db.update(
      'atividade_noite',
      atividadeNoite.toMap(),
      where: 'id = ?',
      whereArgs: [atividadeNoite.id],
    );
  }

  @override
  Future<int> deleteAtividadeNoite(int id) async {
    final db = await DatabaseHelper.database;
    return await db.delete(
      'atividade_noite',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
