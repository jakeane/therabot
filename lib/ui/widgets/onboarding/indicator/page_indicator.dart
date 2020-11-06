import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/widgets/onboarding/indicator/page_circle.dart';

class PageIndicator extends StatelessWidget {
  final int currentPageValue;
  final int totalPages;

  PageIndicator({this.currentPageValue, this.totalPages});

  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 75),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < totalPages; i++)
                  if (i == currentPageValue) ...[
                    PageCircle(isActive: true)
                  ] else
                    PageCircle(isActive: false),
              ],
            ))
      ],
    );
  }
}
