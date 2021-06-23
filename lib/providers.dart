//create themeProvider
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/theme/theme.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_cast.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_detail.dart';

import 'core/notifiers/generic_state.dart';
import 'features/auth/presentation/notifiers/anonymous_sign_in_notifier.dart';
import 'features/auth/presentation/notifiers/google_sign_in_notifier.dart';
import 'features/categories/domain/entities/categories.dart';
import 'features/categories/presentation/notifiers/categories_notifier.dart';
import 'features/configuration/domain/entities/configuration.dart';
import 'features/configuration/presentation/notifiers/configuration_notifier.dart';
import 'features/single_tv/presentation/notifiers/similar_tv/similar_tv_notifier.dart';
import 'features/single_tv/presentation/notifiers/tv_cast/tv_cast_notifier.dart';
import 'features/single_tv/presentation/notifiers/tv_detail/tv_detail_notifier.dart';
import 'features/trending/presentation/notifiers/daily_trending_notifier.dart';
import 'features/trending/presentation/notifiers/weekly_trending_notifier.dart';
import 'service_locator.dart' as di;

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final userChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).userChanges());

final themeProvider = StateNotifierProvider<CustomTheme, ThemeData>((ref) {
  return di.sl<CustomTheme>();
});

final configurationProvider =
    StateNotifierProvider<ConfigurationNotifier, GenericState<Configuration>>(
        (ref) {
  return di.sl<ConfigurationNotifier>();
});

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, GenericState<List<Categories>>>(
        (ref) {
  return di.sl<CategoriesNotifier>();
});

final weeklyTrendingProvider =
    StateNotifierProvider<WeeklyTrendingNotifier, GenericState<List<TvList>>>(
        (ref) {
  return di.sl<WeeklyTrendingNotifier>();
});

final dailyTrendingProvider =
    StateNotifierProvider<DailyTrendingNotifier, GenericState<List<TvList>>>(
        (ref) {
  return di.sl<DailyTrendingNotifier>();
});

final similarTvProvider =
    StateNotifierProvider<SimilarTvNotifier, GenericState<List<TvList>>>((ref) {
  return di.sl<SimilarTvNotifier>();
});

final tvCastProvider =
    StateNotifierProvider<TvCastNotifier, GenericState<List<TvCast>>>((ref) {
  return di.sl<TvCastNotifier>();
});

final tvDetailProvider =
    StateNotifierProvider<TvDetailNotifier, GenericState<TvDetail>>((ref) {
  return di.sl<TvDetailNotifier>();
});

final googleSignInProvider =
    StateNotifierProvider<GoogleSignInNotifier, GenericState<User?>>((ref) {
  return di.sl<GoogleSignInNotifier>();
});

final anonymousSignInProvider =
    StateNotifierProvider<AnonymousSignInNotifier, GenericState<User?>>((ref) {
  return di.sl<AnonymousSignInNotifier>();
});
