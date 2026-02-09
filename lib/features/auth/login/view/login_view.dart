import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:jk_tech_exam/features/auth/create_password/view/create_password_page.dart';
import 'package:jk_tech_exam/features/auth/create_profile/view/create_profile_page.dart';
import 'package:jk_tech_exam/features/auth/otp/view/otp_page.dart';
import 'package:jk_tech_exam/features/auth/register/view/register_page.dart';
import 'package:jk_tech_exam/shared/colors.dart';
import 'package:jk_tech_exam/shared/image.dart';
import 'package:jk_tech_exam/widgets/buttons/primary_button.dart';
import 'package:jk_tech_exam/widgets/buttons/social_button.dart';
import 'package:jk_tech_exam/widgets/fields/primary_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormBuilderState>();

  bool canSubmit() {
    final values = formKey.currentState?.value;
    if (values == null) return false;
    final email = values["email"];
    final password = values["password"];
    return email != null &&
        email.isNotEmpty &&
        password != null &&
        password.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FormBuilder(
            key: formKey,
            onChanged: () {
              formKey.currentState?.save();
              setState(() {});
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Login", style: theme.textTheme.titleLarge),
                const SizedBox(height: 20.0),
                PrimaryTextField(
                  hintText: "Enter your Mobile number or Email",
                  name: "email",
                  label: "Mobile number or Email",
                  isRequired: true,
                  validators: [FormBuilderValidators.email()],
                ),
                const SizedBox(height: 12.0),
                const PrimaryTextField(
                  hintText: "Enter your password here",
                  name: "password",
                  label: "Password",
                  isRequired: true,
                  showPasswordToggle: true,
                ),
                const SizedBox(height: 12.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot password?",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      decoration: TextDecoration.underline,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                PrimaryButton(
                  text: "Login",
                  onPressed: () {},
                  enabled: canSubmit(),
                ),
                const SizedBox(height: 20.0),
                FormBuilderCheckbox(
                  visualDensity: const VisualDensity(horizontal: -4.0),
                  checkColor: AppColor.primaryColor,
                  name: "agreeToTerms",
                  title: RichText(
                    text: TextSpan(
                      style: theme.textTheme.bodyMedium,
                      text: "I have read and agree to the ",
                      children: [
                        TextSpan(
                          text:
                              "Terms of Use, Privacy Policy, Community Guidelines, ",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(text: "and "),
                        TextSpan(
                          text: "Cookie Policy",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: theme.textTheme.bodyMedium,
                    text: "Don't have an account yet? ",
                    children: [
                      TextSpan(
                        text: "Sign up ",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.goNamed(RegisterPage.route);
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22.0),
                SocialButton(
                  text: "Continue with Google",
                  onPressed: () {
                    context.pushNamed(CreateProfilePage.route);
                  },
                  icon: AppImage.google,
                ),
                const SizedBox(height: 16.0),
                SocialButton(
                  text: "Continue with Facebook",
                  onPressed: () {},
                  icon: AppImage.facebook,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
