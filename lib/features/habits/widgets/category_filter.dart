import 'package:flutter/material.dart';

import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../models/habit_category.dart';

/// Horizontally scrolling pill list. The first pill represents "no filter".
class CategoryFilter extends StatelessWidget {
  const CategoryFilter({
    super.key,
    required this.activeCategory,
    required this.onChanged,
  });

  final HabitCategory? activeCategory;
  final ValueChanged<HabitCategory?> onChanged;

  @override
  Widget build(BuildContext context) {
    final List<HabitCategory?> entries = <HabitCategory?>[
      null,
      ...HabitCategory.values,
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: entries.length,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (BuildContext context, int index) {
          final HabitCategory? entry = entries[index];
          final bool selected = entry == activeCategory;
          return _Chip(
            label: entry?.label ?? AppStrings.allCategory,
            icon: entry?.icon,
            selected: selected,
            onTap: () => onChanged(entry),
          );
        },
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color background = selected
        ? theme.colorScheme.primary
        : theme.colorScheme.surface;
    final Color foreground = selected
        ? Colors.white
        : theme.colorScheme.onSurface.withValues(alpha: 0.8);

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(
              color: selected ? Colors.transparent : theme.dividerColor,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(icon, size: 16, color: foreground),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
