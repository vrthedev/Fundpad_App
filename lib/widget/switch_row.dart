import 'package:flutter/material.dart';

typedef BoolCallback = Function(bool value);

class SwitchRow extends StatelessWidget {
  const SwitchRow(
      {Key? key,
      required this.title,
      required this.iconData,
      this.color,
      required this.isActive,
      required this.callback})
      : super(key: key);

  final String title;
  final IconData iconData;
  final Color? color;
  final bool isActive;
  final BoolCallback callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, color: color),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        const Spacer(),
        Switch(
          value: isActive,
          onChanged: callback,
          activeTrackColor: Colors.yellow[700],
          activeColor: Colors.grey[350],
        ),
      ],
    );
  }
}
