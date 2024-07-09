import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sorteiadate/view/widgets/custom_card.dart';

class OptionsScreen extends StatefulWidget {
  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  late Database _database;
  Map<String, String> _tableDisplayNames = {};
  List<String> _tableNames = [];

  @override
  void initState() {
    super.initState();
    _openDatabase();
  }

  Future<void> _openDatabase() async {
    _database = await openDatabase('options_database.db');
    _getTableNames();
  }

  Future<void> _getTableNames() async {
    List<Map<String, dynamic>> tables = await _database.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table'");
    setState(() {
      _tableNames = tables
          .map((e) => e['name'] as String)
          .where((name) =>
              name != 'android_metadata' && name != 'sqlite_sequence' && name != 'clima')
          .toList();
      _tableDisplayNames = {
        'cafe_manha': 'Café da Manhã', // Altere conforme necessário
        'atividade_manha': 'Atividade da Manhã', // Altere conforme necessário
        'almoco': 'Almoço', // Altere conforme necessário
        'lanche_tarde': 'Café da Tarde', // Altere conforme necessário
        'atividade_tarde': 'Atividade da Tarde', // Altere conforme necessário
        'janta': 'Jantar', // Altere conforme necessário
        'atividade_noite': 'Atividade da Noite', // Altere conforme necessário
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Opções')),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _tableNames.length,
                itemBuilder: (BuildContext context, int index) {
                  final tableName = _tableNames[index];
                  final displayName =
                      _tableDisplayNames[tableName] ?? tableName;
                  return Padding(
                    padding: const EdgeInsets.only(top: 24, left: 36, right: 36),
                    child: CustomCard(
                      title: displayName,
                      description: 'Opções de sorteio de $displayName',
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/add', arguments: tableName);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
