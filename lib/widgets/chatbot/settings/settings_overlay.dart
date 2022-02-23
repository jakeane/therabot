import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:therabot/store/auth_provider.dart';
import 'package:therabot/store/database_service.dart';
import 'package:therabot/store/theme_provider.dart';

class SettingsOverlay extends StatelessWidget {
  final Function setSettingsView;
  final Function newConvo;

  const SettingsOverlay({
    Key? key,
    required this.setSettingsView,
    required this.newConvo
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
          onTap: () {
            setSettingsView();
          },
          child: Container(
            color: Colors.black.withOpacity(0.6),
          )),
      Align(
          alignment: Alignment.center,
          child: Stack(
            clipBehavior: Clip.none, children: [
              SettingsBox(
                newConvo: newConvo,
              ),
              Positioned(
                  top: -5,
                  right: -5,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).dividerColor,
                    ),
                  )),
              Positioned(
                  top: -20,
                  right: -20,
                  child: IconButton(
                      icon: SvgPicture.asset("assets/svgs/FeedbackExPressed.svg"),
                      iconSize: 25,
                      color: Theme.of(context).colorScheme.secondary,
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {
                        setSettingsView();
                      })),
            ],
          ))
    ]);
  }
}

class SettingsBox extends StatelessWidget {
  final Function newConvo;

  const SettingsBox({Key? key, required this.newConvo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).dividerColor,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            "Settings",
            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18),
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.secondary,
          height: 1,
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const ThemeSwitch(),
          NewConvoButton(
            newConvo: newConvo,
          ),
          const LogOutButton()
        ])
      ]),
    );
  }
}

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, child) {
        TextStyle? activeText =
            Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18);

        TextStyle? inactiveText = Theme.of(context).textTheme.bodyText2?.copyWith(
            fontSize: 18, color: Theme.of(context).colorScheme.secondary);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Dark",
              style: theme.getIsDark() ? activeText : inactiveText,
            ),
            Switch(
                value: !theme.getIsDark(),
                onChanged: (_) {
                  theme.toggleTheme();
                  FirebaseDbService.saveTheme(theme.getIsDark());
                },
                activeColor: Theme.of(context).colorScheme.primary),
            Text(
              "Light",
              style: theme.getIsDark() ? inactiveText : activeText,
            ),
          ],
        );
      },
    );
  }
}

class NewConvoButton extends StatelessWidget {
  final Function newConvo;

  const NewConvoButton({Key? key, required this.newConvo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(bottom: 5),
      child: FlatButton(
        onPressed: () {
          newConvo();
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FaIcon(
            FontAwesomeIcons.solidPlusSquare,
            color: Theme.of(context).textTheme.bodyText2?.color,
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Text(
              "Restart Conversation",
              style:
                  Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18),
            ),
          )
        ]),
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      margin: const EdgeInsets.only(bottom: 5),
      child: FlatButton(
        onPressed: () async {
          Provider.of<ThemeProvider>(context, listen: false).resetTheme();
          await Future.delayed(const Duration(milliseconds: 150));
          Provider.of<AuthProvider>(context, listen: false).signOut();
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FaIcon(
            FontAwesomeIcons.signOutAlt,
            color: Theme.of(context).textTheme.bodyText2?.color,
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Text(
              "Log out",
              style:
                  Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18),
            ),
          )
        ]),
      ),
    );
  }
}
