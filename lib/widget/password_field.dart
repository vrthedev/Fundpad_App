import 'package:flutter/material.dart';
import 'package:fundpad/utils/const.dart';

typedef StringCallback = String? Function(String?);

class PasswordField extends StatefulWidget {
  const PasswordField(
      {Key? key,
      required this.controller,
      required this.hint,
      this.textColor,
      this.prefixIconColor,
      this.validator})
      : super(key: key);

  final TextEditingController controller;
  final String hint;

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
        hintStyle: const TextStyle(color: COLOR.TEXT_HINT),
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              isShow = !isShow;
            });
          },
          icon: Icon(
            isShow ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: COLOR.BLUE_SECONDARY,
          ),
        ),
        prefixIcon: const Icon(Icons.lock),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: COLOR.BLUE_SECONDARY,
            width: 1.5,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: COLOR.GRAY_BORDER,
            width: 1.5,
          ),
        ),
      ),
      validator: widget.validator,
    );
  }
}
