class MessagingStrings {
  static const List<String> suppressFeedbackText = [
    "Hold on, I'm thinking...",
    "Hi! I am TheraBot. I am here to talk to you about any mental health problems you might be having."
  ];

  static const List<String> botInitPhrases = [
    "Welcome to the overworld for the ParlAI messenger chatbot demo. Please type \"begin\" to start, or \"exit\" to exit",
    "Welcome to the ParlAI Chatbot demo. You are now paired with a bot - feel free to send a message.Type [DONE] to finish the chat, or [RESET] to reset the dialogue history."
  ];

  static const String welcomeMessage =
      "Hi! I am TheraBot. I am here to talk to you about any mental health problems you might be having.";

  static const String convoInit = '{"text": "Hi"}';
  static const String convoBegin = '{"text": "Begin"}';
  static const String convoDone = '{"text": "[DONE]"}';
  static const String convoExit = '{"text": "[EXIT]"}';

  static String getConvoBegin(String convo) {
    return '{"text": "begin", "payload": $convo}';
  }

  static const String emojiFilter =
      r"(\u00a9|\u00ae|[\u2028-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])";
}
