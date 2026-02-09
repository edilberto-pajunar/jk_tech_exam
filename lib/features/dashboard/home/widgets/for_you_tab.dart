import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jk_tech_exam/extensions/date_extensions.dart';
import 'package:jk_tech_exam/features/dashboard/community/data/model/community.dart';
import 'package:jk_tech_exam/features/dashboard/community/data/model/post.dart';
import 'package:jk_tech_exam/features/dashboard/home/widgets/for_you/news_carousel_card.dart';
import 'package:jk_tech_exam/features/dashboard/public_service/data/model/public_service.dart';
import 'package:jk_tech_exam/features/dashboard/videos/data/model/news.dart';
import 'package:jk_tech_exam/shared/colors.dart';
import 'package:jk_tech_exam/shared/image.dart';
import 'package:jk_tech_exam/widgets/buttons/primary_button.dart';
import 'package:jk_tech_exam/widgets/cards/primary_card.dart';
import 'package:see_more/see_more_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ForYouTab extends StatefulWidget {
  const ForYouTab({super.key});

  @override
  State<ForYouTab> createState() => _ForYouTabState();
}

class _ForYouTabState extends State<ForYouTab> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final allNews = News.getNews();
    final headlineNews = allNews.firstWhere((news) => news.isHeadline == true);
    final headlinePost = Community.getCommunities().firstWhere(
      (community) => community.post.isHeadline == true,
    );
    final publicService = PublicService.getPublicServices().first;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            NewsCarouselCard(
              allNews: allNews,
              onPageChanged: (index, reason) {
                setState(() => _activeIndex = index);
              },
              activeIndex: _activeIndex,
            ),
            const SizedBox(height: 24.0),
            PrimaryCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppImage.news),
                      const SizedBox(width: 4.0),
                      const Text("News"),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch, // 👈 key
                      children: [
                        Expanded(
                          child: Text(
                            headlineNews.title,
                            style: theme.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              headlineNews.imageUrl,
                              fit: BoxFit.cover, // 👈 fills the height
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: headlineNews.reporter,
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: AppColor.primaryColor,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    " · ${headlineNews.createdAt.toRelativeTime()}",
                                style: theme.textTheme.bodySmall!.copyWith(
                                  color: AppColor.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_horiz,
                          color: AppColor.greyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            PrimaryCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppImage.community),
                      const SizedBox(width: 4.0),
                      const Text("Community"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Row(
                          children: [
                            Image.asset(
                              headlinePost.user.imageUrl,
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  headlinePost.user.fullName,
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  headlinePost.post.createdAt.toRelativeTime(),
                                  style: theme.textTheme.bodySmall!.copyWith(
                                    color: AppColor.greyColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      const Flexible(child: PrimaryButton(text: "+ Follow")),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  SeeMoreWidget(
                    headlinePost.post.content,
                    textStyle: theme.textTheme.bodyMedium!.copyWith(),
                    trimLength: 40,
                    seeMoreStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: AppColor.greyColor,
                    ),
                    seeLessStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: AppColor.greyColor,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Image.asset(headlinePost.post.imageUrl!, fit: BoxFit.cover),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        label: Text("${headlinePost.post.likesCount}"),
                        icon: SvgPicture.asset(AppImage.heart),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        label: Text("${headlinePost.post.commentsCount}"),
                        icon: SvgPicture.asset(AppImage.comment),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        label: Text("${headlinePost.post.likesCount}"),
                        icon: SvgPicture.asset(AppImage.bookmark),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            PrimaryCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppImage.news),
                      const SizedBox(width: 4.0),
                      const Text("News"),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    headlineNews.title,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(AppImage.news6, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: headlineNews.reporter,
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: AppColor.primaryColor,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    " · ${headlineNews.createdAt.toRelativeTime()}",
                                style: theme.textTheme.bodySmall!.copyWith(
                                  color: AppColor.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_horiz,
                          color: AppColor.greyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            PrimaryCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppImage.public),
                      const SizedBox(width: 4.0),
                      const Text("Public Service"),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    publicService.title,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      publicService.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: publicService.location,
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: AppColor.primaryColor,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    " · ${publicService.createdAt.toRelativeTime()}",
                                style: theme.textTheme.bodySmall!.copyWith(
                                  color: AppColor.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_horiz,
                          color: AppColor.greyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
