import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:jk_tech_exam/features/auth/create_password/view/create_password_page.dart';
import 'package:jk_tech_exam/features/auth/login/view/login_page.dart';
import 'package:jk_tech_exam/features/auth/otp/view/otp_page.dart';
import 'package:jk_tech_exam/features/auth/register/bloc/register_bloc.dart';
import 'package:jk_tech_exam/shared/colors.dart';
import 'package:jk_tech_exam/widgets/buttons/primary_button.dart';
import 'package:jk_tech_exam/widgets/fields/primary_text_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formKey = GlobalKey<FormBuilderState>();

  bool canSubmit() {
    final values = formKey.currentState?.value;
    if (values == null) return false;
    final email = values["email"];
    return email != null && email.isNotEmpty;
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
                    child: BlocConsumer<RegisterBloc, RegisterState>(
                      listenWhen: (previous, current) =>
                          previous.status != current.status,
                      listener: (context, state) {
                        final route = ModalRoute.of(context);
                        final isCurrentRoute = route?.isCurrent ?? false;
                        if (state.status == RegisterStatus.success &&
                            isCurrentRoute) {
                          context.pushNamed(OtpPage.route);
                        } else if (state.status == RegisterStatus.error &&
                            isCurrentRoute) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.errorMessage ?? "An error occurred",
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("Sign up", style: theme.textTheme.titleLarge),
                            const SizedBox(height: 20.0),
                            PrimaryTextField(
                              hintText: "Enter your Email",
                              name: "email",
                              label: "Email",
                              isRequired: true,
                              validators: [FormBuilderValidators.email()],
                            ),
                            const SizedBox(height: 40.0),
                            PrimaryButton(
                              text: "Next",
                              onPressed: () {
                                if (formKey.currentState!.saveAndValidate()) {
                                  final email =
                                      formKey.currentState?.value["email"];
                                  context.read<RegisterBloc>().add(
                                    RegisterEmailRequested(email: email),
                                  );
                                }
                              },
                              enabled: canSubmit(),
                            ),
                            const SizedBox(height: 20.0),
                            const Spacer(),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: theme.textTheme.bodyMedium,
                                text: "Already have an account? ",
                                children: [
                                  TextSpan(
                                    text: "Sign in",
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
                        );
                      },
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
