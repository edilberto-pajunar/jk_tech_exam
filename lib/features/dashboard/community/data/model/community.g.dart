// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Community _$CommunityFromJson(Map<String, dynamic> json) => Community(
  id: json['id'] as String,
  post: Post.fromJson(json['post'] as Map<String, dynamic>),
  user: AppUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CommunityToJson(Community instance) => <String, dynamic>{
  'id': instance.id,
  'post': instance.post.toJson(),
  'user': instance.user.toJson(),
};
