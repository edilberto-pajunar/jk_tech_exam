import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jk_tech_exam/features/dashboard/home/widgets/community_tab.dart';
import 'package:jk_tech_exam/features/dashboard/home/widgets/for_you_tab.dart';
import 'package:jk_tech_exam/features/dashboard/home/widgets/news_tab.dart';
import 'package:jk_tech_exam/features/dashboard/home/widgets/public_service_tab.dart';
import 'package:jk_tech_exam/shared/colors.dart';
import 'package:jk_tech_exam/shared/image.dart';
import 'package:jk_tech_exam/widgets/fields/search_text_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

typedef TabItem = ({String title, String icon, Widget page});

const List<TabItem> _tabs = [
  (title: "For you", icon: AppImage.fire, page: ForYouTab()),
  (title: "News", icon: AppImage.news, page: NewsTab()),
  (title: "Public Service", icon: AppImage.public, page: PublicServiceTab()),
  (title: "Community", icon: AppImage.community, page: CommunityTab()),
];

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            toolbarHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    const Flexible(child: SearchTextField(hintText: "Search")),
                    const SizedBox(width: 16.0),
                    SvgPicture.asset(AppImage.notification),
                  ],
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: AppColor.primaryColor,
                unselectedLabelColor: AppColor.greyColor,
                indicatorColor: AppColor.primaryColor,
                tabs: _tabs
                    .map(
                      (t) => Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(t.icon, width: 20, height: 20),
                            const SizedBox(width: 6),
                            Text(t.title),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: _tabs
              .map((tab) => CustomScrollView(slivers: [tab.page]))
              .toList(),
        ),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  _TabBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) =>
      tabBar != oldDelegate.tabBar;
}
