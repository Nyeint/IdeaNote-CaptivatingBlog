import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/auth/presentation/providers/settings_provider.dart';
import '../../../../../../i18n/strings.g.dart';

class ThemeChangeView extends ConsumerWidget {
  const ThemeChangeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translate = Translations.of(context);
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: ColorResources.primary,
                  )).pad(right: 20),
              Text(
                translate.blog.theme,
                style: k2dSemiBold,
              )
            ],
          ).pad(bottom: 20),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    // Locale locale1=Locale('my');
                    // LocaleSettings.setLocale(locale1 as AppLocale);
                    ref.watch(settingsProvider).saveTheme(0);
                    // Locale ll=await ref.read(storageRepoImplProvider).readLocale();
                    // LocaleSettings.setLocale(ll as AppLocale);
                  },
                  icon: Icon(ref.read(settingsProvider).themeData == 0
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off)),
               const Text("Light Mode")
            ],
          ).pad(left: 50),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    ref.watch(settingsProvider).saveTheme(1);
                  },
                  icon: Icon(ref.read(settingsProvider).themeData==1?
                       Icons.radio_button_checked
                      : Icons.radio_button_off)),
               const Text("Dark Mode")
            ],
          ).pad(left: 50),
        ],
      ),
    ));
  }
}
