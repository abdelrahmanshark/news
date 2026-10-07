/// Removes Arabic diacritics and tatweel, and unifies the Alef forms,
/// so searches match regardless of how the Arabic text was typed.
String normalizeArabic(String text) {
  return text
      .replaceAll(RegExp(r'[\u064B-\u065F\u0670\u0640]'), '')
      .replaceAll('أ', 'ا')
      .replaceAll('إ', 'ا')
      .replaceAll('آ', 'ا');
}
