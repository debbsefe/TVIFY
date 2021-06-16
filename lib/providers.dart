//create themeProvider
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/theme/theme.dart';

import 'features/categories/presentation/notifiers/categories_notifier.dart';
import 'features/categories/presentation/notifiers/categories_state.dart';
import 'features/configuration/presentation/notifiers/configuration_notifier.dart';
import 'features/configuration/presentation/notifiers/configuration_state.dart';
import 'features/single_tv/presentation/notifiers/similar_tv/similar_tv_notifier.dart';
import 'features/single_tv/presentation/notifiers/similar_tv/similar_tv_state.dart';
import 'features/single_tv/presentation/notifiers/tv_cast/tv_cast_notifier.dart';
import 'features/single_tv/presentation/notifiers/tv_cast/tv_cast_state.dart';
import 'features/single_tv/presentation/notifiers/tv_detail/tv_detail_notifier.dart';
import 'features/single_tv/presentation/notifiers/tv_detail/tv_detail_state.dart';
import 'features/trending/presentation/notifiers/daily_trending_notifier.dart';
import 'features/trending/presentation/notifiers/daily_trending_state.dart';
import 'features/trending/presentation/notifiers/weekly_trending_notifier.dart';
import 'features/trending/presentation/notifiers/weekly_trending_state.dart';
import 'service_locator.dart' as di;

final themeProvider = StateNotifierProvider<CustomTheme, ThemeData>((ref) {
  return di.sl<CustomTheme>();
});

final configurationProvider =
    StateNotifierProvider<ConfigurationNotifier, ConfigurationState>((ref) {
  return di.sl<ConfigurationNotifier>();
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

final similarTvProvider =
    StateNotifierProvider<SimilarTvNotifier, SimilarTvState>((ref) {
  return di.sl<SimilarTvNotifier>();
});

final tvCastProvider =
    StateNotifierProvider<TvCastNotifier, TvCastState>((ref) {
  return di.sl<TvCastNotifier>();
});

final tvDetailProvider =
    StateNotifierProvider<TvDetailNotifier, TvDetailState>((ref) {
  return di.sl<TvDetailNotifier>();
});
