import 'package:sorteiadate/controller/database/database_helper.dart';
import 'package:sorteiadate/model/enum/clima_enum.dart';
import 'package:sorteiadate/model/enum/horario_enum.dart';
import 'package:sorteiadate/model/options.dart';
import 'package:sorteiadate/controller/repository/options_repository.dart';


class OptionsRepositoryImpl implements OptionsRepository {
  @override
  Future<int> insertOption(Options option) async {
    final db = await DatabaseHelper.database;
    return await db.insert('options', option.toMap());
  }

  @override
  Future<List<Options>> getAllOptions() async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('options');
    return List.generate(maps.length, (i) {
      return Options(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        horario: Horario.values[maps[i]['horario']],
        clima: Clima.values[maps[i]['clima']],
      );
    });
  }

  @override
  Future<int> updateOption(Options option) async {
    final db = await DatabaseHelper.database;
    return await db.update(
      'options',
      option.toMap(),
      where: 'id = ?',
      whereArgs: [option.id],
    );
  }

  @override
  Future<int> deleteOption(int id) async {
    final db = await DatabaseHelper.database;
    return await db.delete(
      'options',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
