/// Bir alışkanlığın hangi sıklıkta yapılacağını ifade eder.
enum HabitFrequency {
  daily(label: 'Günlük'),
  weekdays(label: 'Hafta İçi'),
  weekends(label: 'Hafta Sonu'),
  custom(label: 'Özel');

  const HabitFrequency({required this.label});

  final String label;
}
