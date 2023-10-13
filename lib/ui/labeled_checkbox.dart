import 'package:flutter/material.dart';

class LabeledCheckbox extends StatefulWidget {
  final String label;
  final bool value;
  final bool enabled;
  const LabeledCheckbox({
    super.key,
    required this.label,
    required this.value,
    this.enabled = true,
  });

  @override
  State<LabeledCheckbox> createState() => _LabeledCheckboxState();
}

class _LabeledCheckboxState extends State<LabeledCheckbox> {
  late bool _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            activeColor: !widget.enabled
                ? Theme.of(context).colorScheme.onInverseSurface
                : null,
            checkColor: !widget.enabled ? Theme.of(context).hintColor : null,
            value: _value,
            onChanged: (value) {
              if (widget.enabled) {
                setState(() {
                  _value = value ?? false;
                });
              }
            },
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(widget.label)
      ],
    );
  }
}
