import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/habit_category.dart';
import '../models/habit_frequency.dart';
import '../models/habit_model.dart';

/// Backend yerine geçen, bellek içi veri kaynağı.
///
/// Repository senkron ve bağımsız tutuldu; uygulamanın geri kalanı sanki
/// gerçek bir servisle konuşuyormuş gibi davranabilsin diye. İleride
/// kalıcı/uzak bir uygulamaya geçmek istenirse aynı arayüzü karşılamak
/// yeterli olur.
class MockHabitRepository {
  /// Her çağrıldığında bağımsız nesnelerden oluşan taze bir liste döner.
  /// Böylece çağrı yapanlar tohum veriye sızıntı bırakmadan değişiklik
  /// yapabilir.
  List<HabitModel> seed() {
    return <HabitModel>[
      HabitModel(
        id: 'sabah-yuruyusu',
        title: 'Sabah Yürüyüşü',
        description: 'Güne dışarıda 20 dakikalık bir yürüyüşle başla.',
        category: HabitCategory.health,
        frequency: HabitFrequency.daily,
        color: AppColors.habitPalette[0],
        icon: Icons.directions_walk_rounded,
        streak: 12,
        targetDays: 30,
        completedDays: 84,
        weeklyProgress: const <bool>[true, true, true, false, true, true, true],
        isCompletedToday: true,
        reminderTime: const TimeOfDay(hour: 7, minute: 0),
      ),
      HabitModel(
        id: 'su-ic',
        title: '2L Su İç',
        description: 'Susuz kalma. Gün boyunca 8 bardak suya yay.',
        category: HabitCategory.health,
        frequency: HabitFrequency.daily,
        color: AppColors.habitPalette[1],
        icon: Icons.water_drop_rounded,
        streak: 24,
        targetDays: 30,
        completedDays: 168,
        weeklyProgress: const <bool>[true, true, true, true, true, true, false],
        isCompletedToday: false,
        reminderTime: const TimeOfDay(hour: 9, minute: 0),
      ),
      HabitModel(
        id: 'kitap-oku',
        title: '20 Sayfa Oku',
        description: 'Günde yirmi sayfa, algoritmadan uzak tutar.',
        category: HabitCategory.learning,
        frequency: HabitFrequency.daily,
        color: AppColors.habitPalette[2],
        icon: Icons.menu_book_rounded,
        streak: 7,
        targetDays: 30,
        completedDays: 41,
        weeklyProgress: const <bool>[
          false,
          true,
          true,
          true,
          true,
          true,
          true,
        ],
        isCompletedToday: true,
        reminderTime: const TimeOfDay(hour: 21, minute: 30),
      ),
      HabitModel(
        id: 'meditasyon',
        title: 'Meditasyon',
        description: '10 dakika nefese odaklı bir durağanlık.',
        category: HabitCategory.mindfulness,
        frequency: HabitFrequency.daily,
        color: AppColors.habitPalette[3],
        icon: Icons.self_improvement_rounded,
        streak: 5,
        targetDays: 30,
        completedDays: 33,
        weeklyProgress: const <bool>[
          true,
          false,
          true,
          true,
          false,
          true,
          true,
        ],
        isCompletedToday: false,
        reminderTime: const TimeOfDay(hour: 8, minute: 0),
      ),
      HabitModel(
        id: 'antrenman',
        title: 'Antrenman',
        description: 'Kuvvet antrenmanı, dört hareket, 45 dakika.',
        category: HabitCategory.fitness,
        frequency: HabitFrequency.weekdays,
        color: AppColors.habitPalette[4],
        icon: Icons.fitness_center_rounded,
        streak: 9,
        targetDays: 20,
        completedDays: 56,
        weeklyProgress: const <bool>[
          true,
          true,
          false,
          true,
          true,
          false,
          false,
        ],
        isCompletedToday: false,
        reminderTime: const TimeOfDay(hour: 18, minute: 30),
      ),
      HabitModel(
        id: 'erken-uyu',
        title: '23.00\'ten Önce Uyu',
        description: 'Yarını koru, 23.00\'te ışıkları kapat.',
        category: HabitCategory.lifestyle,
        frequency: HabitFrequency.daily,
        color: AppColors.habitPalette[5],
        icon: Icons.bedtime_rounded,
        streak: 3,
        targetDays: 30,
        completedDays: 22,
        weeklyProgress: const <bool>[
          false,
          false,
          true,
          true,
          true,
          false,
          true,
        ],
        isCompletedToday: false,
        reminderTime: const TimeOfDay(hour: 22, minute: 30),
      ),
      HabitModel(
        id: 'sekersiz-gun',
        title: 'Şekersiz Gün',
        description: 'Şekerli içecek ve tatlılardan uzak dur.',
        category: HabitCategory.health,
        frequency: HabitFrequency.daily,
        color: AppColors.habitPalette[6],
        icon: Icons.no_food_rounded,
        streak: 14,
        targetDays: 30,
        completedDays: 47,
        weeklyProgress: const <bool>[true, true, true, true, true, false, true],
        isCompletedToday: true,
        reminderTime: const TimeOfDay(hour: 12, minute: 0),
      ),
      HabitModel(
        id: 'ingilizce-cali',
        title: 'İngilizce Çalış',
        description: 'Dil uygulamasında 15 dakika ders.',
        category: HabitCategory.learning,
        frequency: HabitFrequency.daily,
        color: AppColors.habitPalette[7],
        icon: Icons.translate_rounded,
        streak: 31,
        targetDays: 60,
        completedDays: 102,
        weeklyProgress: const <bool>[true, true, true, true, true, true, true],
        isCompletedToday: true,
        reminderTime: const TimeOfDay(hour: 20, minute: 0),
      ),
    ];
  }
}
