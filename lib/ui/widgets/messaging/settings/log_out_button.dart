import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/theme_model.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      margin: EdgeInsets.only(bottom: 5),
      child: FlatButton(
        onPressed: () async {
          Provider.of<ThemeModel>(context, listen: false).resetTheme();
          await Future.delayed(Duration(milliseconds: 150));
          Provider.of<AuthService>(context, listen: false).signOut();
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FaIcon(
            FontAwesomeIcons.signOutAlt,
            color: Theme.of(context).textTheme.bodyText2.color,
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              "Log out",
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18),
            ),
          )
        ]),
      ),
    );
  }
}
