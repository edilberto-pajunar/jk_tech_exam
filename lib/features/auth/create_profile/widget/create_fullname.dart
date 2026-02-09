import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jk_tech_exam/features/auth/create_profile/cubit/create_profile_cubit.dart';
import 'package:jk_tech_exam/widgets/buttons/primary_button.dart';
import 'package:jk_tech_exam/widgets/fields/primary_text_field.dart';

class CreateFullname extends StatefulWidget {
  const CreateFullname({super.key, required this.formKey});

  final GlobalKey<FormBuilderState> formKey;

  @override
  State<CreateFullname> createState() => _CreateFullnameState();
}

class _CreateFullnameState extends State<CreateFullname> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PrimaryTextField(
            hintText: "Enter your First Name",
            name: "firstName",
            label: "First Name",
            isRequired: true,
          ),
          const SizedBox(height: 12.0),
          const PrimaryTextField(
            hintText: "Enter your Last Name",
            name: "lastName",
            label: "Last Name",
            isRequired: true,
          ),
          const SizedBox(height: 40.0),
          PrimaryButton(
            text: "Next",
            onPressed: () {
              context.read<CreateProfileCubit>().nextPage();
            },
          ),
        ],
      ),
    );
  }
}
