import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/helpers/utils/extension.dart';
import '../../../../../i18n/strings.g.dart';
import '../../../../core/core.dart';
import '../../../../route/route_names.dart';
import '../../data/datasources/user/user.dart';
import '../providers/settings_provider.dart';
import '../providers/signup_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_password_textform.dart';
import '../widgets/custom_textform_field.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool showPassword = false;
  bool showConfirmPassword = false;

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _accountController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(signUpControllerProvider);
    final translate = Translations
        .of(context)
        .auth;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 5,bottom: 7),
                      width: 75,
                      height: 75,
                    child: Image.asset('assets/images/${ref.watch(settingsProvider).themeData==1?'logo.png':'logo_wb.png'}')),
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
              Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: context.width / 2.3,
                            child: CustomTextFormField(
                                controller: _firstNameController,
                                hintText: translate.first_name,
                                validationText: translate.enter_data(
                                    data: translate.first_name
                                )
                            )
                        ),
                        SizedBox(
                            width: context.width / 2.3,
                            child: CustomTextFormField(
                                controller: _lastNameController,
                                hintText: translate.last_name,
                                validationText: translate.enter_data(
                                    data: translate.last_name)
                            )
                        )
                      ],
                    ),
                    !(_firstNameController.text + _lastNameController.text)
                        .isStringValid()
                        && _firstNameController.text.isNotEmpty &&
                        _lastNameController.text.isNotEmpty
                        ?
                    Text(translate.user_name_invalid,
                      style: k2dRegular.copyWith(color: const Color(0xffA12027),
                          fontSize: 12),
                    ).pad(bottom: 20) : const SizedBox(height: 20,),
                    CustomTextFormField(
                        controller: _accountController,
                        hintText: '${translate.account_name} (${translate
                            .you_can_change_it_later})',
                        validationText: translate.enter_data(
                            data: translate.account_name)
                    ).pad(bottom: 20),
                    CustomTextFormField(
                        controller: _emailController,
                        hintText: translate.email,
                        validationText: translate.enter_data(
                            data: translate.email)
                    ).pad(bottom: 20),
                    CustomPasswordTextForm(
                        controller: _passwordController,
                        hintText: translate.password,
                        validationText: translate.enter_data(
                            data: translate.password),
                        showPassword: showPassword,
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      passwordLengthWarning: translate.password_length,
                    ).pad(bottom: 20),
                    CustomPasswordTextForm(
                        controller: _confirmPasswordController,
                        hintText: translate.confirm_password,
                        validationText: translate.enter_data(
                            data: translate.confirm_password),
                        showPassword: showConfirmPassword,
                        passwordLengthWarning: translate.password_length,
                        passwordNotMatch: translate.password_not_match,
                        isConfirmPassword: true,
                        passwordToConfirm: _passwordController.text,
                        onTap: () {
                          setState(() {
                            showConfirmPassword = !showConfirmPassword;
                          });
                        }
                    ).pad(bottom: 20),
                  ],
                ),
              ),
              CustomizedButton(
                  name: translate.signup.toString(),
                  onTap: () async {
                    String userName = _firstNameController.text +
                        _lastNameController.text;
                    if (_key.currentState!.validate() &&
                        userName.isStringValid()) {
                      User? user= await auth.signUp(
                          userName: userName,
                          password: _passwordController.text,
                          email: _emailController.text,
                          accountName: _accountController.text);
                      if(user!=null){
                        context.goNamed(RouteNames.login);
                      }
                    }
                  }).pad(top: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(translate.already_have_account),
                    TextButton(
                        onPressed: () {
                          context.replaceNamed(RouteNames.login);
                        },
                        child: Text(translate.login)
                    )
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
