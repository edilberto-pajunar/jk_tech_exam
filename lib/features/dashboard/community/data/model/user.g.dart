// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  imageUrl: json['imageUrl'] as String,
  email: json['email'] as String,
  status:
      $enumDecodeNullable(_$AppUserStatusEnumMap, json['status']) ??
      AppUserStatus.active,
);

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'imageUrl': instance.imageUrl,
  'email': instance.email,
  'status': _$AppUserStatusEnumMap[instance.status]!,
};

const _$AppUserStatusEnumMap = {
  AppUserStatus.active: 'active',
  AppUserStatus.inactive: 'inactive',
};
