import 'package:jk_tech_exam/shared/image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_service.g.dart';

@JsonSerializable(explicitToJson: true)
class PublicService {
  final String id;
  final String imageUrl;
  final String title;
  final DateTime createdAt;
  final String location;

  PublicService({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.createdAt,
    required this.location,
  });

  factory PublicService.fromJson(Map<String, dynamic> json) =>
      _$PublicServiceFromJson(json);

  Map<String, dynamic> toJson() => _$PublicServiceToJson(this);

  static List<PublicService> getPublicServices() => [
    PublicService(
      id: '1',
      imageUrl: AppImage.publicService1,
      title: 'Stay Safe: Classes Canceled in Cavite Due to Heavy Rainfall',
      createdAt: DateTime.now(),
      location: 'Bacoor, Cavite',
    ),
  ];
}
