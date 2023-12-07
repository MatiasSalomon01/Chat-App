extension DateTimeExtensions on DateTime {
  String getHour() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
