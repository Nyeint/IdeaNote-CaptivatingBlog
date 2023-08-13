// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Blog _$BlogFromJson(Map<String, dynamic> json) {
  return _Blog.fromJson(json);
}

/// @nodoc
mixin _$Blog {
  String get objectId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;
  List<User>? get voter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BlogCopyWith<Blog> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlogCopyWith<$Res> {
  factory $BlogCopyWith(Blog value, $Res Function(Blog) then) =
      _$BlogCopyWithImpl<$Res, Blog>;
  @useResult
  $Res call(
      {String objectId,
      DateTime createdAt,
      DateTime updatedAt,
      String title,
      String? content,
      User user,
      List<User>? voter});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$BlogCopyWithImpl<$Res, $Val extends Blog>
    implements $BlogCopyWith<$Res> {
  _$BlogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? title = null,
    Object? content = freezed,
    Object? user = null,
    Object? voter = freezed,
  }) {
    return _then(_value.copyWith(
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      voter: freezed == voter
          ? _value.voter
          : voter // ignore: cast_nullable_to_non_nullable
              as List<User>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BlogCopyWith<$Res> implements $BlogCopyWith<$Res> {
  factory _$$_BlogCopyWith(_$_Blog value, $Res Function(_$_Blog) then) =
      __$$_BlogCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String objectId,
      DateTime createdAt,
      DateTime updatedAt,
      String title,
      String? content,
      User user,
      List<User>? voter});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$_BlogCopyWithImpl<$Res> extends _$BlogCopyWithImpl<$Res, _$_Blog>
    implements _$$_BlogCopyWith<$Res> {
  __$$_BlogCopyWithImpl(_$_Blog _value, $Res Function(_$_Blog) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? title = null,
    Object? content = freezed,
    Object? user = null,
    Object? voter = freezed,
  }) {
    return _then(_$_Blog(
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      voter: freezed == voter
          ? _value._voter
          : voter // ignore: cast_nullable_to_non_nullable
              as List<User>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Blog implements _Blog {
  _$_Blog(
      {required this.objectId,
      required this.createdAt,
      required this.updatedAt,
      required this.title,
      required this.content,
      required this.user,
      required final List<User>? voter})
      : _voter = voter;

  factory _$_Blog.fromJson(Map<String, dynamic> json) => _$$_BlogFromJson(json);

  @override
  final String objectId;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String title;
  @override
  final String? content;
  @override
  final User user;
  final List<User>? _voter;
  @override
  List<User>? get voter {
    final value = _voter;
    if (value == null) return null;
    if (_voter is EqualUnmodifiableListView) return _voter;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Blog(objectId: $objectId, createdAt: $createdAt, updatedAt: $updatedAt, title: $title, content: $content, user: $user, voter: $voter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Blog &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality().equals(other._voter, _voter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, objectId, createdAt, updatedAt,
      title, content, user, const DeepCollectionEquality().hash(_voter));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BlogCopyWith<_$_Blog> get copyWith =>
      __$$_BlogCopyWithImpl<_$_Blog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BlogToJson(
      this,
    );
  }
}

abstract class _Blog implements Blog {
  factory _Blog(
      {required final String objectId,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final String title,
      required final String? content,
      required final User user,
      required final List<User>? voter}) = _$_Blog;

  factory _Blog.fromJson(Map<String, dynamic> json) = _$_Blog.fromJson;

  @override
  String get objectId;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String get title;
  @override
  String? get content;
  @override
  User get user;
  @override
  List<User>? get voter;
  @override
  @JsonKey(ignore: true)
  _$$_BlogCopyWith<_$_Blog> get copyWith => throw _privateConstructorUsedError;
}
