import 'package:flutter/material.dart';
import 'package:sorteiadate/controller/database/database_helper.dart';
import 'package:sorteiadate/model/screen_arguments.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final String tableName = args.tableName;
    final String displayName = args.displayName;

    Future<List<Map<String, dynamic>>> fetchTableData() async {
      return await DatabaseHelper().getTableData(tableName);
    }

    void addItem(String descricao) async {
      await DatabaseHelper.insertData(tableName, descricao);
      setState(() {}); // Atualiza a tela
    }

    void deleteItem(int id) async {
      await DatabaseHelper.deleteData(tableName, id);
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
          child: Text(displayName),
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
                return Padding(
                  padding: const EdgeInsets.only(top: 24, left: 26, right: 26),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 2.0,
                          offset: const Offset(2.0, 4.0),
                        )
                      ],
                    ),
                    child: ListTile(
                      title: Text(item['descricao']),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          deleteItem(item['id']);
                        },
                      ),
                    ),
                  ),
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
      ),
    );
  }
}
