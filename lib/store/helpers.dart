String concatMessages(String msg1, String msg2) {
  msg1 = msg1.trim();
  msg2 = msg2.trim();

  var needsPeriod = msg1.isNotEmpty && !(msg1.endsWith(".") || msg1.endsWith("!") || msg1.endsWith("?"));
  var periodStr = needsPeriod ? "." : "";

  return "$msg1$periodStr $msg2";
}

void main() {
  var msg1 = "hello ";
  var msg2 = "how are you?";
  print(concatMessages(msg1, msg2));
  print(concatMessages(msg2, msg1));
}