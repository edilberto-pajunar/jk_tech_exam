import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:jk_tech_exam/shared/colors.dart';
import 'package:jk_tech_exam/shared/image.dart';

class PrimaryTextField<T> extends StatefulWidget {
  const PrimaryTextField({
    required this.hintText,
    required this.name,
    required this.label,
    this.suffixIcon,
    this.onTap,
    this.showPasswordToggle = false,
    this.obscureText = false,
    this.validators,
    this.isRequired = false,
    this.readOnly = false,
    this.onChanged,
    this.initialValue,
    super.key,
    this.numberOnly = false,
    this.enabled = true,
  });

  final String hintText;
  final String name;
  final String label;
  final Widget? suffixIcon;
  final Function()? onTap;
  final bool showPasswordToggle;
  final bool obscureText;
  final List<FormFieldValidator<T>>? validators;
  final bool isRequired;
  final bool readOnly;
  final Function(String?)? onChanged;
  final String? initialValue;
  final bool numberOnly;
  final bool enabled;

  @override
  State<PrimaryTextField<T>> createState() => _PrimaryTextFieldState<T>();
}

class _PrimaryTextFieldState<T> extends State<PrimaryTextField<T>> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isRequired
            ? RichText(
                text: TextSpan(
                  text: widget.label,
                  style: theme.textTheme.bodyLarge,
                  children: [
                    TextSpan(
                      text: "*",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: AppColor.errorColor,
                      ),
                    ),
                  ],
                ),
              )
            : Text(widget.label, style: theme.textTheme.bodyLarge),
        const SizedBox(height: 6.0),
        FormBuilderTextField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          name: widget.name,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: AppColor.whiteColor,
          ),

          keyboardType: widget.numberOnly
              ? TextInputType.number
              : TextInputType.text,
          cursorColor: AppColor.primaryColor,
          maxLines: 1,
          obscureText: widget.obscureText && !isPasswordVisible,
          inputFormatters: widget.numberOnly
              ? [FilteringTextInputFormatter.digitsOnly]
              : [],
          decoration: InputDecoration(
            hintStyle: theme.textTheme.bodyMedium!.copyWith(
              color: AppColor.hintColor,
            ),
            hintText: widget.hintText,
            suffixIcon: widget.showPasswordToggle
                ? IconButton(
                    icon: SvgPicture.asset(
                      isPasswordVisible ? AppImage.eye : AppImage.viewOffSlash,
                    ),
                    onPressed: () =>
                        setState(() => isPasswordVisible = !isPasswordVisible),
                  )
                : widget.suffixIcon,
          ),
          onTap: widget.onTap,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          initialValue: widget.initialValue,
          onChanged: widget.onChanged,
          validator: FormBuilderValidators.compose([
            if (widget.isRequired) FormBuilderValidators.required(),
            if (widget.validators != null)
              ...widget.validators!.map(
                (validator) => validator as FormFieldValidator<String>,
              ),
          ]),
          readOnly: widget.readOnly,
          enabled: widget.enabled,
        ),
      ],
    );
  }
}
