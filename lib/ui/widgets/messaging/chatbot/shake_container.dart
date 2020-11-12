import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/models/chat_model.dart';
import 'package:flutter_chatbot/ui/widgets/messaging/chatbot/feedback_buttons.dart';
import 'package:provider/provider.dart';

// Parent: BotResponse
class ShakeContainer extends StatefulWidget {
  final Function(int) setFeedbackView;

  ShakeContainer({this.setFeedbackView});

  @override
  _ShakeContainerState createState() => _ShakeContainerState();
}

class _ShakeContainerState extends State<ShakeContainer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    // ..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(0.25, 0.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticIn))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            }
          });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool highlightFeedback =
        Provider.of<ChatModel>(context, listen: false).getHighlightFeedback();

    if (highlightFeedback && _controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    }

    return SlideTransition(
        position: _offsetAnimation,
        child: FeedbackButtons(
          setFeedbackView: widget.setFeedbackView,
        ));
  }
}
