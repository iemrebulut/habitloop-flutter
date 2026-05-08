/// Uygulama genelinde kullanılan tarih yardımcıları.
class HabitDateUtils {
  const HabitDateUtils._();

  static const List<String> _weekdayShort = <String>[
    'Pzt',
    'Sal',
    'Çar',
    'Per',
    'Cum',
    'Cmt',
    'Paz',
  ];

  static const List<String> _weekdayLong = <String>[
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar',
  ];

  static const List<String> _monthLong = <String>[
    'Ocak',
    'Şubat',
    'Mart',
    'Nisan',
    'Mayıs',
    'Haziran',
    'Temmuz',
    'Ağustos',
    'Eylül',
    'Ekim',
    'Kasım',
    'Aralık',
  ];

  /// Saat bilgisinden arındırılmış tarih döner; iki "aynı gün" anı eşit
  /// karşılaştırılabilir.
  static DateTime startOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  /// İçinde bulunulan haftanın yedi gününü (Pzt → Paz) liste olarak döner.
  static List<DateTime> currentWeek({DateTime? now}) {
    final DateTime today = startOfDay(now ?? DateTime.now());
    final DateTime monday = today.subtract(Duration(days: today.weekday - 1));
    return List<DateTime>.generate(7, (int i) => monday.add(Duration(days: i)));
  }

  /// Dashboard başlığında gösterilen "Salı, 6 Mayıs" biçimli etiket.
  static String prettyDate(DateTime date) {
    final String month = _monthLong[date.month - 1];
    return '${_weekdayLong[date.weekday - 1]}, ${date.day} $month';
  }

  static String weekdayShort(DateTime date) => _weekdayShort[date.weekday - 1];

  /// Yerel saate göre günün selamlaması.
  static String greeting(DateTime now) {
    final int h = now.hour;
    if (h < 12) return 'Günaydın';
    if (h < 18) return 'İyi günler';
    return 'İyi akşamlar';
  }
}
