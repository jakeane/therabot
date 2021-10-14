import 'package:flutter/material.dart';

class PageCircle extends StatelessWidget {
  final bool isActive;

  const PageCircle({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}


class PageIndicator extends StatelessWidget {
  final int currentPageValue;
  final int totalPages;

  const PageIndicator({
    Key? key,
    required this.currentPageValue,
    required this.totalPages
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
            margin: const EdgeInsets.only(bottom: 75),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < totalPages; i++)
                  if (i == currentPageValue) ...[
                    const PageCircle(isActive: true)
                  ] else
                    const PageCircle(isActive: false),
              ],
            ))
      ],
    );
  }
}
