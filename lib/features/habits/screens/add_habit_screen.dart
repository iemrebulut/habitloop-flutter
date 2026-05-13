import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_header.dart';
import '../models/habit_category.dart';
import '../models/habit_frequency.dart';
import '../models/habit_model.dart';
import '../providers/habit_provider.dart';

/// Form for adding a new habit. State is local; on save we push the new
/// habit to [HabitProvider] and pop back.
class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  HabitCategory _category = HabitCategory.health;
  HabitFrequency _frequency = HabitFrequency.daily;
  Color _color = AppColors.habitPalette.first;
  TimeOfDay _reminder = const TimeOfDay(hour: 8, minute: 0);

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickReminderTime() async {
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: _reminder,
    );
    if (selected != null) setState(() => _reminder = selected);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final HabitModel habit = HabitModel(
      id: 'habit-${DateTime.now().millisecondsSinceEpoch}',
      title: _titleCtrl.text.trim(),
      description: _descriptionCtrl.text.trim(),
      category: _category,
      frequency: _frequency,
      color: _color,
      icon: _category.icon,
      streak: 0,
      targetDays: 30,
      completedDays: 0,
      weeklyProgress: const <bool>[
        false,
        false,
        false,
        false,
        false,
        false,
        false,
      ],
      isCompletedToday: false,
      reminderTime: _reminder,
    );
    context.read<HabitProvider>().addHabit(habit);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.addHabit)),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: <Widget>[
              const SectionHeader(title: AppStrings.habitName),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _titleCtrl,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: AppStrings.habitNameHint,
                ),
                validator: (String? value) =>
                    (value == null || value.trim().isEmpty)
                        ? 'Lütfen bir ad gir'
                        : null,
              ),
              const SizedBox(height: AppSpacing.xl),
              const SectionHeader(title: AppStrings.description),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _descriptionCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: AppStrings.descriptionHint,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              const SectionHeader(title: AppStrings.category),
              const SizedBox(height: AppSpacing.md),
              _CategorySelector(
                selected: _category,
                onChanged: (HabitCategory c) => setState(() => _category = c),
              ),
              const SizedBox(height: AppSpacing.xl),
              const SectionHeader(title: AppStrings.frequency),
              const SizedBox(height: AppSpacing.md),
              _FrequencySelector(
                selected: _frequency,
                onChanged: (HabitFrequency f) =>
                    setState(() => _frequency = f),
              ),
              const SizedBox(height: AppSpacing.xl),
              const SectionHeader(title: AppStrings.reminderTime),
              const SizedBox(height: AppSpacing.md),
              InkWell(
                onTap: _pickReminderTime,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.lg,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.alarm_rounded),
                      const SizedBox(width: AppSpacing.md),
                      Text(
                        _reminder.format(context),
                        style: theme.textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.5),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              const SectionHeader(title: AppStrings.color),
              const SizedBox(height: AppSpacing.md),
              _ColorSelector(
                selected: _color,
                onChanged: (Color c) => setState(() => _color = c),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              PrimaryButton(
                label: AppStrings.save,
                icon: Icons.check_rounded,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategorySelector extends StatelessWidget {
  const _CategorySelector({required this.selected, required this.onChanged});

  final HabitCategory selected;
  final ValueChanged<HabitCategory> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: HabitCategory.values.map((HabitCategory c) {
        final bool active = c == selected;
        return _PillOption(
          label: c.label,
          icon: c.icon,
          active: active,
          onTap: () => onChanged(c),
        );
      }).toList(),
    );
  }
}

class _FrequencySelector extends StatelessWidget {
  const _FrequencySelector({required this.selected, required this.onChanged});

  final HabitFrequency selected;
  final ValueChanged<HabitFrequency> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: HabitFrequency.values.map((HabitFrequency f) {
        return _PillOption(
          label: f.label,
          active: f == selected,
          onTap: () => onChanged(f),
        );
      }).toList(),
    );
  }
}

class _PillOption extends StatelessWidget {
  const _PillOption({
    required this.label,
    required this.active,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color bg =
        active ? theme.colorScheme.primary : theme.colorScheme.surface;
    final Color fg = active
        ? Colors.white
        : theme.colorScheme.onSurface.withValues(alpha: 0.85);

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(
              color: active ? Colors.transparent : theme.dividerColor,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(icon, size: 16, color: fg),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: fg,
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

class _ColorSelector extends StatelessWidget {
  const _ColorSelector({required this.selected, required this.onChanged});

  final Color selected;
  final ValueChanged<Color> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: AppColors.habitPalette.map((Color c) {
        final bool active = c.toARGB32() == selected.toARGB32();
        return GestureDetector(
          onTap: () => onChanged(c),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: c,
              shape: BoxShape.circle,
              border: Border.all(
                color: active
                    ? Theme.of(context).colorScheme.onSurface
                    : Colors.transparent,
                width: 3,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: c.withValues(alpha: 0.35),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: active
                ? const Icon(Icons.check_rounded, color: Colors.white, size: 20)
                : null,
          ),
        );
      }).toList(),
    );
  }
}
