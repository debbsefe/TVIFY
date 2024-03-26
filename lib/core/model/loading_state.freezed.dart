// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loading_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoadingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(Object? obj) success,
    required TResult Function(Object? error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(Object? obj)? success,
    TResult? Function(Object? error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(Object? obj)? success,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadingStateIdle value) idle,
    required TResult Function(_LoadingStateLoading value) loading,
    required TResult Function(_LoadingStateSuccess value) success,
    required TResult Function(_LoadingStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadingStateIdle value)? idle,
    TResult? Function(_LoadingStateLoading value)? loading,
    TResult? Function(_LoadingStateSuccess value)? success,
    TResult? Function(_LoadingStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadingStateIdle value)? idle,
    TResult Function(_LoadingStateLoading value)? loading,
    TResult Function(_LoadingStateSuccess value)? success,
    TResult Function(_LoadingStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadingStateCopyWith<$Res> {
  factory $LoadingStateCopyWith(
          LoadingState value, $Res Function(LoadingState) then) =
      _$LoadingStateCopyWithImpl<$Res, LoadingState>;
}

/// @nodoc
class _$LoadingStateCopyWithImpl<$Res, $Val extends LoadingState>
    implements $LoadingStateCopyWith<$Res> {
  _$LoadingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadingStateIdleImplCopyWith<$Res> {
  factory _$$LoadingStateIdleImplCopyWith(_$LoadingStateIdleImpl value,
          $Res Function(_$LoadingStateIdleImpl) then) =
      __$$LoadingStateIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingStateIdleImplCopyWithImpl<$Res>
    extends _$LoadingStateCopyWithImpl<$Res, _$LoadingStateIdleImpl>
    implements _$$LoadingStateIdleImplCopyWith<$Res> {
  __$$LoadingStateIdleImplCopyWithImpl(_$LoadingStateIdleImpl _value,
      $Res Function(_$LoadingStateIdleImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingStateIdleImpl implements _LoadingStateIdle {
  const _$LoadingStateIdleImpl();

  @override
  String toString() {
    return 'LoadingState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingStateIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(Object? obj) success,
    required TResult Function(Object? error) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(Object? obj)? success,
    TResult? Function(Object? error)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(Object? obj)? success,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadingStateIdle value) idle,
    required TResult Function(_LoadingStateLoading value) loading,
    required TResult Function(_LoadingStateSuccess value) success,
    required TResult Function(_LoadingStateError value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadingStateIdle value)? idle,
    TResult? Function(_LoadingStateLoading value)? loading,
    TResult? Function(_LoadingStateSuccess value)? success,
    TResult? Function(_LoadingStateError value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadingStateIdle value)? idle,
    TResult Function(_LoadingStateLoading value)? loading,
    TResult Function(_LoadingStateSuccess value)? success,
    TResult Function(_LoadingStateError value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _LoadingStateIdle implements LoadingState {
  const factory _LoadingStateIdle() = _$LoadingStateIdleImpl;
}

/// @nodoc
abstract class _$$LoadingStateLoadingImplCopyWith<$Res> {
  factory _$$LoadingStateLoadingImplCopyWith(_$LoadingStateLoadingImpl value,
          $Res Function(_$LoadingStateLoadingImpl) then) =
      __$$LoadingStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingStateLoadingImplCopyWithImpl<$Res>
    extends _$LoadingStateCopyWithImpl<$Res, _$LoadingStateLoadingImpl>
    implements _$$LoadingStateLoadingImplCopyWith<$Res> {
  __$$LoadingStateLoadingImplCopyWithImpl(_$LoadingStateLoadingImpl _value,
      $Res Function(_$LoadingStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingStateLoadingImpl implements _LoadingStateLoading {
  const _$LoadingStateLoadingImpl();

  @override
  String toString() {
    return 'LoadingState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(Object? obj) success,
    required TResult Function(Object? error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(Object? obj)? success,
    TResult? Function(Object? error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(Object? obj)? success,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadingStateIdle value) idle,
    required TResult Function(_LoadingStateLoading value) loading,
    required TResult Function(_LoadingStateSuccess value) success,
    required TResult Function(_LoadingStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadingStateIdle value)? idle,
    TResult? Function(_LoadingStateLoading value)? loading,
    TResult? Function(_LoadingStateSuccess value)? success,
    TResult? Function(_LoadingStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadingStateIdle value)? idle,
    TResult Function(_LoadingStateLoading value)? loading,
    TResult Function(_LoadingStateSuccess value)? success,
    TResult Function(_LoadingStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _LoadingStateLoading implements LoadingState {
  const factory _LoadingStateLoading() = _$LoadingStateLoadingImpl;
}

/// @nodoc
abstract class _$$LoadingStateSuccessImplCopyWith<$Res> {
  factory _$$LoadingStateSuccessImplCopyWith(_$LoadingStateSuccessImpl value,
          $Res Function(_$LoadingStateSuccessImpl) then) =
      __$$LoadingStateSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object? obj});
}

/// @nodoc
class __$$LoadingStateSuccessImplCopyWithImpl<$Res>
    extends _$LoadingStateCopyWithImpl<$Res, _$LoadingStateSuccessImpl>
    implements _$$LoadingStateSuccessImplCopyWith<$Res> {
  __$$LoadingStateSuccessImplCopyWithImpl(_$LoadingStateSuccessImpl _value,
      $Res Function(_$LoadingStateSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? obj = freezed,
  }) {
    return _then(_$LoadingStateSuccessImpl(
      freezed == obj ? _value.obj : obj,
    ));
  }
}

/// @nodoc

class _$LoadingStateSuccessImpl implements _LoadingStateSuccess {
  const _$LoadingStateSuccessImpl([this.obj]);

  @override
  final Object? obj;

  @override
  String toString() {
    return 'LoadingState.success(obj: $obj)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingStateSuccessImpl &&
            const DeepCollectionEquality().equals(other.obj, obj));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(obj));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingStateSuccessImplCopyWith<_$LoadingStateSuccessImpl> get copyWith =>
      __$$LoadingStateSuccessImplCopyWithImpl<_$LoadingStateSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(Object? obj) success,
    required TResult Function(Object? error) error,
  }) {
    return success(obj);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(Object? obj)? success,
    TResult? Function(Object? error)? error,
  }) {
    return success?.call(obj);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(Object? obj)? success,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(obj);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadingStateIdle value) idle,
    required TResult Function(_LoadingStateLoading value) loading,
    required TResult Function(_LoadingStateSuccess value) success,
    required TResult Function(_LoadingStateError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadingStateIdle value)? idle,
    TResult? Function(_LoadingStateLoading value)? loading,
    TResult? Function(_LoadingStateSuccess value)? success,
    TResult? Function(_LoadingStateError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadingStateIdle value)? idle,
    TResult Function(_LoadingStateLoading value)? loading,
    TResult Function(_LoadingStateSuccess value)? success,
    TResult Function(_LoadingStateError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _LoadingStateSuccess implements LoadingState {
  const factory _LoadingStateSuccess([final Object? obj]) =
      _$LoadingStateSuccessImpl;

  Object? get obj;
  @JsonKey(ignore: true)
  _$$LoadingStateSuccessImplCopyWith<_$LoadingStateSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingStateErrorImplCopyWith<$Res> {
  factory _$$LoadingStateErrorImplCopyWith(_$LoadingStateErrorImpl value,
          $Res Function(_$LoadingStateErrorImpl) then) =
      __$$LoadingStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object? error});
}

/// @nodoc
class __$$LoadingStateErrorImplCopyWithImpl<$Res>
    extends _$LoadingStateCopyWithImpl<$Res, _$LoadingStateErrorImpl>
    implements _$$LoadingStateErrorImplCopyWith<$Res> {
  __$$LoadingStateErrorImplCopyWithImpl(_$LoadingStateErrorImpl _value,
      $Res Function(_$LoadingStateErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$LoadingStateErrorImpl(
      freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$LoadingStateErrorImpl implements _LoadingStateError {
  const _$LoadingStateErrorImpl(this.error);

  @override
  final Object? error;

  @override
  String toString() {
    return 'LoadingState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingStateErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingStateErrorImplCopyWith<_$LoadingStateErrorImpl> get copyWith =>
      __$$LoadingStateErrorImplCopyWithImpl<_$LoadingStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(Object? obj) success,
    required TResult Function(Object? error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(Object? obj)? success,
    TResult? Function(Object? error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(Object? obj)? success,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadingStateIdle value) idle,
    required TResult Function(_LoadingStateLoading value) loading,
    required TResult Function(_LoadingStateSuccess value) success,
    required TResult Function(_LoadingStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadingStateIdle value)? idle,
    TResult? Function(_LoadingStateLoading value)? loading,
    TResult? Function(_LoadingStateSuccess value)? success,
    TResult? Function(_LoadingStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadingStateIdle value)? idle,
    TResult Function(_LoadingStateLoading value)? loading,
    TResult Function(_LoadingStateSuccess value)? success,
    TResult Function(_LoadingStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _LoadingStateError implements LoadingState {
  const factory _LoadingStateError(final Object? error) =
      _$LoadingStateErrorImpl;

  Object? get error;
  @JsonKey(ignore: true)
  _$$LoadingStateErrorImplCopyWith<_$LoadingStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
