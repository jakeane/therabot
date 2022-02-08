
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:therabot/store/auth_provider.dart';
import 'package:therabot/store/database_service.dart';
import 'package:therabot/store/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CrisisOverlay extends StatelessWidget {
  final Function setCrisisView;

  const CrisisOverlay({
    Key? key,
    required this.setCrisisView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
          onTap: () {
            setCrisisView();
          },
          child: Container(
            color: Colors.black.withOpacity(0.6),
          )),
      Align(
          alignment: Alignment.center,
          child: Stack(
            clipBehavior: Clip.none, children: [
              const CrisisBox(),
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
                        setCrisisView();
                      })),
            ],
          ))
    ]);
  }
}

class CrisisBox extends StatelessWidget {

  const CrisisBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).dividerColor,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          const Call911Button(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
            height: 1,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          const SuicideHotlineButton(),
          const CrisisTextlineButton(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        ])
      ]),
    );
  }
}



class Call911Button extends StatelessWidget {
  const Call911Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 50,
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      child: OutlinedButton(
        onPressed: () {
          launch('tel:+16178179957');
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FaIcon(
            FontAwesomeIcons.phoneAlt,
            color: Theme.of(context).errorColor,
            size: 36
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Text(
              "CALL 911",
              style: Theme
                .of(context)
                .textTheme
                .bodyText2
                ?.copyWith(fontSize: 27, color: Theme.of(context).errorColor),
            ),
          )
        ]),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          side: BorderSide(width: 1, color: Theme.of(context).errorColor)
        )
      ),
    );
  }
}

class SuicideHotlineButton extends StatelessWidget {
  const SuicideHotlineButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(bottom: 5),
      child: OutlinedButton(
        onPressed: () {},
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FaIcon(
            FontAwesomeIcons.phoneAlt,
            color: Theme.of(context).textTheme.bodyText1?.color,
            size: 18
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Text(
              "Suicide Help Line",
              style: Theme
                .of(context)
                .textTheme
                .bodyText2
                ?.copyWith(fontSize: 14, color: Theme.of(context).textTheme.bodyText1?.color),
            ),
          )
        ]),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          side: BorderSide(
            width: 1,
            color: Theme.of(context).textTheme.bodyText1?.color ?? Theme.of(context).colorScheme.secondary)
        )
      ),
    );
  }
}

class CrisisTextlineButton extends StatelessWidget {
  const CrisisTextlineButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(bottom: 5),
      child: OutlinedButton(
        onPressed: () {},
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FaIcon(
            FontAwesomeIcons.mobileAlt,
            color: Theme.of(context).textTheme.bodyText1?.color,
            size: 18
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Text(
              "Crisis Text Line",
              style: Theme
                .of(context)
                .textTheme
                .bodyText2
                ?.copyWith(fontSize: 14, color: Theme.of(context).textTheme.bodyText1?.color),
            ),
          )
        ]),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          side: BorderSide(
            width: 1,
            color: Theme.of(context).textTheme.bodyText1?.color ?? Theme.of(context).colorScheme.secondary)
        )
      ),
    );
  }
}
