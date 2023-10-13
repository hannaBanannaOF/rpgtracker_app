import 'package:flutter/material.dart';

class ListTileTitle extends StatelessWidget {
  final String title;
  const ListTileTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
