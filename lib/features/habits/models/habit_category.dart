import 'package:flutter/material.dart';

/// Alışkanlık listesini filtrelemekte kullanılan kaba kategori kümeleri.
///
/// Etiket ve ikon enum ile birlikte tanımlandığından ekranlar değer üzerinde
/// switch yazmak zorunda kalmaz.
enum HabitCategory {
  health(label: 'Sağlık', icon: Icons.favorite_rounded),
  mindfulness(label: 'Farkındalık', icon: Icons.self_improvement_rounded),
  fitness(label: 'Spor', icon: Icons.fitness_center_rounded),
  learning(label: 'Öğrenme', icon: Icons.menu_book_rounded),
  productivity(label: 'Üretkenlik', icon: Icons.bolt_rounded),
  lifestyle(label: 'Yaşam', icon: Icons.bedtime_rounded);

  const HabitCategory({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
