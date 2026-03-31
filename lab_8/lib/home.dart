import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'constants/colors.dart';
import 'constants/text_styles_value.dart';
import 'translations/locale_keys.g.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.welcome.tr(),
              style: AppTextStyles.heading,
            ),
            const SizedBox(height: 10),
            Text(
              LocaleKeys.description.tr(),
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 20),
            Text(
              LocaleKeys.change_language.tr(),
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await context.setLocale(const Locale('en'));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: Text('EN', style: AppTextStyles.button),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await context.setLocale(const Locale('ru'));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                  ),
                  child: Text('RU', style: AppTextStyles.button),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
