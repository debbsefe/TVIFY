//create themeProvider
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/theme/theme.dart';

import 'features/categories/presentation/notifiers/categories_notifier.dart';
import 'features/categories/presentation/notifiers/categories_state.dart';

import 'features/trending/presentation/notifiers/daily_trending_notifier.dart';
import 'features/trending/presentation/notifiers/daily_trending_state.dart';
import 'features/trending/presentation/notifiers/weekly_trending_notifier.dart';
import 'features/trending/presentation/notifiers/weekly_trending_state.dart';
import 'service_locator.dart' as di;

final themeProvider = StateNotifierProvider<CustomTheme, ThemeData>((ref) {
  return di.sl<CustomTheme>();
});

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, CategoriesState>((ref) {
  return di.sl<CategoriesNotifier>();
});

final weeklyTrendingProvider =
    StateNotifierProvider<WeeklyTrendingNotifier, WeeklyTrendingState>((ref) {
  return di.sl<WeeklyTrendingNotifier>();
});

final dailyTrendingProvider =
    StateNotifierProvider<DailyTrendingNotifier, DailyTrendingState>((ref) {
  return di.sl<DailyTrendingNotifier>();
});
