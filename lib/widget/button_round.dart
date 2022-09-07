import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';

class ButtonRound extends StatelessWidget {
  const ButtonRound({
    Key? key,
    required this.child,
    this.width,
    this.radius,
    this.gradient,
    this.shadow,
    this.callback,
  }) : super(key: key);

  final Widget child;
  final double? width;
  final double? radius;
  final List<Color>? gradient;
  final Color? shadow;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: width ?? double.infinity,
        height: 63,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 38),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradient ?? [COLOR.BLUE_LIGHT, COLOR.BLUE_DARK]),
          boxShadow: [
            BoxShadow(
              color: shadow ?? COLOR.BLUE_DARK.withOpacity(0.25),
              offset: const Offset(0, 1),
              blurRadius: 4,
              spreadRadius: 0,
            )
          ],
        ),
        child: child,
      ),
    );
  }
}
