import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/auth/presentation/providers/settings_provider.dart';
import 'package:idea_notes/src/helpers/utils/initialize.dart';
import 'package:idea_notes/src/route/route.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'i18n/strings.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  usePathUrlStrategy();
  LocaleSettings.useDeviceLocale();
  final prefs = await SharedPreferences.getInstance();
  await SentryFlutter.init(
        (options) {
      options.dsn = 'https://434d7213fd2919f39b78819037ef6e3f@o1396938.ingest.sentry.io/4505675765448704';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(ProviderScope(overrides: [
      sharedPrefsProvider.overrideWithValue(prefs),
    ], child: TranslationProvider(child: const MyApp()))),
  );

}
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: LoaderOverlay(
        child: MaterialApp.router(
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          debugShowCheckedModeBanner: false,
          routerConfig: MyRouter.routerConfig,
          title: 'Flutter Demo',
          theme:
              ref.watch(settingsProvider).themeData == 1
                  ? darkTheme
                  : lightTheme,
          themeMode: ThemeMode.system,
        ),
      ),
    );
  }
}
