import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/settings/log_out_button.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/settings/theme_switch.dart';

class SettingsBox extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).dividerColor,
      ),
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            "Settings",
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18),
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.secondary,
          height: 1,
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ThemeSwitch(), LogOutButton()])
      ]),
    );
  }
}
