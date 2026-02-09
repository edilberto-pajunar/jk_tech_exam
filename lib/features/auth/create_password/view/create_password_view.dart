import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:jk_tech_exam/features/auth/login/view/login_page.dart';
import 'package:jk_tech_exam/features/auth/register/view/register_page.dart';
import 'package:jk_tech_exam/shared/colors.dart';
import 'package:jk_tech_exam/widgets/buttons/primary_button.dart';
import 'package:jk_tech_exam/widgets/fields/primary_text_field.dart';

const _allowedSpecial = r'!@#\$&\-';
final _onlyAllowedChars = RegExp(r'^[a-zA-Z0-9!@#\$&\-]+$');

bool _hasMinLength(String? v) => (v ?? '').length >= 8;
bool _hasUpperCase(String? v) => v != null && RegExp(r'[A-Z]').hasMatch(v);
bool _isAlphanumeric(String? v) {
  if (v == null || v.isEmpty) return false;
  return _onlyAllowedChars.hasMatch(v) &&
      RegExp(r'[a-zA-Z]').hasMatch(v) &&
      RegExp(r'[0-9]').hasMatch(v);
}

bool _onlyAcceptedSpecial(String? v) =>
    v == null || v.isEmpty || _onlyAllowedChars.hasMatch(v);

bool _isPasswordValid(String? v) =>
    v != null &&
    _hasMinLength(v) &&
    _hasUpperCase(v) &&
    _isAlphanumeric(v) &&
    _onlyAcceptedSpecial(v);

class CreatePasswordView extends StatefulWidget {
  const CreatePasswordView({super.key});

  @override
  State<CreatePasswordView> createState() => _CreatePasswordViewState();
}

class _CreatePasswordViewState extends State<CreatePasswordView> {
  final formKey = GlobalKey<FormBuilderState>();

  bool canSubmit() {
    final values = formKey.currentState?.value;
    if (values == null) return false;
    final password = values["password"] as String?;
    return _isPasswordValid(password);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
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
                        Text(
                          "Create Password",
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20.0),
                        PrimaryTextField(
                          hintText: "Enter your password here",
                          name: "password",
                          label: "Password",
                          isRequired: true,
                          showPasswordToggle: true,
                          validators: [
                            (v) {
                              final s = v as String?;
                              if (s == null || s.isEmpty) return null;
                              return _isPasswordValid(s)
                                  ? null
                                  : "Password does not meet all requirements.";
                            },
                          ],
                        ),
                        _PasswordRules(
                          password:
                              formKey.currentState?.value["password"]
                                  as String?,
                        ),
                        const SizedBox(height: 20.0),
                        PrimaryButton(
                          text: "Sign up",
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
                        const Spacer(),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: theme.textTheme.bodyMedium,
                            text: "Don't have an account yet? ",
                            children: [
                              TextSpan(
                                text: "Sign in ",
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.goNamed(LoginPage.route);
                                  },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PasswordRules extends StatelessWidget {
  const _PasswordRules({this.password});

  final String? password;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rules = [
      ("Minimum length: 8 characters", _hasMinLength(password)),
      ("1 upper case letter", _hasUpperCase(password)),
      ("Alphanumeric", _isAlphanumeric(password)),
      (
        "Accepted special characters: ! @ # \$ & -",
        _onlyAcceptedSpecial(password),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rules
            .map(
              (rule) => Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.check,
                      size: 18,
                      color: rule.$2
                          ? AppColor.primaryColor
                          : AppColor.greyColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        rule.$1,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: rule.$2
                              ? AppColor.primaryColor
                              : AppColor.greyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
