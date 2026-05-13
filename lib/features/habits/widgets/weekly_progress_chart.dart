import 'package:flutter/material.dart';

import '../../../core/constants/app_radius.dart';
import '../../../core/utils/date_utils.dart';

/// Compact bar chart visualising the last 7 days of completion.
class WeeklyProgressChart extends StatelessWidget {
  const WeeklyProgressChart({
    super.key,
    required this.weeklyProgress,
    required this.color,
  });

  /// Oldest → newest. Length should be 7 to match the visible labels.
  final List<bool> weeklyProgress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final List<DateTime> days = HabitDateUtils.currentWeek();
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List<Widget>.generate(7, (int i) {
          final bool? completed =
              i < weeklyProgress.length ? weeklyProgress[i] : null;
          final bool isToday = i == DateTime.now().weekday - 1;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeOut,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: completed == true
                            ? color
                            : color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        border: isToday
                            ? Border.all(
                                color: color.withValues(alpha: 0.6),
                                width: 1.2,
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    HabitDateUtils.weekdayShort(days[i]),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface
                          .withValues(alpha: isToday ? 0.95 : 0.55),
                      fontWeight:
                          isToday ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
