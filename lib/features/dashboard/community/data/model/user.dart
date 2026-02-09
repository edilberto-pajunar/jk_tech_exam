import 'package:jk_tech_exam/shared/image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class AppUser {
  final String id;
  final String fullName;
  final String imageUrl;

  AppUser({required this.id, required this.fullName, required this.imageUrl});

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  static List<AppUser> getUsers() => [
    AppUser(id: '1', fullName: 'Alfonso George', imageUrl: AppImage.user1),
  ];
}
