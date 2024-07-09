import 'package:flutter/material.dart';

class SortItem extends StatelessWidget {
  final String title;
  final String item;

  const SortItem({super.key, 
    required this.title,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width * 0.45,
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
      child: Center(
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            item,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}