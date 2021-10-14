import 'package:flutter/material.dart';
import 'package:therabot/widgets/page_base.dart';
import 'package:therabot/widgets/onboard/onboard_page.dart';
import 'package:therabot/widgets/onboard/page_indicator.dart';
import 'package:therabot/widgets/onboard/start_chatting_button.dart';

class OnBoardPageview extends StatefulWidget {
  const OnBoardPageview({Key? key}) : super(key: key);

  @override
  _OnBoardPageviewState createState() => _OnBoardPageviewState();
}

class _OnBoardPageviewState extends State<OnBoardPageview> {
  int currentPageValue = 0;
  PageController? _pageController;
  final List<Widget> onBoardPages = [
    const OnboardPage(pageNum: 0),
    const OnboardPage(pageNum: 1),
    const OnboardPage(pageNum: 2),
    const OnboardPage(pageNum: 3),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPageValue);
  }

  @override
  void dispose() {
    _pageController?.dispose();
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
          physics: const ClampingScrollPhysics(),
          itemCount: onBoardPages.length,
          onPageChanged: getChangedPageAndMoveBar,
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
