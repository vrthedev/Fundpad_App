import 'package:flutter/material.dart';
import 'package:fundpad/provider/home_provider.dart';
import 'package:fundpad/utils/const.dart';
import 'package:provider/provider.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({
    Key? key,
    required this.child,
    this.padding,
    this.radius,
    this.callback,
  }) : super(key: key);

  final Widget child;
  final double? padding;
  final double? radius;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return InkWell(
      onTap: callback,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 16),
            color: provider.getThemeMode() == ThemeMode.dark
                ? COLOR.BACK_DARK
                : Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 8),
                blurRadius: 30,
                spreadRadius: 0,
                color: Colors.white.withOpacity(0.06),
              )
            ],
          ),
          padding: EdgeInsets.all(padding ?? 16),
          child: child),
    );
  }
}
