import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jk_tech_exam/features/auth/create_profile/cubit/create_profile_cubit.dart';
import 'package:jk_tech_exam/features/auth/create_profile/widget/create_fullname.dart';
import 'package:jk_tech_exam/features/auth/create_profile/widget/create_profile_picture.dart';
import 'package:jk_tech_exam/features/auth/create_profile/widget/create_username.dart';
import 'package:jk_tech_exam/widgets/buttons/primary_button.dart';
import 'package:jk_tech_exam/widgets/fields/primary_text_field.dart';

class CreateProfileView extends StatefulWidget {
  const CreateProfileView({super.key});

  @override
  State<CreateProfileView> createState() => _CreateProfileViewState();
}

class _CreateProfileViewState extends State<CreateProfileView> {
  final formKey = GlobalKey<FormBuilderState>();
  final int _activePage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Widget> pages = [
      CreateFullname(formKey: formKey),
      const CreateUsername(),
      const CreateProfilePicture(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Create your Profile")),
      body: BlocBuilder<CreateProfileCubit, CreateProfileState>(
        builder: (context, state) {
          return Stack(
            children: [
              PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    pages[state.activePage & pages.length],
                controller: _pageController,
                itemCount: pages.length,
              ),
            ],
          );
        },
      ),
    );
  }
}
