import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/auth/presentation/providers/login_provider.dart';
import 'package:idea_notes/src/features/auth/presentation/providers/profile_provider.dart';
import 'package:idea_notes/src/features/auth/presentation/widgets/custom_button.dart';
import 'package:idea_notes/src/features/auth/presentation/widgets/custom_password_textform.dart';
import 'package:idea_notes/src/features/auth/presentation/widgets/custom_textform_field.dart';
import 'package:idea_notes/src/route/route_names.dart';
import '../../../../../i18n/strings.g.dart';
import '../../data/datasources/user/user.dart';
import '../providers/settings_provider.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  LogInScreenState createState() => LogInScreenState();
}

class LogInScreenState extends ConsumerState<LogInScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool showPassword = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(logInControllerProvider);
    final translate = Translations.of(context).auth;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(translate.locale),
                    IconButton(
                        onPressed: () {
                          showMenu(
                              color: Colors.white,
                              context: context,
                              position:
                              RelativeRect.fromLTRB(context.width, 0, 0, 0),
                              items: <PopupMenuEntry>[
                                PopupMenuItem(
                                  value: "myanmar",
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context, "myanmar");
                                        LocaleSettings.setLocale(AppLocale.my);
                                        ref.read(settingsProvider).saveLocale(const Locale('my'));
                                      },
                                      child: Text("ဗမာ",style: k2dRegular.copyWith(color: ColorResources.textPrimary))),
                                ),
                                PopupMenuItem(
                                  value: "english",
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context, "english");
                                        LocaleSettings.setLocale(AppLocale.en);
                                        ref.read(settingsProvider).saveLocale(const Locale('en'));
                                      },
                                      child: Text(
                                        "English",style: k2dRegular.copyWith(color: ColorResources.textPrimary),
                                      )),
                                ),
                              ]);
                        },
                        icon: const Icon(Icons.language))
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5,bottom: 7),
                      width: 75,
                      height: 75,
                      child: Image.asset('assets/images/${ref.watch(settingsProvider).themeData==1?'logo.png':'logo_wb.png'}')
                  ),
                  SizedBox(
                    height: 90,
                    child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      children: [
                        Text(
                          'IDEA',
                          style: k2dSemiBold.copyWith(fontSize: 35),
                        ),
                        Text(
                          'NOTE',
                          style: k2dSemiBold.copyWith(fontSize: 35),
                        ),
                      ],
                    )
                  ),
                  )
                ],
              ).pad(top: 50,bottom: 50),

              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          CustomTextFormField(
                              controller: _nameController,
                              hintText: translate.account_name,
                              validationText: translate.enter_data(data: translate.account_name))
                              .pad(bottom: 20),
                          CustomPasswordTextForm(
                              controller: _passwordController,
                              hintText: translate.password,
                              validationText: translate.enter_data(data: translate.password),
                              showPassword: showPassword,
                              onTap: () {
                                setState(() {
                                  showPassword=!showPassword;
                                });
                              }
                              ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {
                            context.goNamed(RouteNames.forgotPassword);
                          },
                          child: Text(translate.forgot_password)),
                    ).pad(bottom: 20),
                    CustomizedButton(
                        name: translate.login.toString(),
                        onTap: () async {
                          if (_key.currentState!.validate()) {
                            User? user=await auth.logIn(
                                userName: _nameController.text,
                                password: _passwordController.text);
                            if(user!=null){
                              await ref.read(profileProvider).getUser();
                              context.goNamed(RouteNames.viewBlog);
                            }
                          }
                        }),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(translate.create_account),
                          TextButton(
                              onPressed: () {
                                context.replaceNamed(RouteNames.signup);
                              },
                              child: Text(translate.signup, overflow: TextOverflow.ellipsis,)
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).pad(left: 15, right: 15),
        ),
      ),
    );
  }
}
