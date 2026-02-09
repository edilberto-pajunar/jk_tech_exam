import 'package:flutter/material.dart';
import 'package:jk_tech_exam/features/dashboard/message/view/message_view.dart';

class MessagePage extends StatelessWidget {
  static String route = "message_route";
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MessageView();
  }
}
