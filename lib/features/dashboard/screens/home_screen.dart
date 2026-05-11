import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/progress_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../habits/models/habit_model.dart';
import '../../habits/providers/habit_provider.dart';
import '../../habits/screens/add_habit_screen.dart';
import '../../habits/screens/habit_detail_screen.dart';
import '../../habits/widgets/category_filter.dart';
import '../../habits/widgets/habit_card.dart';
import '../../statistics/screens/statistics_screen.dart';
import '../widgets/greeting_header.dart';

/// Root navigation host. Holds the bottom nav and swaps between dashboard
/// and statistics tabs.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;

  static const List<Widget> _tabs = <Widget>[
    _DashboardTab(),
    StatisticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _tabIndex, children: _tabs),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (int i) => setState(() => _tabIndex = i),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights_rounded),
            label: 'İstatistik',
          ),
        ],
      ),
      floatingActionButton: _tabIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const AddHabitScreen(),
                ),
              ),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Alışkanlık Ekle'),
            )
          : null,
    );
  }
}

class _DashboardTab extends StatelessWidget {
  const _DashboardTab();

  @override
  Widget build(BuildContext context) {
    final HabitProvider provider = context.watch<HabitProvider>();
    final List<HabitModel> habits = provider.visibleHabits;

    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                const GreetingHeader(),
                const SizedBox(height: AppSpacing.xl),
                ProgressCard(
                  completed: provider.completedToday,
                  total: provider.totalToday,
                  percentage: provider.dailyCompletionRate,
                ),
                const SizedBox(height: AppSpacing.xl),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: CategoryFilter(
              activeCategory: provider.activeCategory,
              onChanged: provider.setCategoryFilter,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            sliver: SliverToBoxAdapter(
              child: SectionHeader(
                title: AppStrings.todayHabits,
                subtitle:
                    '${provider.completedToday}/${provider.totalToday} tamamlandı',
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
          if (habits.isEmpty)
            const SliverToBoxAdapter(child: _EmptyHabitState())
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.xxxl * 2,
              ),
              sliver: SliverList.separated(
                itemCount: habits.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.md),
                itemBuilder: (BuildContext context, int index) {
                  final HabitModel habit = habits[index];
                  return HabitCard(
                    habit: habit,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => HabitDetailScreen(habitId: habit.id),
                      ),
                    ),
                    onToggle: () =>
                        context.read<HabitProvider>().toggleCompletion(habit.id),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptyHabitState extends StatelessWidget {
  const _EmptyHabitState();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.auto_awesome_rounded,
              color: theme.colorScheme.primary,
              size: 36,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              AppStrings.emptyHabits,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              AppStrings.emptyHabitsHint,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color:
                    theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
