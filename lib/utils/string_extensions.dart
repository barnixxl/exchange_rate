extension StringNullableUtils on String? {
  DateTime? toIsoDateTime() {
    if (this != null) {
      try {
        return DateTime.tryParse(this!);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
