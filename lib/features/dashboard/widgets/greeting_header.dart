import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/date_utils.dart';

/// Top-of-dashboard greeting + date line.
class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key, this.userName = 'Arkadaş'});

  final String userName;

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${HabitDateUtils.greeting(now)}, $userName',
          style: theme.textTheme.displayMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          HabitDateUtils.prettyDate(now),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
