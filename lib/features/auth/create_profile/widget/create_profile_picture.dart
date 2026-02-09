import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jk_tech_exam/shared/colors.dart';
import 'package:jk_tech_exam/shared/image.dart';
import 'package:jk_tech_exam/widgets/buttons/primary_button.dart';
import 'package:jk_tech_exam/widgets/buttons/social_button.dart';
import 'package:jk_tech_exam/widgets/fields/primary_text_field.dart';

class CreateProfilePicture extends StatefulWidget {
  const CreateProfilePicture({super.key});

  @override
  State<CreateProfilePicture> createState() => _CreateProfilePictureState();
}

class _CreateProfilePictureState extends State<CreateProfilePicture> {
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            textAlign: TextAlign.center,
            "Profile Picture",
            style: theme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0),
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.whiteColor, width: 6.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withValues(alpha: 0.05),
                  blurRadius: 10.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            height: 200,
            width: 200,
            alignment: Alignment.center,
            child: SvgPicture.asset(AppImage.image, height: 64.0, width: 64.0),
          ),

          const SizedBox(height: 40.0),
          Row(
            children: [
              Expanded(
                child: SocialButton(
                  text: "Take a photo",
                  onPressed: () {},
                  icon: AppImage.camera,
                  borderColor: AppColor.borderColor,
                  textColor: AppColor.blackColor,
                  borderRadius: 48.0,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: SocialButton(
                  text: "Take a photo",
                  onPressed: () {},
                  icon: AppImage.upload,
                  borderColor: AppColor.borderColor,
                  textColor: AppColor.blackColor,
                  borderRadius: 48.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40.0),
          PrimaryButton(text: "Next", onPressed: () {}),
        ],
      ),
    );
  }
}
