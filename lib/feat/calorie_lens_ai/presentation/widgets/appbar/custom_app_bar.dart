import 'package:calorie_lens_ai_app/core/utils/const/app_texts.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  factory CustomAppBar.auth() {
    return CustomAppBar(title: AppTexts.authAppbarTitle);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
