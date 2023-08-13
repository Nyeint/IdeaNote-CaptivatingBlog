import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/auth/presentation/providers/profile_provider.dart';
import 'package:idea_notes/src/features/auth/presentation/widgets/custom_textform_field.dart';
import '../../../../../../i18n/strings.g.dart';

class ChangeAccountNameView extends ConsumerStatefulWidget {
  const ChangeAccountNameView({Key? key}) : super(key: key);

  @override
  ChangeAccountNameViewState createState() => ChangeAccountNameViewState();
}

class ChangeAccountNameViewState extends ConsumerState<ChangeAccountNameView> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    nameController.text=ref.read(profileProvider).user!.accountName.toString();
  }
  @override
  Widget build(BuildContext context) {
    final translate = Translations.of(context);
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            context.pop();
                          },
                          icon: Icon(Icons.arrow_back_ios_new_rounded, color: ColorResources.primary,)
                      ).pad(right: 20),
                      Text(translate.auth.account_name,
                        style: k2dSemiBold,)
                    ],
                  ),
                  TextButton(
                      onPressed: () async {
                        if(_key.currentState!.validate()){
                          await ref.read(profileProvider).changeAccountName(accountName: nameController.text);
                          context.pop();
                        }
                      },
                      child: Text(translate.blog.save,style: k2dMedium.copyWith(fontSize: 19),)
                  ),
                ],
              ).pad(bottom: 20),
              Form(
                key: _key,
                child: CustomTextFormField(
                    controller: nameController,
                    hintText: translate.auth.account_name,
                    validationText: translate.auth.enter_data(data: translate.auth.account_name)
                ).pad(left: 15, right: 15),
              ),
            ],
          ),
        )
    );
  }
}

