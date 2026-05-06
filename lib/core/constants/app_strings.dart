/// Uygulama genelinde kullanılan sabit metinler.
///
/// Tüm yazıların tek dosyada toplanması hem tutarlılığı kolaylaştırır
/// hem de ileride yapılacak yerelleştirmeyi (i18n) sade tutar.
class AppStrings {
  const AppStrings._();

  static const String appName = 'HabitLoop';
  static const String tagline = 'Daha iyi alışkanlıklar kur, döngüyle ilerle.';
  static const String getStarted = 'Hadi Başla';

  static const String todayHabits = 'Bugünkü Alışkanlıklar';
  static const String allCategory = 'Tümü';
  static const String emptyHabits = 'Bu görünümde henüz alışkanlık yok.';
  static const String emptyHabitsHint =
      'İlk alışkanlığını eklemek için + simgesine dokun.';

  static const String statistics = 'İstatistikler';
  static const String overview = 'Genel Bakış';
  static const String weeklyProgress = 'Haftalık İlerleme';
  static const String last7Days = 'Son 7 Gün';
  static const String streak = 'Günlük Seri';
  static const String motivation =
      'Küçük adımlar, her gün. Döngüler işte böyle değişime dönüşür.';

  static const String addHabit = 'Yeni Alışkanlık';
  static const String habitName = 'Alışkanlık Adı';
  static const String habitNameHint = 'ör. Günde 20 sayfa oku';
  static const String description = 'Açıklama';
  static const String descriptionHint = 'Bu senin için neden önemli?';
  static const String category = 'Kategori';
  static const String frequency = 'Sıklık';
  static const String reminderTime = 'Hatırlatma Saati';
  static const String color = 'Renk';
  static const String save = 'Alışkanlığı Kaydet';
}
