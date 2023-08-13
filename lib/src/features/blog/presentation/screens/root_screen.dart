import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/features/auth/presentation/providers/settings_provider.dart';
import 'package:idea_notes/src/features/blog/presentation/screens/splash_screen.dart';
import 'package:idea_notes/src/route/route_names.dart';
import '../../../../../i18n/strings.g.dart';
import '../../../auth/data/datasources/user/user.dart';
import '../../../auth/presentation/providers/profile_provider.dart';

class RootScreen extends ConsumerStatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  RootScreenState createState() => RootScreenState();
}

class RootScreenState extends ConsumerState<RootScreen> {
  @override
  void initState() {
    super.initState();
    // ref.read(profileProvider).getUser();
    checkState();
  }

  void checkState()async{
    await Future.delayed(const Duration(seconds: 1));
    await ref.read(profileProvider).getUser().then((value) async {
      User? user = ref.watch(profileProvider).user;
      if (user == null) {
        context.goNamed(RouteNames.login);
      } else {
        await ref.read(settingsProvider).readLocale();
        Locale? locale=ref.read(settingsProvider).locale;
        locale.toString()=='my'?LocaleSettings.setLocale(AppLocale.my):LocaleSettings.setLocale(AppLocale.en);

        await ref.read(settingsProvider).readTheme();
        context.goNamed(RouteNames.viewBlog);
        // ref.read(blogProvider).viewAllBlog().then((value){
        //   ref.read(blogProvider).viewMyBlog().then((value){
        //    context.goNamed(RouteNames.viewBlog);
        //   });
        // });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
