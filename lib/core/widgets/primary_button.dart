import 'package:flutter/material.dart';

import '../constants/app_radius.dart';
import '../theme/app_colors.dart';

/// Brand-coloured primary CTA used across onboarding and forms.
///
/// Falls back to a single solid colour when [gradient] is disabled so it can
/// be used inside dense lists without visual overload.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.gradient = true,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool gradient;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null;
    final Widget content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (icon != null) ...<Widget>[
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Colors.white),
        ),
      ],
    );

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Ink(
            height: 56,
            decoration: BoxDecoration(
              gradient: gradient ? AppColors.brandGradient : null,
              color: gradient ? null : AppColors.primary,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Center(child: content),
          ),
        ),
      ),
    );
  }
}
