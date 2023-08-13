// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      objectId: json['objectId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      username: json['username'] as String,
      email: json['email'] as String?,
      accountName: json['accountName'] as String,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'objectId': instance.objectId,
      'createdAt': instance.createdAt.toIso8601String(),
      'username': instance.username,
      'email': instance.email,
      'accountName': instance.accountName,
    };
