import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therabot/store/chat_provider.dart';
import 'package:therabot/widgets/chatbot/feedback/feedback_buttons.dart';

// Parent: BotResponse
class ShakeContainer extends StatefulWidget {
  final Function(int) setFeedbackView;

  const ShakeContainer({Key? key, required this.setFeedbackView}) : super(key: key);

  @override
  _ShakeContainerState createState() => _ShakeContainerState();
}

class _ShakeContainerState extends State<ShakeContainer>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    // ..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.25, 0.0))
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.elasticIn))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller?.reverse();
            }
          });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool highlightFeedback =
        Provider.of<ChatProvider>(context, listen: false).getHighlightFeedback();

    if (highlightFeedback && _controller?.status == AnimationStatus.dismissed) {
      _controller?.forward();
    }

    return SlideTransition(
        position: _offsetAnimation!,
        child: FeedbackButtons(
          setFeedbackView: widget.setFeedbackView,
        ));
  }
}
