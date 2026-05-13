import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_header.dart';
import '../models/habit_model.dart';
import '../providers/habit_provider.dart';
import '../widgets/weekly_progress_chart.dart';

/// Single-habit detail view: hero header, weekly chart, key stats and a
/// completion CTA.
class HabitDetailScreen extends StatelessWidget {
  const HabitDetailScreen({super.key, required this.habitId});

  final String habitId;

  @override
  Widget build(BuildContext context) {
    final HabitProvider provider = context.watch<HabitProvider>();
    final HabitModel? habit = provider.findById(habitId);

    if (habit == null) {
      return const Scaffold(
        body: Center(child: Text('Alışkanlık bulunamadı.')),
      );
    }

    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _DetailHeader(habit: habit),
              const SizedBox(height: AppSpacing.xl),
              _StatsRow(habit: habit),
              const SizedBox(height: AppSpacing.xl),
              const SectionHeader(
                title: AppStrings.last7Days,
                subtitle: AppStrings.weeklyProgress,
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: WeeklyProgressChart(
                  weeklyProgress: habit.weeklyProgress,
                  color: habit.color,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: habit.color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.tips_and_updates_rounded, color: habit.color),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        AppStrings.motivation,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              PrimaryButton(
                label: habit.isCompletedToday
                    ? 'Tamamlanmadı Olarak İşaretle'
                    : 'Tamamlandı Olarak İşaretle',
                icon: habit.isCompletedToday
                    ? Icons.refresh_rounded
                    : Icons.check_circle_rounded,
                onPressed: () =>
                    context.read<HabitProvider>().toggleCompletion(habit.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({required this.habit});

  final HabitModel habit;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_rounded),
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: habit.color.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Icon(habit.icon, color: habit.color, size: 28),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          habit.title,
                          style: theme.textTheme.headlineMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          habit.category.label,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(habit.description, style: theme.textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.habit});

  final HabitModel habit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _StatTile(
            label: AppStrings.streak,
            value: '${habit.streak}',
            icon: Icons.local_fire_department_rounded,
            color: habit.color,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _StatTile(
            label: 'Tamamlanma',
            value: '${(habit.weeklyCompletionRate * 100).round()}%',
            icon: Icons.show_chart_rounded,
            color: habit.color,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _StatTile(
            label: 'Toplam Gün',
            value: '${habit.completedDays}',
            icon: Icons.event_available_rounded,
            color: habit.color,
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color, size: 18),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: theme.textTheme.titleLarge),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
