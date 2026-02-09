import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jk_tech_exam/extensions/date_extensions.dart';
import 'package:jk_tech_exam/features/dashboard/videos/data/model/news.dart';
import 'package:jk_tech_exam/shared/colors.dart';
import 'package:jk_tech_exam/shared/image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsCarouselCard extends StatelessWidget {
  const NewsCarouselCard({
    super.key,
    required this.allNews,
    required this.onPageChanged,
    required this.activeIndex,
  });

  final List<News> allNews;
  final Function(int, CarouselPageChangedReason) onPageChanged;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        CarouselSlider(
          items: allNews.map((news) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: news.isBreakingNews
                    ? AppColor.accentColor
                    : AppColor.whiteColor,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  news.isBreakingNews
                      ? Badge(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          backgroundColor: AppColor.whiteColor,
                          alignment: Alignment.topLeft,
                          offset: const Offset(12, 12),
                          label: Row(
                            children: [
                              SvgPicture.asset(AppImage.breaking),
                              const SizedBox(width: 4.0),
                              Text(
                                "Breaking News",
                                style: theme.textTheme.bodySmall!.copyWith(),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              news.imageUrl,
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            news.imageUrl,
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                        ),
                  const SizedBox(height: 10.0),
                  Text(
                    news.isBreakingNews ? "🚨 ${news.title}" : news.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${news.reporter} · ${news.createdAt.toRelativeTime()}",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: false,
            viewportFraction: 1,
            height: 320,
            initialPage: 0,
            onPageChanged: onPageChanged,
          ),
        ),
        const SizedBox(height: 12.0),
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: allNews.length,
          effect: const SlideEffect(
            radius: 20.0,
            dotWidth: 10.0,
            dotHeight: 10.0,
            activeDotColor: Color(0xFF94A3B8),
            dotColor: Color(0xFFE2E8F0),
          ),
        ),
      ],
    );
  }
}
