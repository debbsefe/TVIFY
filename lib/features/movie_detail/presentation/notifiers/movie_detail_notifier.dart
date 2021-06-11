import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/strings.dart';
import '../../domain/usecases/get_movie_detail.dart';
import 'movie_detail_state.dart';

class MovieDetailNotifier extends StateNotifier<MovieDetailState> {
  MovieDetailNotifier(this.movieDetail) : super(MovieDetailInitial());

  final GetMovieDetail movieDetail;

  void fetchMovieDetail(String id) async {
    state = MovieDetailLoading();
    final result = await movieDetail(Params(id: id));
    result.fold(
      (failure) => state = MovieDetailError(mapFailureToMessage(failure)),
      (result) => state = MovieDetailLoaded(result),
    );
  }
}
