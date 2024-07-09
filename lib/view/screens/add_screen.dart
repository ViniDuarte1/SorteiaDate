import 'package:flutter/material.dart';
import 'package:sorteiadate/controller/database/database_helper.dart';

class AddScreen extends StatefulWidget {
  final String? title;
  const AddScreen({super.key, this.title});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    final String tableName =
        ModalRoute.of(context)!.settings.arguments as String;

    Future<List<Map<String, dynamic>>> fetchTableData() async {
      return await DatabaseHelper().getTableData(tableName);
    }

    void addItem(String descricao) async {
      await DatabaseHelper.insertData(tableName, descricao);
      setState(() {}); // Atualiza a tela
    }

    void showAddItemDialog() {
      TextEditingController controller = TextEditingController();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Adicionar Novo Item'),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: 'Descrição'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  addItem(controller.text);
                  Navigator.of(context).pop();
                },
                child: Text('Adicionar'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(tableName),
          ),
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
          backgroundColor: const Color.fromARGB(
              255, 255, 0, 0), // Defina a cor desejada para o AppBar
        ),
        
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchTableData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data found.'));
            } else {
              final data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  return ListTile(
                    title: Text(item['descricao']),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: showAddItemDialog,
          child: const Icon(Icons.add),
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        ));
  }
}
