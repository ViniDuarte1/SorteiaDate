import 'package:flutter/material.dart';
import 'package:sorteiadate/controller/database/database_helper.dart';
import 'package:sorteiadate/view/screens/add_screen.dart';
import 'package:sorteiadate/view/screens/home_screen.dart';
import 'package:sorteiadate/view/screens/lucky_screen.dart';
import 'package:sorteiadate/view/screens/options_screen.dart';

//import 'package:sorteiadate/screens/lucky_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sorteia Date',
      routes:
      {
        '/': (context) => HomeScreen(),
        '/lucky': (context) => LuckyScreen(),
        '/options':(context) => OptionsScreen(),
        '/add': (context) =>AddScreen(),
      }
    );
  }
}

