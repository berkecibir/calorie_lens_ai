import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_padding/device_padding.dart';
import 'package:calorie_lens_ai_app/core/widgets/device_spacing/device_spacing.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/auth_text_form_field.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/pages/auth/widgets/welcome_widget.dart';
import 'package:calorie_lens_ai_app/feat/calorie_lens_ai/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static const String id = AppTexts.signUpPageId;

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: CustomAppBar.auth(),
          body: Padding(
            padding: DevicePadding.small.all,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WelcomeWidget(),
                    DeviceSpacing.large.height,
                    Form(
                        key: key,
                        child: Column(
                          children: [
                            AuthTextFormField.email(validator: (email) => null
                                // TODO: email validation

                                // controller: emailcontroller will add,
                                ),
                          ],
                        ))
                  ]),
            ),
          )),
    );
  }
}
