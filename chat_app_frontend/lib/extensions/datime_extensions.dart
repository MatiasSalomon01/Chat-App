extension DateTimeExtensions on DateTime {
  String getHour() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  String getDateForClipboard() {
    return '$day/$month, ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
