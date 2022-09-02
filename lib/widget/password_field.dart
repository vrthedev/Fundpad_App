import 'package:flutter/material.dart';

typedef StringCallback = String? Function(String?);

class PasswordField extends StatefulWidget {
  const PasswordField(
      {Key? key,
      required this.controller,
      required this.hint,
      this.textColor,
      this.prefixIconColor,
      this.border,
      this.validator})
      : super(key: key);

  final TextEditingController controller;
  final String hint;
  final InputBorder? border;
  final StringCallback? validator;
  final Color? textColor;
  final Color? prefixIconColor;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(color: widget.textColor),
      obscureText: !isShow,
      decoration: InputDecoration(
        hintText: widget.hint,
        border: widget.border ?? InputBorder.none,
        prefixIcon: Icon(Icons.lock_outline, color: widget.prefixIconColor),
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              isShow = !isShow;
            });
          },
          icon: Icon(isShow
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined),
        ),
      ),
      validator: widget.validator,
    );
  }
}
