import 'dart:math';

import 'package:sorteiadate/controller/database/database_helper.dart';
import 'package:sorteiadate/model/janta.dart';
import 'package:sorteiadate/controller/repository/janta_repository.dart';

class JantaRepositoryImpl implements JantaRepository {
  @override
  Future<int> insertJanta(Janta janta) async {
    final db = await DatabaseHelper.database;
    return await db.insert('janta', janta.toMap());
  }

  @override
  Future<List<Janta>> getAllJanta() async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('janta');
    return List.generate(maps.length, (i) {
      return Janta(
        id: maps[i]['id'],
        descricao: maps[i]['descricao'],
        climaId: maps[i]['clima_id'],
      );
    });
  }

  @override
Future<List<Janta>> getAllJantaPorClima(int climaId) async {
  final db = await DatabaseHelper.database;
  final List<Map<String, dynamic>> maps = await db.query(
    'janta',
    where: 'clima_id = ?',
    whereArgs: [climaId],
  );
  return List.generate(maps.length, (i) {
    return Janta(
      id: maps[i]['id'],
      descricao: maps[i]['descricao'],
      climaId: maps[i]['clima_id'],
    );
  });
}

 @override
  Future<Janta> sortearJantaPorClima(int climaId) async {
    final jantas = await getAllJantaPorClima(climaId);
    if (jantas.isEmpty) {
      throw Exception('Não há jantas disponíveis para esse clima.');
    }
    final random = Random();
    final int index = random.nextInt(jantas.length);
    return jantas[index];
  }

  @override
  Future<int> updateJanta(Janta janta) async {
    final db = await DatabaseHelper.database;
    return await db.update(
      'janta',
      janta.toMap(),
      where: 'id = ?',
      whereArgs: [janta.id],
    );
  }

  @override
  Future<int> deleteJanta(int id) async {
    final db = await DatabaseHelper.database;
    return await db.delete(
      'janta',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
