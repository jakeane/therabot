import 'package:flutter/material.dart';
import 'package:flutter_chatbot/assets/assets.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/settings/settings_box.dart';

class SettingsOverlay extends StatelessWidget {
  SettingsOverlay({this.setSettingsView});

  final Function setSettingsView;

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
            overflow: Overflow.visible,
            children: [
              SettingsBox(),
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
                      icon: Icon(Cb.feedbackexpressed),
                      iconSize: 25,
                      color: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {
                        setSettingsView();
                      })),
            ],
          ))
    ]);
  }
}
