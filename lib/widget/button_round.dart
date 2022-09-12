import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';

class ButtonRound extends StatelessWidget {
  const ButtonRound({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.radius,
    this.color,
    this.callback,
  }) : super(key: key);

  final Widget child;
  final double? width, height, radius;

  final Color? color;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 63,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 38),
          color: color ?? COLOR.ORANGE_PRIMARY,
        ),
        child: child,
      ),
    );
  }
}
