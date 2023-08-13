import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/auth/presentation/providers/settings_provider.dart';
import 'package:idea_notes/src/route/route_names.dart';
import 'package:launch_review/launch_review.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../../../auth/presentation/providers/logout_provider.dart';
import '../../../../auth/presentation/providers/profile_provider.dart';
import '../../providers/check_state_provider.dart';

class ChangeSettings extends ConsumerStatefulWidget {
  const ChangeSettings({Key? key}) : super(key: key);

  @override
  ChangeSettingsState createState() => ChangeSettingsState();
}

class ChangeSettingsState extends ConsumerState<ChangeSettings> {
  Gravatar? gravatar;
  @override
  void initState(){
    final userName = ref.read(profileProvider).user!.username;
    gravatar = Gravatar('${userName.toLowerCase()}@gmail.com');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final translate = Translations.of(context);
    final user = ref.watch(profileProvider).user;
    return SafeArea(
        child: Scaffold(
            body:
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          context.goNamed(RouteNames.account);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: ColorResources.primary,
                        )).pad(right: 20),
                    const Text(
                      "Settings",
                      style: k2dSemiBold,
                    )
                  ],
                ),
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    border: Border.all(
                        color: Colors.white,
                        width: 2
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.network(gravatar!.imageUrl()).image,
                            fit: BoxFit.cover
                        ),
                        shape: BoxShape.circle
                    ),
                  ),
                ).pad(top: 20),

                Expanded(
                  child: SettingsList(
                    platform: DevicePlatform.iOS,
                    shrinkWrap: true,
                      darkTheme: SettingsThemeData(
                        settingsSectionBackground: Theme.of(context).scaffoldBackgroundColor,
                        settingsListBackground: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      lightTheme: SettingsThemeData(
                        settingsSectionBackground: Theme.of(context).scaffoldBackgroundColor,
                          settingsListBackground: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      sections: [
                        SettingsSection(
                          title: const Text('Account'),
                          tiles: <SettingsTile>[
                            SettingsTile.navigation(
                              onPressed: (context){
                                context.pushNamed(RouteNames.userName);
                              },
                              leading: const Icon(Icons.person),
                              title: Text(translate.blog.name),
                              value:  Text(user!.accountName),
                            ),
                            SettingsTile(
                              onPressed: (context){
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    content: Text(translate.blog.sure_logout,
                                        style:k2dMedium),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () async {
                                          await ref.read(logOutControllerProvider).logOut().then((value){
                                            ref.read(tabIndex.notifier).state = 0;
                                            context.goNamed(RouteNames.login);
                                          });
                                        },
                                        child: Text(translate.auth.logout,
                                            style: k2dMedium),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'Cancel'),
                                        child: Text(translate.blog.cancel,
                                            style: k2dMedium.copyWith(color: Theme.of(context).primaryColorDark)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              leading: const Icon(Icons.logout_outlined),
                              title: Text(translate.auth.logout),
                            ),
                          ],
                        ),
                        SettingsSection(
                          title: const Text('Features'),
                          tiles: <SettingsTile>[
                            SettingsTile.navigation(
                              onPressed: (context){
                                context.pushNamed(RouteNames.language);
                              },
                              leading: const Icon(Icons.language),
                              title: Text(translate.blog.language),
                              value: Text(translate.blog.locale),
                            ),
                            SettingsTile.switchTile(
                              activeSwitchColor: ColorResources.primary,
                              onToggle: (value) {
                                if(ref.watch(settingsProvider).themeData==0){
                                  ref.watch(settingsProvider).saveTheme(1);
                                }
                                else{
                                  ref.watch(settingsProvider).saveTheme(0);
                                }
                              },
                              initialValue:  ref.watch(settingsProvider).themeData==1?false:true,
                              leading: const Icon(Icons.format_paint),
                              title: Text(translate.blog.theme),
                            ),
                          ],
                        ),
                        SettingsSection(
                          title: const Text('App'),
                          tiles: <SettingsTile>[
                            SettingsTile.navigation(
                              onPressed: (context){
                                LaunchReview.launch(androidAppId: "com.flyingsparrow.idea.note");
                              },
                              leading: const Icon(Icons.star_rate),
                              title: const Text('Rate this app'),
                            ),
                            SettingsTile(
                             leading: const Icon(Icons.app_settings_alt),
                              title: const Text('Version'),
                              value: const Text('1.0.1'),
                            ),
                          ],
                        )
                      ]
                  ),
                ),
              ],
            )
    ));
  }
}
