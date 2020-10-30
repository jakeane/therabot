import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/theme_model.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
        Expanded(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Consumer<ThemeModel>(
            builder: (context, theme, child) {
              TextStyle activeText =
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18);

              TextStyle inactiveText = Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary);

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dark",
                    style: theme.getIsDark() ? activeText : inactiveText,
                  ),
                  Switch(
                      value: !theme.getIsDark(),
                      onChanged: (value) {
                        theme.setTheme();
                      },
                      activeColor: Theme.of(context).colorScheme.primary),
                  Text(
                    "Light",
                    style: theme.getIsDark() ? inactiveText : activeText,
                  ),
                ],
              );
            },
          ),
          Container(
            width: 135,
            margin: EdgeInsets.only(bottom: 5),
            child: FlatButton(
              onPressed: () {
                // Provider.of<AuthService>(context, listen: false).signOut();
                print('log');
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                FaIcon(
                  FontAwesomeIcons.signOutAlt,
                  color: Theme.of(context).textTheme.bodyText2.color,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    "Log out",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 18),
                  ),
                )
              ]),
            ),
          ),
        ]))
      ]),
    );
  }
}
