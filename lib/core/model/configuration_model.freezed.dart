// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'configuration_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConfigurationModel _$ConfigurationModelFromJson(Map<String, dynamic> json) {
  return _ConfigurationModel.fromJson(json);
}

/// @nodoc
mixin _$ConfigurationModel {
  Images? get images => throw _privateConstructorUsedError;
  @JsonKey(name: 'change_keys')
  List<String>? get changeKeys => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigurationModelCopyWith<ConfigurationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigurationModelCopyWith<$Res> {
  factory $ConfigurationModelCopyWith(
          ConfigurationModel value, $Res Function(ConfigurationModel) then) =
      _$ConfigurationModelCopyWithImpl<$Res, ConfigurationModel>;
  @useResult
  $Res call(
      {Images? images, @JsonKey(name: 'change_keys') List<String>? changeKeys});

  $ImagesCopyWith<$Res>? get images;
}

/// @nodoc
class _$ConfigurationModelCopyWithImpl<$Res, $Val extends ConfigurationModel>
    implements $ConfigurationModelCopyWith<$Res> {
  _$ConfigurationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? images = freezed,
    Object? changeKeys = freezed,
  }) {
    return _then(_value.copyWith(
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as Images?,
      changeKeys: freezed == changeKeys
          ? _value.changeKeys
          : changeKeys // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ImagesCopyWith<$Res>? get images {
    if (_value.images == null) {
      return null;
    }

    return $ImagesCopyWith<$Res>(_value.images!, (value) {
      return _then(_value.copyWith(images: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConfigurationModelImplCopyWith<$Res>
    implements $ConfigurationModelCopyWith<$Res> {
  factory _$$ConfigurationModelImplCopyWith(_$ConfigurationModelImpl value,
          $Res Function(_$ConfigurationModelImpl) then) =
      __$$ConfigurationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Images? images, @JsonKey(name: 'change_keys') List<String>? changeKeys});

  @override
  $ImagesCopyWith<$Res>? get images;
}

/// @nodoc
class __$$ConfigurationModelImplCopyWithImpl<$Res>
    extends _$ConfigurationModelCopyWithImpl<$Res, _$ConfigurationModelImpl>
    implements _$$ConfigurationModelImplCopyWith<$Res> {
  __$$ConfigurationModelImplCopyWithImpl(_$ConfigurationModelImpl _value,
      $Res Function(_$ConfigurationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? images = freezed,
    Object? changeKeys = freezed,
  }) {
    return _then(_$ConfigurationModelImpl(
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as Images?,
      changeKeys: freezed == changeKeys
          ? _value._changeKeys
          : changeKeys // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigurationModelImpl implements _ConfigurationModel {
  const _$ConfigurationModelImpl(
      {this.images,
      @JsonKey(name: 'change_keys') final List<String>? changeKeys})
      : _changeKeys = changeKeys;

  factory _$ConfigurationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigurationModelImplFromJson(json);

  @override
  final Images? images;
  final List<String>? _changeKeys;
  @override
  @JsonKey(name: 'change_keys')
  List<String>? get changeKeys {
    final value = _changeKeys;
    if (value == null) return null;
    if (_changeKeys is EqualUnmodifiableListView) return _changeKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ConfigurationModel(images: $images, changeKeys: $changeKeys)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigurationModelImpl &&
            (identical(other.images, images) || other.images == images) &&
            const DeepCollectionEquality()
                .equals(other._changeKeys, _changeKeys));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, images, const DeepCollectionEquality().hash(_changeKeys));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigurationModelImplCopyWith<_$ConfigurationModelImpl> get copyWith =>
      __$$ConfigurationModelImplCopyWithImpl<_$ConfigurationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigurationModelImplToJson(
      this,
    );
  }
}

abstract class _ConfigurationModel implements ConfigurationModel {
  const factory _ConfigurationModel(
          {final Images? images,
          @JsonKey(name: 'change_keys') final List<String>? changeKeys}) =
      _$ConfigurationModelImpl;

  factory _ConfigurationModel.fromJson(Map<String, dynamic> json) =
      _$ConfigurationModelImpl.fromJson;

  @override
  Images? get images;
  @override
  @JsonKey(name: 'change_keys')
  List<String>? get changeKeys;
  @override
  @JsonKey(ignore: true)
  _$$ConfigurationModelImplCopyWith<_$ConfigurationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Images _$ImagesFromJson(Map<String, dynamic> json) {
  return _Images.fromJson(json);
}

/// @nodoc
mixin _$Images {
  @JsonKey(name: 'base_url')
  String? get baseUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'secure_base_url')
  String? get secureBaseUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'backdrop_sizes')
  List<String>? get backdropSizes => throw _privateConstructorUsedError;
  @JsonKey(name: 'logo_sizes')
  List<String>? get logoSizes => throw _privateConstructorUsedError;
  @JsonKey(name: 'poster_sizes')
  List<String>? get posterSizes => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_sizes')
  List<String>? get profileSizes => throw _privateConstructorUsedError;
  @JsonKey(name: 'still_sizes')
  List<String>? get stillSizes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImagesCopyWith<Images> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImagesCopyWith<$Res> {
  factory $ImagesCopyWith(Images value, $Res Function(Images) then) =
      _$ImagesCopyWithImpl<$Res, Images>;
  @useResult
  $Res call(
      {@JsonKey(name: 'base_url') String? baseUrl,
      @JsonKey(name: 'secure_base_url') String? secureBaseUrl,
      @JsonKey(name: 'backdrop_sizes') List<String>? backdropSizes,
      @JsonKey(name: 'logo_sizes') List<String>? logoSizes,
      @JsonKey(name: 'poster_sizes') List<String>? posterSizes,
      @JsonKey(name: 'profile_sizes') List<String>? profileSizes,
      @JsonKey(name: 'still_sizes') List<String>? stillSizes});
}

/// @nodoc
class _$ImagesCopyWithImpl<$Res, $Val extends Images>
    implements $ImagesCopyWith<$Res> {
  _$ImagesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseUrl = freezed,
    Object? secureBaseUrl = freezed,
    Object? backdropSizes = freezed,
    Object? logoSizes = freezed,
    Object? posterSizes = freezed,
    Object? profileSizes = freezed,
    Object? stillSizes = freezed,
  }) {
    return _then(_value.copyWith(
      baseUrl: freezed == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      secureBaseUrl: freezed == secureBaseUrl
          ? _value.secureBaseUrl
          : secureBaseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropSizes: freezed == backdropSizes
          ? _value.backdropSizes
          : backdropSizes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      logoSizes: freezed == logoSizes
          ? _value.logoSizes
          : logoSizes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      posterSizes: freezed == posterSizes
          ? _value.posterSizes
          : posterSizes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      profileSizes: freezed == profileSizes
          ? _value.profileSizes
          : profileSizes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      stillSizes: freezed == stillSizes
          ? _value.stillSizes
          : stillSizes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImagesImplCopyWith<$Res> implements $ImagesCopyWith<$Res> {
  factory _$$ImagesImplCopyWith(
          _$ImagesImpl value, $Res Function(_$ImagesImpl) then) =
      __$$ImagesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'base_url') String? baseUrl,
      @JsonKey(name: 'secure_base_url') String? secureBaseUrl,
      @JsonKey(name: 'backdrop_sizes') List<String>? backdropSizes,
      @JsonKey(name: 'logo_sizes') List<String>? logoSizes,
      @JsonKey(name: 'poster_sizes') List<String>? posterSizes,
      @JsonKey(name: 'profile_sizes') List<String>? profileSizes,
      @JsonKey(name: 'still_sizes') List<String>? stillSizes});
}

/// @nodoc
class __$$ImagesImplCopyWithImpl<$Res>
    extends _$ImagesCopyWithImpl<$Res, _$ImagesImpl>
    implements _$$ImagesImplCopyWith<$Res> {
  __$$ImagesImplCopyWithImpl(
      _$ImagesImpl _value, $Res Function(_$ImagesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseUrl = freezed,
    Object? secureBaseUrl = freezed,
    Object? backdropSizes = freezed,
    Object? logoSizes = freezed,
    Object? posterSizes = freezed,
    Object? profileSizes = freezed,
    Object? stillSizes = freezed,
  }) {
    return _then(_$ImagesImpl(
      baseUrl: freezed == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      secureBaseUrl: freezed == secureBaseUrl
          ? _value.secureBaseUrl
          : secureBaseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropSizes: freezed == backdropSizes
          ? _value._backdropSizes
          : backdropSizes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      logoSizes: freezed == logoSizes
          ? _value._logoSizes
          : logoSizes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      posterSizes: freezed == posterSizes
          ? _value._posterSizes
          : posterSizes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      profileSizes: freezed == profileSizes
          ? _value._profileSizes
          : profileSizes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      stillSizes: freezed == stillSizes
          ? _value._stillSizes
          : stillSizes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImagesImpl implements _Images {
  const _$ImagesImpl(
      {@JsonKey(name: 'base_url') this.baseUrl,
      @JsonKey(name: 'secure_base_url') this.secureBaseUrl,
      @JsonKey(name: 'backdrop_sizes') final List<String>? backdropSizes,
      @JsonKey(name: 'logo_sizes') final List<String>? logoSizes,
      @JsonKey(name: 'poster_sizes') final List<String>? posterSizes,
      @JsonKey(name: 'profile_sizes') final List<String>? profileSizes,
      @JsonKey(name: 'still_sizes') final List<String>? stillSizes})
      : _backdropSizes = backdropSizes,
        _logoSizes = logoSizes,
        _posterSizes = posterSizes,
        _profileSizes = profileSizes,
        _stillSizes = stillSizes;

  factory _$ImagesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImagesImplFromJson(json);

  @override
  @JsonKey(name: 'base_url')
  final String? baseUrl;
  @override
  @JsonKey(name: 'secure_base_url')
  final String? secureBaseUrl;
  final List<String>? _backdropSizes;
  @override
  @JsonKey(name: 'backdrop_sizes')
  List<String>? get backdropSizes {
    final value = _backdropSizes;
    if (value == null) return null;
    if (_backdropSizes is EqualUnmodifiableListView) return _backdropSizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _logoSizes;
  @override
  @JsonKey(name: 'logo_sizes')
  List<String>? get logoSizes {
    final value = _logoSizes;
    if (value == null) return null;
    if (_logoSizes is EqualUnmodifiableListView) return _logoSizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _posterSizes;
  @override
  @JsonKey(name: 'poster_sizes')
  List<String>? get posterSizes {
    final value = _posterSizes;
    if (value == null) return null;
    if (_posterSizes is EqualUnmodifiableListView) return _posterSizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _profileSizes;
  @override
  @JsonKey(name: 'profile_sizes')
  List<String>? get profileSizes {
    final value = _profileSizes;
    if (value == null) return null;
    if (_profileSizes is EqualUnmodifiableListView) return _profileSizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _stillSizes;
  @override
  @JsonKey(name: 'still_sizes')
  List<String>? get stillSizes {
    final value = _stillSizes;
    if (value == null) return null;
    if (_stillSizes is EqualUnmodifiableListView) return _stillSizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Images(baseUrl: $baseUrl, secureBaseUrl: $secureBaseUrl, backdropSizes: $backdropSizes, logoSizes: $logoSizes, posterSizes: $posterSizes, profileSizes: $profileSizes, stillSizes: $stillSizes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImagesImpl &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            (identical(other.secureBaseUrl, secureBaseUrl) ||
                other.secureBaseUrl == secureBaseUrl) &&
            const DeepCollectionEquality()
                .equals(other._backdropSizes, _backdropSizes) &&
            const DeepCollectionEquality()
                .equals(other._logoSizes, _logoSizes) &&
            const DeepCollectionEquality()
                .equals(other._posterSizes, _posterSizes) &&
            const DeepCollectionEquality()
                .equals(other._profileSizes, _profileSizes) &&
            const DeepCollectionEquality()
                .equals(other._stillSizes, _stillSizes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      baseUrl,
      secureBaseUrl,
      const DeepCollectionEquality().hash(_backdropSizes),
      const DeepCollectionEquality().hash(_logoSizes),
      const DeepCollectionEquality().hash(_posterSizes),
      const DeepCollectionEquality().hash(_profileSizes),
      const DeepCollectionEquality().hash(_stillSizes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImagesImplCopyWith<_$ImagesImpl> get copyWith =>
      __$$ImagesImplCopyWithImpl<_$ImagesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImagesImplToJson(
      this,
    );
  }
}

abstract class _Images implements Images {
  const factory _Images(
          {@JsonKey(name: 'base_url') final String? baseUrl,
          @JsonKey(name: 'secure_base_url') final String? secureBaseUrl,
          @JsonKey(name: 'backdrop_sizes') final List<String>? backdropSizes,
          @JsonKey(name: 'logo_sizes') final List<String>? logoSizes,
          @JsonKey(name: 'poster_sizes') final List<String>? posterSizes,
          @JsonKey(name: 'profile_sizes') final List<String>? profileSizes,
          @JsonKey(name: 'still_sizes') final List<String>? stillSizes}) =
      _$ImagesImpl;

  factory _Images.fromJson(Map<String, dynamic> json) = _$ImagesImpl.fromJson;

  @override
  @JsonKey(name: 'base_url')
  String? get baseUrl;
  @override
  @JsonKey(name: 'secure_base_url')
  String? get secureBaseUrl;
  @override
  @JsonKey(name: 'backdrop_sizes')
  List<String>? get backdropSizes;
  @override
  @JsonKey(name: 'logo_sizes')
  List<String>? get logoSizes;
  @override
  @JsonKey(name: 'poster_sizes')
  List<String>? get posterSizes;
  @override
  @JsonKey(name: 'profile_sizes')
  List<String>? get profileSizes;
  @override
  @JsonKey(name: 'still_sizes')
  List<String>? get stillSizes;
  @override
  @JsonKey(ignore: true)
  _$$ImagesImplCopyWith<_$ImagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
