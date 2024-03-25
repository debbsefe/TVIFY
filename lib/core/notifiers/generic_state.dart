import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_state.freezed.dart';

@freezed
class GenericState<T> with _$GenericState<T> {
  const factory GenericState.initial() = Initial<T>;

  const factory GenericState.loading() = Loading<T>;

  const factory GenericState.loaded([T? value]) = Loaded<T>;

  const factory GenericState.error([Object? message]) = Error<T>;
}
