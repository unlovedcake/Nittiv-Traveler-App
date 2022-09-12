import 'package:flutter/material.dart';

class SettingsButton extends StatefulWidget {
  final String placeholder;
  final Function()? function;
  final bool borderBottom;

  const SettingsButton(
      {Key? key,
      required this.placeholder,
      required this.function,
      required this.borderBottom})
      : super(key: key);

  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      decoration: widget.borderBottom
          ? const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xffD0D0D0))))
          : null,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        title: Text(widget.placeholder, style: TextStyle(fontSize: 12)),
        onTap: widget.function,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
