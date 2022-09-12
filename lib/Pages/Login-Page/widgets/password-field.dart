// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required this.controller,
    required this.onFieldSubmitted,
    required this.textAlign,
    this.hintText,
    this.passwordHidden = false,
  }) : super(key: key);

  final TextEditingController controller;
  final void Function(String? val) onFieldSubmitted;
  final TextAlign textAlign;
  final String? hintText;
  final bool passwordHidden;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late bool passwordHidden;
  @override
  void initState() {
    passwordHidden = widget.passwordHidden;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Password cannot be empty';
        } else if (val.length < 6) {
          return 'Password must be atleast 6 characters.';
        }
        return null;
      },
      textAlign: widget.textAlign,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.grey[400]),
        label: Text(
          "Password",
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.hintText,
        suffixIcon: RepaintBoundary(
          child: IconButton(
            onPressed: () {
              setState(() {
                passwordHidden = !passwordHidden;
              });
            },
            icon: Icon(
              passwordHidden ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
      ),
      obscureText: passwordHidden,
    );
  }
}
