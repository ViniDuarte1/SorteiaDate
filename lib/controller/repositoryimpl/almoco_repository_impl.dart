import 'dart:math';

import 'package:sorteiadate/controller/database/database_helper.dart';
import 'package:sorteiadate/model/almoco.dart';
import 'package:sorteiadate/controller/repository/almoco_repository.dart';

class AlmocoRepositoryImpl implements AlmocoRepository {
  @override
  Future<int> insertAlmoco(Almoco almoco) async {
    final db = await DatabaseHelper.database;
    return await db.insert('almoco', almoco.toMap());
  }

  @override
  Future<List<Almoco>> getAllAlmoco() async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('almoco');
    return List.generate(maps.length, (i) {
      return Almoco(
        id: maps[i]['id'],
        descricao: maps[i]['descricao'],
        climaId: maps[i]['clima_id'],
      );
    });
  }

  @override
  Future<List<Almoco>> getAllAlmocoPorClima(int climaId) async {
    final db = await DatabaseHelper.database;
  final List<Map<String, dynamic>> maps = await db.query(
    'almoco',
    where: 'clima_id = ?',
    whereArgs: [climaId],
  );
  return List.generate(maps.length, (i) {
    return Almoco(
      id: maps[i]['id'],
      descricao: maps[i]['descricao'],
      climaId: maps[i]['clima_id'],
    );
  });
  }

 @override
  Future<Almoco> sortearAlmocoPorClima(int climaId) async {
    final almocos = await getAllAlmocoPorClima(climaId);
    if (almocos.isEmpty) {
      throw Exception('Não há almoços disponíveis para esse clima.');
    }
    final random = Random();
    final int index = random.nextInt(almocos.length);
    return almocos[index];
  }
  
  @override
  Future<int> updateAlmoco(Almoco almoco) async {
    final db = await DatabaseHelper.database;
    return await db.update(
      'almoco',
      almoco.toMap(),
      where: 'id = ?',
      whereArgs: [almoco.id],
    );
  }

  @override
  Future<int> deleteAlmoco(int id) async {
    final db = await DatabaseHelper.database;
    return await db.delete(
      'almoco',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
