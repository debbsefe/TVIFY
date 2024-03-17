import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_cast.dart';

import 'package:movie_colony/features/single_tv/domain/usecases/get_tv_cast.dart';

class TvCastNotifier extends GenericStateNotifier<List<TvCast>> {
  TvCastNotifier(this.tvCast);

  final GetTvCast tvCast;

  void fetchTvCast(String id) {
    sendRequest(() async {
      return await tvCast(Params(id: id));
    });
  }
}
