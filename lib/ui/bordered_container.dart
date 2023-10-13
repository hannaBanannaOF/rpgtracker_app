import 'package:flutter/material.dart';

class BorderedContainer extends StatelessWidget {
  final List<Widget> children;
  final String label;
  const BorderedContainer(
      {super.key, this.children = const [], this.label = ''});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
        if (label != '') ...[
          Positioned(
            left: 24,
            top: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Text(
                label,
              ),
            ),
          )
        ],
      ],
    );
  }
}
