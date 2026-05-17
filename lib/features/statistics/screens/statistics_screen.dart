import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/section_header.dart';
import '../../habits/models/habit_model.dart';
import '../../habits/providers/habit_provider.dart';
import '../widgets/stat_card.dart';

/// Lightweight dashboard summarising overall habit performance.
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HabitProvider provider = context.watch<HabitProvider>();
    final List<HabitModel> habits = provider.habits;
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: <Widget>[
          Text(AppStrings.statistics, style: theme.textTheme.displayMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Döngülerinin nasıl gittiğine kısa bir bakış.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.2,
            children: <Widget>[
              StatCard(
                label: 'Toplam Tamamlama',
                value: '${provider.totalCompletions}',
                icon: Icons.check_circle_rounded,
                color: AppColors.success,
              ),
              StatCard(
                label: 'En Uzun Seri',
                value: '${provider.longestStreak}g',
                icon: Icons.local_fire_department_rounded,
                color: AppColors.accent,
              ),
              StatCard(
                label: 'Haftalık Başarı',
                value: '${(provider.weeklySuccessRate * 100).round()}%',
                icon: Icons.trending_up_rounded,
                color: AppColors.primary,
              ),
              StatCard(
                label: 'Aktif Alışkanlıklar',
                value: '${habits.length}',
                icon: Icons.repeat_rounded,
                color: AppColors.secondary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          const SectionHeader(
            title: 'Alışkanlık Performansı',
            subtitle: 'Alışkanlık başına haftalık tamamlama oranı',
          ),
          const SizedBox(height: AppSpacing.lg),
          ...habits.map((HabitModel h) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _HabitProgressBar(habit: h),
              )),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _HabitProgressBar extends StatelessWidget {
  const _HabitProgressBar({required this.habit});

  final HabitModel habit;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double rate = habit.weeklyCompletionRate;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: habit.color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(habit.icon, color: habit.color, size: 18),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  habit.title,
                  style: theme.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${(rate * 100).round()}%',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: habit.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: rate,
              minHeight: 8,
              backgroundColor: habit.color.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation<Color>(habit.color),
            ),
          ),
        ],
      ),
    );
  }
}
