import 'package:equatable/equatable.dart';
import 'package:jk_tech_exam/shared/image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

enum AppUserStatus {
  @JsonValue('active')
  active,
  @JsonValue('inactive')
  inactive,
}

@JsonSerializable(explicitToJson: true)
class AppUser extends Equatable {
  final String id;
  final String fullName;
  final String imageUrl;
  final String email;
  final AppUserStatus status;
  final String? token;

  const AppUser({
    required this.id,
    required this.fullName,
    required this.imageUrl,
    required this.email,
    this.status = AppUserStatus.active,
    this.token,
  });

  AppUser copyWith({
    String? id,
    String? fullName,
    String? imageUrl,
    String? email,
    AppUserStatus? status,
    String? token,
  }) => AppUser(
    id: id ?? this.id,
    fullName: fullName ?? this.fullName,
    imageUrl: imageUrl ?? this.imageUrl,
    email: email ?? this.email,
    status: status ?? this.status,
    token: token ?? this.token,
  );

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  static List<AppUser> getUsers() => [
    const AppUser(
      id: '1',
      fullName: 'Alfonso George',
      imageUrl: AppImage.user1,
      email: 'alfonso@gmail.com',
      status: AppUserStatus.active,
    ),
    const AppUser(
      id: '2',
      fullName: 'John Doe',
      imageUrl: AppImage.user1,
      email: 'test@gmail.com',
      status: AppUserStatus.inactive,
    ),
    const AppUser(
      id: '3',
      fullName: 'Eve Holt',
      imageUrl: AppImage.user1,
      email: 'eve.holt@reqres.in',
      status: AppUserStatus.inactive,
    ),
  ];

  @override
  List<Object?> get props => [id, fullName, imageUrl, email, status, token];
}
