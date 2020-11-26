// TODO refactor tu accept multiple chars remove
String removeChar(String val) {
  var splitted = val.split("\n");
  return splitted.join().split("/").join("");
}
