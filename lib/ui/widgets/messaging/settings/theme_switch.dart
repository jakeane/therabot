import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/theme_model.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, theme, child) {
        TextStyle activeText =
            Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18);

        TextStyle inactiveText = Theme.of(context).textTheme.bodyText2.copyWith(
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
    );
  }
}
