import 'package:flutter/material.dart';
import 'package:rpgtracker_app/extensions/string.dart';
import 'package:rpgtracker_app/ui/custom_track_shape.dart';

class LabeledSlider extends StatefulWidget {
  final double value;
  final Function(int value) onUpdate;
  final double min;
  final double max;
  final bool enabled;
  const LabeledSlider({
    super.key,
    required this.value,
    required this.onUpdate,
    this.min = 0.0,
    this.max = 100.0,
    this.enabled = true,
  });

  @override
  State<LabeledSlider> createState() => _LabeledSliderState();
}

class _LabeledSliderState extends State<LabeledSlider> {
  late double _currentVal;

  @override
  void initState() {
    _currentVal = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${'general:slider.current'.translate(context)}: ${_currentVal.toInt()}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SliderTheme(
          data: SliderThemeData(trackShape: CustomTrackShape()),
          child: Slider(
            min: widget.min,
            max: widget.max,
            value: _currentVal,
            thumbColor: !widget.enabled
                ? Theme.of(context).colorScheme.onInverseSurface
                : null,
            activeColor: !widget.enabled
                ? Theme.of(context).colorScheme.onInverseSurface
                : null,
            onChanged: (value) {
              if (widget.enabled) {
                setState(() {
                  _currentVal = value;
                });
              }
            },
            onChangeEnd: (value) {
              widget.onUpdate(value.toInt());
            },
          ),
        ),
      ],
    );
  }
}
