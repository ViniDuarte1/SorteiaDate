import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  final void Function(int) onTabTapped;
  final int currentIndex;

  Menu({Key? key, required this.onTabTapped, required this.currentIndex})
      : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 20,
      currentIndex: widget.currentIndex,
      items: _itens(),
      elevation: 10,
      type: BottomNavigationBarType.fixed,
      selectedItemColor:  const Color.fromARGB(255, 255, 0, 0),
      unselectedItemColor: const Color.fromARGB(255, 156, 49, 49),
      selectedFontSize: 15,
      unselectedFontSize: 10,
      onTap: widget.onTabTapped,
    );
  }

  List<BottomNavigationBarItem> _itens() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.casino),
        label: 'Sorteio',
        backgroundColor: Colors.white,
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Opções',
        backgroundColor: Colors.white,
      ),
    ];
  }
}
