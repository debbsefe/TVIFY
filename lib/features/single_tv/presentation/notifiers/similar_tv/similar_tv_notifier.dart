import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';

import 'package:movie_colony/features/single_tv/domain/usecases/get_similar_tv.dart';

class SimilarTvNotifier extends GenericStateNotifier<List<TvList>> {
  SimilarTvNotifier(this.similarTv);

  final GetSimilarTv similarTv;

  void fetchSimilarTv(String id) {
    sendRequest(() async {
      return await similarTv(Params(id: id));
    });
  }
}
