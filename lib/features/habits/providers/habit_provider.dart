import 'package:flutter/material.dart';

import '../data/mock_habit_repository.dart';
import '../models/habit_category.dart';
import '../models/habit_model.dart';

/// In-memory store + filter state for habits.
///
/// All state lives here so screens stay mostly stateless. The provider is
/// created once at app boot via [ChangeNotifierProvider] in `app.dart`.
class HabitProvider extends ChangeNotifier {
  HabitProvider({MockHabitRepository? repository})
      : _repository = repository ?? MockHabitRepository() {
    _habits = _repository.seed();
  }

  final MockHabitRepository _repository;
  late List<HabitModel> _habits;

  /// `null` means "no filter, show everything".
  HabitCategory? _activeCategory;

  List<HabitModel> get habits => List<HabitModel>.unmodifiable(_habits);

  HabitCategory? get activeCategory => _activeCategory;

  /// Habits matching the active category filter (or all if no filter).
  List<HabitModel> get visibleHabits {
    if (_activeCategory == null) return habits;
    return _habits
        .where((HabitModel h) => h.category == _activeCategory)
        .toList(growable: false);
  }

  // ---- Aggregates ---------------------------------------------------------

  int get completedToday =>
      _habits.where((HabitModel h) => h.isCompletedToday).length;

  int get totalToday => _habits.length;

  double get dailyCompletionRate =>
      totalToday == 0 ? 0 : completedToday / totalToday;

  int get longestStreak => _habits.isEmpty
      ? 0
      : _habits.map((HabitModel h) => h.streak).reduce(
            (int a, int b) => a > b ? a : b,
          );

  int get totalCompletions =>
      _habits.fold(0, (int sum, HabitModel h) => sum + h.completedDays);

  /// Average weekly completion rate across all habits, in `[0, 1]`.
  double get weeklySuccessRate {
    if (_habits.isEmpty) return 0;
    final double sum = _habits.fold<double>(
      0,
      (double acc, HabitModel h) => acc + h.weeklyCompletionRate,
    );
    return sum / _habits.length;
  }

  // ---- Mutations ----------------------------------------------------------

  void setCategoryFilter(HabitCategory? category) {
    if (_activeCategory == category) return;
    _activeCategory = category;
    notifyListeners();
  }

  /// Flips today's completion state for the given habit and keeps the streak
  /// + weekly progress in sync so the UI reflects an immediate change.
  void toggleCompletion(String habitId) {
    final int index = _habits.indexWhere((HabitModel h) => h.id == habitId);
    if (index == -1) return;

    final HabitModel current = _habits[index];
    final bool nowCompleted = !current.isCompletedToday;

    final List<bool> updatedWeek = List<bool>.from(current.weeklyProgress);
    if (updatedWeek.isNotEmpty) {
      updatedWeek[updatedWeek.length - 1] = nowCompleted;
    }

    _habits[index] = current.copyWith(
      isCompletedToday: nowCompleted,
      streak: nowCompleted
          ? current.streak + 1
          : (current.streak > 0 ? current.streak - 1 : 0),
      completedDays: nowCompleted
          ? current.completedDays + 1
          : (current.completedDays > 0 ? current.completedDays - 1 : 0),
      weeklyProgress: updatedWeek,
    );
    notifyListeners();
  }

  void addHabit(HabitModel habit) {
    _habits = <HabitModel>[habit, ..._habits];
    notifyListeners();
  }

  void removeHabit(String habitId) {
    _habits = _habits
        .where((HabitModel h) => h.id != habitId)
        .toList(growable: false);
    notifyListeners();
  }

  HabitModel? findById(String habitId) {
    for (final HabitModel h in _habits) {
      if (h.id == habitId) return h;
    }
    return null;
  }
}
