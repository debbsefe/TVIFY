//create themeProvider
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/theme/theme.dart';

import 'features/categories/presentation/notifiers/categories_notifier.dart';
import 'features/categories/presentation/notifiers/categories_state.dart';

import 'features/trending/presentation/notifiers/trending_notifier.dart';
import 'features/trending/presentation/notifiers/trending_state.dart';
import 'injection_container.dart' as di;

final themeProvider = StateNotifierProvider<CustomTheme, ThemeData>((ref) {
  return di.sl<CustomTheme>();
});

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, CategoriesState>((ref) {
  return di.sl<CategoriesNotifier>();
});

final trendingProvider =
    StateNotifierProvider<TrendingNotifier, TrendingState>((ref) {
  return di.sl<TrendingNotifier>();
});
