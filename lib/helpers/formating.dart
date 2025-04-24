String capitalizeText(String text, String option) {
  if (text.trim().isEmpty) return "";

  List<String> words = text.trim().split(" ");

  if (option == "nickname") {
    String firstWord = words.first;
    return "${firstWord[0].toUpperCase()}${firstWord.substring(1)}";
  }

  String capitalWord = "";

  for (final word in words) {
    capitalWord += "${word[0].toUpperCase()}${word.substring(1)} ";
  }
  
  return capitalWord;
}
