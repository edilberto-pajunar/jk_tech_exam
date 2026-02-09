import 'package:jk_tech_exam/features/dashboard/community/data/model/post.dart';
import 'package:jk_tech_exam/features/dashboard/community/data/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community.g.dart';

@JsonSerializable(explicitToJson: true)
class Community {
  final String id;
  final Post post;
  final AppUser user;

  Community({required this.id, required this.post, required this.user});

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityToJson(this);

  static List<Community> getCommunities() => [
    Community(
      id: '1',
      post: Post.getPosts().first,
      user: AppUser.getUsers().first,
    ),
  ];
}
