extension StringExtension on String {
  String getIdFromUrl() {
    final lastSlashIndex = lastIndexOf('/');
    final secondLastSlashIndex = lastIndexOf('/', lastSlashIndex - 1);
    if (lastSlashIndex != -1 && secondLastSlashIndex != -1) {
      return substring(secondLastSlashIndex + 1, lastSlashIndex);
    } else {
      return '';
    }
  }
}
