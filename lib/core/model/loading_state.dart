import 'package:freezed_annotation/freezed_annotation.dart';

part 'loading_state.freezed.dart';

@freezed
class LoadingState with _$LoadingState {
  const factory LoadingState.idle() = _LoadingStateIdle;
  const factory LoadingState.loading() = _LoadingStateLoading;
  const factory LoadingState.success([Object? obj]) = _LoadingStateSuccess;
  const factory LoadingState.error(Object? error) = _LoadingStateError;
}
