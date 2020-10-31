import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/constants/strings.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:flutter_chatbot/ui/views/onboarding/onboard_page.dart';
import 'package:provider/provider.dart';

class OnBoardPages extends StatefulWidget {
  @override
  _OnBoardPagesState createState() => _OnBoardPagesState();
}

class _OnBoardPagesState extends State<OnBoardPages> {
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

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
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
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 75),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < onBoardPages.length; i++)
                          if (i == currentPageValue) ...[circleBar(true)] else
                            circleBar(false),
                      ],
                    ))
              ],
            ),
            Visibility(
                visible:
                    currentPageValue == onBoardPages.length - 1 ? true : false,
                child: Container(
                  margin: EdgeInsets.only(bottom: 58),
                  width: 300,
                  height: 40,
                  child: FloatingActionButton(
                    onPressed: () {
                      Provider.of<AuthService>(context, listen: false)
                          .changeIsNew();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Strings.messagingViewRoute,
                          (Route<dynamic> route) => false);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(26))),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      "Start chatting",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                )),
          ],
        )));
  }
}
