import 'package:flutter/material.dart';
import 'package:rpgtracker_app/extensions/string.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.list,
            size: 48,
          ),
          Text('general:defaultEmpty.message'.translate(context))
        ],
      ),
    );
  }
}
