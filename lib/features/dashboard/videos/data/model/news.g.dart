// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  isFeatured: json['isFeatured'] as bool,
  isBreakingNews: json['isBreakingNews'] as bool,
  reporter: json['reporter'] as String,
  imageUrl: json['imageUrl'] as String,
  isHeadline: json['isHeadline'] as bool? ?? false,
);

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'createdAt': instance.createdAt.toIso8601String(),
  'isFeatured': instance.isFeatured,
  'isBreakingNews': instance.isBreakingNews,
  'reporter': instance.reporter,
  'imageUrl': instance.imageUrl,
  'isHeadline': instance.isHeadline,
};
