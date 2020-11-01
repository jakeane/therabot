import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/page_base.dart';
import 'package:flutter_chatbot/ui/widgets/onboarding/core/onboard_page.dart';
import 'package:flutter_chatbot/ui/widgets/onboarding/buttons/start_chatting_button.dart';
import 'package:flutter_chatbot/ui/widgets/onboarding/indicator/page_indicator.dart';

class OnBoardPageview extends StatefulWidget {
  @override
  _OnBoardPageviewState createState() => _OnBoardPageviewState();
}

class _OnBoardPageviewState extends State<OnBoardPageview> {
  int currentPageValue = 0;
  PageController _pageController;
  final List<Widget> onBoardPages = [
    OnboardPage(pageNum: 0),
    OnboardPage(pageNum: 1),
    OnboardPage(pageNum: 2),
    OnboardPage(pageNum: 3),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPageValue);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageBase(
        child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        PageView.builder(
          physics: ClampingScrollPhysics(),
          itemCount: onBoardPages.length,
          onPageChanged: (int page) {
            getChangedPageAndMoveBar(page);
          },
          controller: _pageController,
          itemBuilder: (context, index) {
            return onBoardPages[index];
          },
        ),
        PageIndicator(
          currentPageValue: currentPageValue,
          totalPages: onBoardPages.length,
        ),
        StartChattingButton(
          currentPageValue: currentPageValue,
          totalPages: onBoardPages.length,
        )
      ],
    ));
  }
}
