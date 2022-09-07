import 'package:flutter/material.dart';
import 'package:fundpad/provider/home_provider.dart';
import 'package:fundpad/utils/const.dart';
import 'package:provider/provider.dart';

class BorderRound extends StatelessWidget {
  const BorderRound({
    Key? key,
    required this.child,
    this.horizontal,
    this.vertical,
    this.radius,
    this.callback,
  }) : super(key: key);

  final Widget child;
  final double? vertical, horizontal;
  final double? radius;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return InkWell(
      onTap: callback,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 38),
            border: Border.all(
              color: provider.getThemeMode() == ThemeMode.dark
                  ? COLOR.BACK_DARK
                  : COLOR.BORDER_LIGHT,
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: vertical ?? 16,
            horizontal: horizontal ?? 16,
          ),
          child: child),
    );
  }
}
