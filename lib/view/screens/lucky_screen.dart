import 'package:flutter/material.dart';
import 'package:sorteiadate/controller/database/database_helper.dart';
import 'package:sorteiadate/view/widgets/custom_sort_item.dart';

class LuckyScreen extends StatefulWidget {
  @override
  _LuckyScreenState createState() => _LuckyScreenState();
}

class _LuckyScreenState extends State<LuckyScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Map<String, dynamic>? _randomCafeManha;
  Map<String, dynamic>? _randomAtividadeManha;
  Map<String, dynamic>? _randomAlmoco;
  Map<String, dynamic>? _randomAtividadeTarde;
  Map<String, dynamic>? _randomLancheTarde;
  Map<String, dynamic>? _randomAtividadeNoite;
  Map<String, dynamic>? _randomJanta;

  void _getRandomItems() async {
    final randomCafeManha = await _dbHelper.getRandomItem('cafe_manha');
    final randomAtividadeManha =
        await _dbHelper.getRandomItem('atividade_manha');
    final randomAlmoco = await _dbHelper.getRandomItem('almoco');
    final randomAtividadeTarde =
        await _dbHelper.getRandomItem('atividade_tarde');
    final randomLancheTarde = await _dbHelper.getRandomItem('lanche_tarde');
    final randomAtividadeNoite =
        await _dbHelper.getRandomItem('atividade_noite');
    final randomJanta = await _dbHelper.getRandomItem('janta');

    setState(() {
      _randomCafeManha = randomCafeManha;
      _randomAtividadeManha = randomAtividadeManha;
      _randomAlmoco = randomAlmoco;
      _randomAtividadeTarde = randomAtividadeTarde;
      _randomLancheTarde = randomLancheTarde;
      _randomAtividadeNoite = randomAtividadeNoite;
      _randomJanta = randomJanta;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Sorteia Date')),
        backgroundColor: const Color.fromARGB(
            255, 255, 0, 0), // Defina a cor desejada para o AppBar
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SortItem(
                  title: 'Café da Manhã',
                  item: _randomCafeManha?['descricao'] ?? 'Nenhum item'),
              SortItem(
                  title: 'Atividade Manhã',
                  item: _randomAtividadeManha?['descricao'] ?? 'Nenhum item'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SortItem(
                  title: 'Almoço',
                  item: _randomAlmoco?['descricao'] ?? 'Nenhum item'),
              SortItem(
                  title: 'Atividade Tarde',
                  item: _randomAtividadeTarde?['descricao'] ?? 'Nenhum item'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SortItem(
                  title: 'Lanche da Tarde',
                  item: _randomLancheTarde?['descricao'] ?? 'Nenhum item'),
              SortItem(
                  title: 'Atividade Noite',
                  item: _randomAtividadeNoite?['descricao'] ?? 'Nenhum item'),
            ],
          ),
          SizedBox(height: 20),
          SortItem(
              title: 'Janta',
              item: _randomJanta?['descricao'] ?? 'Nenhum item'),
          Spacer(), // Espaço flexível para empurrar o botão para a parte inferior
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: _getRandomItems,
              child: Text('Sortear'),
            ),
          ),
        ],
      ),
    );
  }
}
