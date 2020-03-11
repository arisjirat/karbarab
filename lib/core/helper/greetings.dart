String greeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Pagi';
  }
  if (hour < 16) {
    return 'Siang';
  }
  if (hour < 19) {
    return 'Sore';
  }
  return 'Malam';
}