extension StringExtension on String {
  String getIdFromUrl() {
    return substring(length - 2, length - 1);
  }
}
