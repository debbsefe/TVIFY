import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/strings.dart';
import '../../../domain/usecases/get_tv_detail.dart';
import 'tv_detail_state.dart';

class TvDetailNotifier extends StateNotifier<TvDetailState> {
  TvDetailNotifier(this.tvDetail) : super(TvDetailInitial());

  final GetTvDetail tvDetail;

  void fetchTvDetail(String id) async {
    state = TvDetailLoading();
    final result = await tvDetail(Params(id: id));
    result.fold(
      (failure) => state = TvDetailError(mapFailureToMessage(failure)),
      (result) => state = TvDetailLoaded(result),
    );
  }
}
