import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/strings.dart';
import '../../../domain/usecases/get_tv_cast.dart';
import 'tv_cast_state.dart';

class TvCastNotifier extends StateNotifier<TvCastState> {
  TvCastNotifier(this.tvCast) : super(TvCastInitial());

  final GetTvCast tvCast;

  void fetchTvCast(String id) async {
    state = TvCastLoading();
    final result = await tvCast(Params(id: id));
    result.fold(
      (failure) => state = TvCastError(mapFailureToMessage(failure)),
      (result) => state = TvCastLoaded(result),
    );
  }
}
