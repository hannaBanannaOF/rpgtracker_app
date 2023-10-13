import 'package:flutter/material.dart';

class CoCStat extends StatelessWidget {
  final dynamic value;
  final String stat;
  final bool unique;

  const CoCStat({
    super.key,
    required this.stat,
    required this.value,
    this.unique = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            stat,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            height: unique ? 44 : 64,
            width: unique ? 44 : null,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    borderRadius: unique
                        ? const BorderRadius.all(
                            Radius.circular(
                              8,
                            ),
                          )
                        : null,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Center(child: Text(value.toString())),
                ),
                if (!unique) ...[
                  SizedBox(
                    width: 32,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              ),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8))),
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              (value / 2).floor().toString(),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              (value / 5).floor().toString(),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}
