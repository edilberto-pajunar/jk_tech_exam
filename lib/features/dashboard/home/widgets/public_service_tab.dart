import 'package:flutter/material.dart';

class PublicServiceTab extends StatelessWidget {
  const PublicServiceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(children: [Text("Public Service")]),
      ),
    );
  }
}
