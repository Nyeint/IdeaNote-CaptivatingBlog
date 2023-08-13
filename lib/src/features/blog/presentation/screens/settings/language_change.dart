import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/auth/presentation/providers/settings_provider.dart';
import '../../../../../../i18n/strings.g.dart';

class LanguageChangeView extends ConsumerWidget {
  const LanguageChangeView({Key? key}) : super(key: key);

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
                      onPressed: (){
                        context.pop();
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded, color: ColorResources.primary,)
                  ).pad(right: 20),
                  Text(translate.blog.language,
                    style: k2dSemiBold,)
                ],
              ).pad(bottom: 20),
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        LocaleSettings.setLocale(AppLocale.my);
                        ref.read(settingsProvider).saveLocale(const Locale('my'));
                      },
                      icon: Icon(
                          LocaleSettings.currentLocale.name.toString()=="my"?
                          Icons.radio_button_checked:Icons.radio_button_off)),
                  const Text("ဗမာ")
                ],
              ).pad(left: 50),
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        LocaleSettings.setLocale(AppLocale.en);
                        ref.read(settingsProvider).saveLocale(const Locale('my'));
                      },
                      icon: Icon(
                          LocaleSettings.currentLocale.name.toString()=="my"?
                          Icons.radio_button_off:Icons.radio_button_checked)),
                  const Text("English")
                ],
              ).pad(left: 50),
            ],
          ),
        )
    );
  }
}
