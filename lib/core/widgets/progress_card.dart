import 'package:flutter/material.dart';

import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import '../theme/app_colors.dart';

/// A premium gradient card surfacing a single hero metric on the dashboard.
class ProgressCard extends StatelessWidget {
  const ProgressCard({
    super.key,
    required this.completed,
    required this.total,
    required this.percentage,
  });

  final int completed;
  final int total;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Günlük İlerleme',
                  style: text.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  '$completed / $total',
                  style: text.displayMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  total == 0
                      ? 'Döngünü başlatmak için bir alışkanlık ekle.'
                      : 'Bugün tamamlanan alışkanlıklar',
                  style: text.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          _PercentageRing(value: percentage),
        ],
      ),
    );
  }
}

class _PercentageRing extends StatelessWidget {
  const _PercentageRing({required this.value});

  /// 0..1
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 84,
      height: 84,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: value.clamp(0, 1),
              strokeWidth: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.25),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          Text(
            '${(value * 100).round()}%',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
