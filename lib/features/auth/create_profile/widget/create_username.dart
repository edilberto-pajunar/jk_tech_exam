import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jk_tech_exam/features/auth/create_profile/cubit/create_profile_cubit.dart';
import 'package:jk_tech_exam/shared/colors.dart';
import 'package:jk_tech_exam/widgets/buttons/primary_button.dart';
import 'package:jk_tech_exam/widgets/fields/primary_text_field.dart';

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

bool _isUsernameValid(String? v) =>
    v != null &&
    _hasMinLength(v) &&
    _hasUpperCase(v) &&
    _isAlphanumeric(v) &&
    _onlyAcceptedSpecial(v);

class CreateUsername extends StatefulWidget {
  const CreateUsername({super.key});

  @override
  State<CreateUsername> createState() => _CreateUsernameState();
}

class _CreateUsernameState extends State<CreateUsername> {
  final formKey = GlobalKey<FormBuilderState>();

  bool canSubmit() {
    final values = formKey.currentState?.value;
    if (values == null) return false;
    final username = values["username"] as String?;
    return _isUsernameValid(username);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            PrimaryTextField(
              hintText: "Enter your username",
              name: "username",
              label: "Username",
              isRequired: true,
              validators: [
                (v) {
                  final s = v as String?;
                  if (s == null || s.isEmpty) return null;
                  return _isUsernameValid(s)
                      ? null
                      : "Username does not meet all requirements.";
                },
              ],
            ),
            _UsernameRules(
              value: formKey.currentState?.value["username"] as String?,
            ),
            const SizedBox(height: 40.0),
            PrimaryButton(
              text: "Next",
              onPressed: canSubmit()
                  ? () => context.read<CreateProfileCubit>().nextPage()
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _UsernameRules extends StatelessWidget {
  const _UsernameRules({this.value});

  final String? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rules = [
      ("Minimum length: 8 characters", _hasMinLength(value)),
      ("1 upper case letter", _hasUpperCase(value)),
      ("Alphanumeric", _isAlphanumeric(value)),
      (
        "Accepted special characters: ! @ # \$ & -",
        _onlyAcceptedSpecial(value),
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
