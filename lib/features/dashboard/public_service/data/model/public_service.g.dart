// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicService _$PublicServiceFromJson(Map<String, dynamic> json) =>
    PublicService(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      location: json['location'] as String,
    );

Map<String, dynamic> _$PublicServiceToJson(PublicService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'createdAt': instance.createdAt.toIso8601String(),
      'location': instance.location,
    };
