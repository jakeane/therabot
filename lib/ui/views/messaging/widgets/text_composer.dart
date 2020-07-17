import 'package:flutter/material.dart';

class TextComposer extends StatelessWidget {
  TextComposer({this.focusNode, this.handleSubmit, this.controller});

  final FocusNode focusNode;
  final Function(String) handleSubmit;
  final TextEditingController controller;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        color: Theme.of(context).backgroundColor,
        child: Container(
          padding: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(color: Theme.of(context).colorScheme.secondary)),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: TextField(
                controller: controller,
                autofocus: true,
                focusNode: focusNode,
                style: Theme.of(context).textTheme.caption,
                textCapitalization: TextCapitalization.sentences,
                // onSubmitted: (value) {
                //   handleSubmit(value);
                // },
                decoration: InputDecoration.collapsed(
                  hintText: "Type message here",
                ),
              )),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 25.0,
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  handleSubmit(controller.text);
                },
              )
            ],
          ),
        ));
  }
}
