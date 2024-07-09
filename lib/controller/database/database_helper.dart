import 'dart:math';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database == null || !_database!.isOpen) {
      _database = await initDatabase();
      await insertTestData();
    }
    return _database!;
  }

  static Future<Database> initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'options_database.db');
      //print("Criando o banco de dados em: $path");
      Database database =
          await openDatabase(path, version: 1, onCreate: _createDb);
      //print("Banco de dados criado com sucesso!");
      return database;
    } catch (ex) {
      //print("Erro ao inicializar o banco de dados: $ex");
      rethrow;
    }
  }

  static void _createDb(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE cafe_manha(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          descricao TEXT,
          clima_id INTEGER,
          FOREIGN KEY(clima_id) REFERENCES clima(id)
        )
      ''');
      //print("Tabela 'cafe_manha' criada com sucesso!");

      await db.execute('''
        CREATE TABLE atividade_manha(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          descricao TEXT,
          clima_id INTEGER,
          FOREIGN KEY(clima_id) REFERENCES clima(id)
        )
      ''');
      //print("Tabela 'atividade_manha' criada com sucesso!");

      await db.execute('''
        CREATE TABLE almoco(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          descricao TEXT,
          clima_id INTEGER,
          FOREIGN KEY(clima_id) REFERENCES clima(id)
        )
      ''');
      //print("Tabela 'almoco' criada com sucesso!");

      await db.execute('''
        CREATE TABLE atividade_tarde(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          descricao TEXT,
          clima_id INTEGER,
          FOREIGN KEY(clima_id) REFERENCES clima(id)
        )
      ''');
      //print("Tabela 'atividade_tarde' criada com sucesso!");

      await db.execute('''
        CREATE TABLE lanche_tarde(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          descricao TEXT,
          clima_id INTEGER,
          FOREIGN KEY(clima_id) REFERENCES clima(id)
        )
      ''');
      //print("Tabela 'lanche_tarde' criada com sucesso!");

      await db.execute('''
        CREATE TABLE atividade_noite(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          descricao TEXT,
          clima_id INTEGER,
          FOREIGN KEY(clima_id) REFERENCES clima(id)
        )
      ''');
      //print("Tabela 'atividade_noite' criada com sucesso!");

      await db.execute('''
        CREATE TABLE janta(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          descricao TEXT,
          clima_id INTEGER,
          FOREIGN KEY(clima_id) REFERENCES clima(id)
        )
      ''');
      //print("Tabela 'janta' criada com sucesso!");

      await db.execute('''
        CREATE TABLE clima(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          descricao TEXT
        )
      ''');
      //print("Tabela 'clima' criada com sucesso!");
    } catch (ex) {
      //print("Erro ao criar as tabelas: $ex");
      rethrow;
    }
  }

   static Future<void> insertTestData() async {
    Database db = await database;
    try {
      // Verificar se há dados na tabela clima
      final climaData = await db.query('clima');
      if (climaData.isEmpty) {
        // Inserir dados de teste para a tabela clima
        await db.insert('clima', {'descricao': 'Ensolarado'});
        await db.insert('clima', {'descricao': 'Nublado'});
        await db.insert('clima', {'descricao': 'Chuvoso'});

        // Inserir dados de teste para outras tabelas
        await db.insert('cafe_manha', {'descricao': 'Pão com manteiga', 'clima_id': 1});
        await db.insert('cafe_manha', {'descricao': 'Café preto', 'clima_id': 2});

        await db.insert('atividade_manha', {'descricao': 'Caminhada', 'clima_id': 1});
        await db.insert('atividade_manha', {'descricao': 'Leitura', 'clima_id': 2});

        await db.insert('almoco', {'descricao': 'Arroz com feijão', 'clima_id': 1});
        await db.insert('almoco', {'descricao': 'Macarrão', 'clima_id': 2});

        await db.insert('atividade_tarde', {'descricao': 'Ciclismo', 'clima_id': 1});
        await db.insert('atividade_tarde', {'descricao': 'Desenho', 'clima_id': 2});

        await db.insert('lanche_tarde', {'descricao': 'Biscoitos', 'clima_id': 1});
        await db.insert('lanche_tarde', {'descricao': 'Frutas', 'clima_id': 2});

        await db.insert('atividade_noite', {'descricao': 'Assistir filme', 'clima_id': 1});
        await db.insert('atividade_noite', {'descricao': 'Jogar videogame', 'clima_id': 2});

        await db.insert('janta', {'descricao': 'Sopa', 'clima_id': 1});
        await db.insert('janta', {'descricao': 'Salada', 'clima_id': 2});
      }
    } catch (ex) {
      print("Erro ao inserir dados de teste: $ex");
      rethrow;
    }
  }

  static Future<void> insertData(String tableName, String descricao) async { 
    Database db = await database;
    try {
      await db.insert(
          tableName, {'descricao': descricao, 'clima_id': 1});
    } catch (ex) {
      print("Erro ao inserir dados de teste: $ex");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getTableData(String tableName) async {
    Database db = await database;
    return db.query(tableName);
  }

  Future<Map<String, dynamic>?> getRandomItem(String tableName) async {
    Database db = await database;
    final countResult = await db.rawQuery('SELECT COUNT(*) FROM $tableName');
    int count = Sqflite.firstIntValue(countResult) ?? 0;
    if (count == 0) {
      return null;
    }
    int randomIndex = Random().nextInt(count);
    final randomItem = await db.query(
      tableName,
      limit: 1,
      offset: randomIndex,
    );
    if (randomItem.isNotEmpty) {
      return randomItem.first;
    }
    return null;
  }
}
