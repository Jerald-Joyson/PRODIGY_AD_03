import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class SetDurationDialog extends StatefulWidget {
  final Duration initialDuration;
  final Function(Duration) onDurationSet;

  const SetDurationDialog({
    super.key,
    required this.initialDuration,
    required this.onDurationSet,
  });

  @override
  State<SetDurationDialog> createState() => _SetDurationDialogState();
}

class _SetDurationDialogState extends State<SetDurationDialog> {
  late int _hours;
  late int _minutes;
  late int _seconds;

  @override
  void initState() {
    super.initState();
    _hours = widget.initialDuration.inHours;
    _minutes = widget.initialDuration.inMinutes.remainder(60);
    _seconds = widget.initialDuration.inSeconds.remainder(60);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set Countdown Duration'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: buildDurationPicker('Hours', _hours, 0, 23, (value) {
                  setState(() {
                    _hours = value;
                  });
                }),
              ),
              Expanded(
                child: buildDurationPicker('Minutes', _minutes, 0, 59, (value) {
                  setState(() {
                    _minutes = value;
                  });
                }),
              ),
              Expanded(
                child: buildDurationPicker('Seconds', _seconds, 0, 59, (value) {
                  setState(() {
                    _seconds = value;
                  });
                }),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onDurationSet(
                Duration(hours: _hours, minutes: _minutes, seconds: _seconds));
            Navigator.pop(context);
          },
          child: const Text('Set'),
        ),
      ],
    );
  }

  Widget buildDurationPicker(String label, int currentValue, int minValue,
      int maxValue, ValueChanged<int> onChanged) {
    return Column(
      children: [
        Text(label),
        NumberPicker(
          value: currentValue,
          minValue: minValue,
          maxValue: maxValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
