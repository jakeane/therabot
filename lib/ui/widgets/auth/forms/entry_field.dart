import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String hintText;
  final double topMargin;
  final bool obscureText;
  final void Function(String) saveValue;
  final TextInputType textInputType;

  EntryField(
      {this.hintText,
      this.topMargin,
      this.obscureText,
      this.saveValue,
      this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        margin: EdgeInsets.only(top: topMargin),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).colorScheme.secondary)),
        width: 300,
        child: TextFormField(
          textAlign: TextAlign.center,
          keyboardType: textInputType,
          obscureText: obscureText,
          style: Theme.of(context).textTheme.caption,
          decoration: InputDecoration.collapsed(hintText: hintText),
          onSaved: saveValue,
        ));
  }
}
