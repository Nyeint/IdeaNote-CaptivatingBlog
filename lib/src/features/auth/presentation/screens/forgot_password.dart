import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:idea_notes/src/features/auth/presentation/widgets/custom_button.dart';
import 'package:idea_notes/src/features/auth/presentation/widgets/custom_textform_field.dart';
import 'package:idea_notes/src/route/route_names.dart';
import '../../../../../i18n/strings.g.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(forgotPasswordControllerProvider);
    final translate = Translations.of(context).auth;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text('Forgotten your password?',
                    style: k2dSemiBold
                ),
              ).pad(bottom: 20,top: 30),
              Text(translate.forgot_password_des,
              style: k2dRegular,).pad(bottom: 30),
              Form(
                key: _key,
                child: CustomTextFormField(
                    controller: _emailController,
                    hintText: translate.email,
                    validationText: translate.enter_data(data: translate.email)
                ).pad(bottom: 30),
              ),
              CustomizedButton(
                  name: translate.reset_password, onTap: (){
                if(_key.currentState!.validate()){
                  auth.forgotPassword(email: _emailController.text);
                  //auth.logIn(userName: _nameController.text, password: _passwordController.text);
                }
              }
              ).pad(bottom: 10),
              TextButton(
                  onPressed: (){
                    context.replaceNamed(RouteNames.login);
                  },
                  child: Text(translate.back_to_login,style: k2dRegular.copyWith(color: ColorResources.primary),)
              )
            ],
          ).pad(left: 15, right: 15),
        ),
      ),
    );
  }
}
