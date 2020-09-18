import 'package:flutter/material.dart';
import 'package:flutter_chatbot/ui/views/onboarding/pageview_placeholder.dart';

class OnBoardPages extends StatefulWidget {
  @override
  _OnBoardPagesState createState() => _OnBoardPagesState();
}

class _OnBoardPagesState extends State<OnBoardPages> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: PageView(
      controller: _pageController,
      children: [
        PageviewPlaceholder(pageNum: 0),
        PageviewPlaceholder(pageNum: 1),
        PageviewPlaceholder(pageNum: 2),
        PageviewPlaceholder(pageNum: 3),
      ],
    )));
  }
}
