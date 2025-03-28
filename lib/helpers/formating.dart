String capitalizeText(String text) {
  if (text.trim().isEmpty) return "";

  List<String> words = text.trim().split(" ");
  String firstWord = words.first;

  if (firstWord.isEmpty) return "";

  return "${firstWord[0].toUpperCase()}${firstWord.substring(1)}";
}
