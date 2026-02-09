// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
  id: json['id'] as String,
  content: json['content'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  likesCount: (json['likesCount'] as num).toInt(),
  commentsCount: (json['commentsCount'] as num).toInt(),
  bookmarksCount: (json['bookmarksCount'] as num).toInt(),
  isHeadline: json['isHeadline'] as bool? ?? false,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'createdAt': instance.createdAt.toIso8601String(),
  'likesCount': instance.likesCount,
  'commentsCount': instance.commentsCount,
  'bookmarksCount': instance.bookmarksCount,
  'isHeadline': instance.isHeadline,
  'imageUrl': instance.imageUrl,
};
