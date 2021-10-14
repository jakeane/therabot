import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:therabot/constants/messaging_strings.dart';

class TextComposer extends StatelessWidget {
  const TextComposer({
    Key? key,
    required this.focusNode,
    required this.handleSubmit,
    required this.resetTimer,
    required this.controller
  }) : super(key: key);

  final FocusNode? focusNode;
  final Function(String) handleSubmit;
  final Function resetTimer;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        color: Theme.of(context).backgroundColor,
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border:
                  Border.all(color: Theme.of(context).colorScheme.secondary)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 15, top: 15),
                      child: TextField(
                        controller: controller,
                        autofocus: true,
                        focusNode: focusNode,
                        style: Theme.of(context).textTheme.bodyText2,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 15,
                        onChanged: (value) {
                          resetTimer();
                        },
                        onSubmitted: (value) {
                          handleSubmit(value.trim());
                        },
                        decoration: const InputDecoration.collapsed(
                          hintText: "Type message here",
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              RegExp(MessagingStrings.emojiFilter))
                        ],
                      ))),
              IconButton(
                icon: SvgPicture.asset("assets/svgs/Send.svg"),
                iconSize: 25.0,
                color: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(0.0),
                onPressed: () {
                  handleSubmit(controller.text);
                },
              )
            ],
          ),
        ));
  }
}
