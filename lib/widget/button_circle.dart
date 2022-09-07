import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';

class ButtonCircle extends StatelessWidget {
  const ButtonCircle({
    Key? key,
    required this.child,
    this.padding,
    this.gradient,
    this.shadow,
    this.callback,
  }) : super(key: key);

  final Widget child;
  final double? padding;
  final List<Color>? gradient;
  final Color? shadow;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.all(padding ?? 16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
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
