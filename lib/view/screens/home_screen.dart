import 'package:flutter/material.dart';
import 'package:sorteiadate/view/screens/lucky_screen.dart';
import 'package:sorteiadate/view/screens/options_screen.dart';
import 'package:sorteiadate/view/widgets/menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> { 

  int _indiceAtual = 0;
  final List<Widget> _telas = [
    LuckyScreen(),
    OptionsScreen()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_indiceAtual],
      bottomNavigationBar: Menu(
        currentIndex: _indiceAtual,
        onTabTapped: onTabTapped,
      ),
    );
  }

  
  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

}
