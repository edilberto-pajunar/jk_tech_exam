import 'package:jk_tech_exam/shared/image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable(explicitToJson: true)
class News {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final bool isFeatured;
  final bool isBreakingNews;
  final String reporter;
  final String imageUrl;
  final bool? isHeadline;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.isFeatured,
    required this.isBreakingNews,
    required this.reporter,
    required this.imageUrl,
    this.isHeadline = false,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);

  static List<News> getNews() => [
    News(
      id: '1',
      title: 'Breaking News: Massive Fire',
      description: 'Massive Fire',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      isFeatured: true,
      isBreakingNews: true,
      reporter: 'Acme News',
      imageUrl: AppImage.news1,
    ),
    News(
      id: '2',
      title: 'Kindness Project Sparks Global',
      description: 'Description 2',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      isFeatured: true,
      isBreakingNews: false,
      reporter: 'Acme News',
      imageUrl: AppImage.news2,
    ),
    News(
      id: '3',
      title: 'Relief Efforts Stall as Community',
      description: 'Description 3',
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      isFeatured: true,
      isBreakingNews: false,
      reporter: 'GMA',
      imageUrl: AppImage.news3,
    ),
    News(
      id: '4',
      title: 'Voter Turnout Stagnates Despite Low Turnout',
      description: 'Description 4',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      isFeatured: true,
      isBreakingNews: false,
      reporter: 'Manila Standard',
      imageUrl: AppImage.news4,
    ),
    News(
      id: '4',
      title:
          'News Celebrating Prosperity: Chinese New Year 2025 Kicks Off with Joy and Tradition',
      description: 'Description 4',
      createdAt: DateTime.now(),
      isFeatured: true,
      isBreakingNews: false,
      reporter: 'newspost',
      imageUrl: AppImage.news5,
      isHeadline: true,
    ),
  ];
}
