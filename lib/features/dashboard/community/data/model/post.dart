import 'package:jk_tech_exam/shared/image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class Post {
  final String id;
  final String content;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;
  final int bookmarksCount;
  final bool? isHeadline;
  final String? imageUrl;

  Post({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.likesCount,
    required this.commentsCount,
    required this.bookmarksCount,
    this.isHeadline = false,
    this.imageUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  static List<Post> getPosts() => [
    Post(
      id: '1',
      content:
          'Our small business just reached a huge milestone: 5,000 happy customers!',
      createdAt: DateTime.now(),
      likesCount: 7904,
      commentsCount: 7904,
      bookmarksCount: 7904,
      isHeadline: true,
      imageUrl: AppImage.community1,
    ),
  ];
}
