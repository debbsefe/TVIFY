import 'package:movie_colony/features/categories/domain/entities/categories.dart';
import 'package:movie_colony/features/single_tv/data/models/tv_detail_model.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_detail.dart';

const tTvDetail = TvDetail(
  id: 1,
  name: 'Romance',
  startDate: '02/12/12',
  posterImage: 'xhw',
  rating: 12,
  backdropImage: '2',
  overview: 'test',
  categories: [
    Categories(id: 1, name: 'Romance'),
    Categories(id: 2, name: 'Comedy'),
  ],
  seasons: 2,
);

final tTvDetailModel = TvDetailModel(
  id: 1,
  name: 'Romance',
  firstAirDate: '02/12/12',
  posterPath: 'xhw',
  voteAverage: 12,
  overview: 'test',
  categories: const [
    Categories(id: 1, name: 'Romance'),
    Categories(id: 2, name: 'Comedy'),
  ],
  numberOfSeasons: 2,
  backdropPath: '2',
  genres: [
    Genre(id: 1, name: 'Romance'),
    Genre(id: 2, name: 'Comedy'),
  ],
);

const String tId = '555';
