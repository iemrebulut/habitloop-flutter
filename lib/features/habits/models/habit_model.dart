import 'package:flutter/material.dart';

import 'habit_category.dart';
import 'habit_frequency.dart';

/// Immutable domain model for a single habit.
///
/// All mutations go through [copyWith] so the provider can publish a new
/// value and rebuild listening widgets without aliasing surprises.
@immutable
class HabitModel {
  const HabitModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.frequency,
    required this.color,
    required this.icon,
    required this.streak,
    required this.targetDays,
    required this.completedDays,
    required this.weeklyProgress,
    required this.isCompletedToday,
    required this.reminderTime,
  });

  final String id;
  final String title;
  final String description;
  final HabitCategory category;
  final HabitFrequency frequency;
  final Color color;
  final IconData icon;

  /// Current consecutive-day streak.
  final int streak;

  /// Target completions for the current period (e.g. 7 for a weekly target).
  final int targetDays;

  /// Total all-time completions.
  final int completedDays;

  /// Last 7 days, oldest → newest. true = completed that day.
  final List<bool> weeklyProgress;

  final bool isCompletedToday;

  final TimeOfDay reminderTime;

  /// Fraction of weekly target hit so far. Always in `[0, 1]`.
  double get weeklyCompletionRate {
    if (weeklyProgress.isEmpty) return 0;
    final int hits = weeklyProgress.where((bool e) => e).length;
    return hits / weeklyProgress.length;
  }

  HabitModel copyWith({
    String? title,
    String? description,
    HabitCategory? category,
    HabitFrequency? frequency,
    Color? color,
    IconData? icon,
    int? streak,
    int? targetDays,
    int? completedDays,
    List<bool>? weeklyProgress,
    bool? isCompletedToday,
    TimeOfDay? reminderTime,
  }) {
    return HabitModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      frequency: frequency ?? this.frequency,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      streak: streak ?? this.streak,
      targetDays: targetDays ?? this.targetDays,
      completedDays: completedDays ?? this.completedDays,
      weeklyProgress: weeklyProgress ?? this.weeklyProgress,
      isCompletedToday: isCompletedToday ?? this.isCompletedToday,
      reminderTime: reminderTime ?? this.reminderTime,
    );
  }
}
