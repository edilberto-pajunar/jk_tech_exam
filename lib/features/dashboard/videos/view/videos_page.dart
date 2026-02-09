import 'package:flutter/material.dart';
import 'package:jk_tech_exam/features/dashboard/videos/view/videos_view.dart';

class VideosPage extends StatelessWidget {
  static String route = "videos_route";
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const VideosView();
  }
}
