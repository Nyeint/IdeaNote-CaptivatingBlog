import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/features/blog/presentation/providers/blog_provider.dart';
import '../../../../../i18n/strings.g.dart';
import '../../../../core/core.dart';
import '../../../../helpers/utils/utility.dart';
import '../../../../route/route_names.dart';
import '../../../auth/presentation/widgets/custom_button.dart';
import '../../../auth/presentation/widgets/custom_textform_field.dart';
import '../providers/check_state_provider.dart';
import '../widgets/custom_app_bar.dart';

class AddBlogView extends ConsumerStatefulWidget {
  const AddBlogView({Key? key}) : super(key: key);

  @override
  AddBlogViewState createState() => AddBlogViewState();
}

class AddBlogViewState extends ConsumerState<AddBlogView> {
  final TextEditingController _titleController = TextEditingController();
  final quill.QuillController _quillController = quill.QuillController.basic();
  quill.QuillController showQuillController = quill.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    final translate = Translations.of(context).blog;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: CustomAppBar(
          text: 'New Blog',
          onTap: (){
              ref.read(tabIndex.notifier).state = 2;
              context.goNamed(RouteNames.account);
              },
          hasWidget: true,
          widget: CustomizedButton(
              name: translate.save,
              width:100,
              onTap: () async {
                if(_titleController.text.isEmpty){
                  Utility.showToast(message: translate.enter_data(data: translate.title),isError: true);
                }
                else if(_quillController.document.isEmpty()){
                  Utility.showToast(message: translate.enter_data(data: translate.content),isError: true);
                }
                else{
                  String data= jsonEncode(_quillController.document.toDelta().toJson());
                  await ref.read(blogProvider).createBlog(title: _titleController.text, content: data);
                  ref.read(tabIndex.notifier).state = 2;
                  context.goNamed(RouteNames.account);
                }
              }),
        ),
        body:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(translate.title,
                style: k2dRegular.copyWith(fontSize: 17,color: ColorResources.textPrimary),).pad(left: 15,right: 15,bottom: 10),

              CustomTextFormField(
                controller: _titleController,
                // hintText: 'eg. blog about your journey',
                hintText: 'eg. my blogging journey',
                validationText: translate.enter_data(data: translate.title),
                maxLines: 5,
                maxLength: 60,
              ).pad(left: 15,right: 15,bottom: 15),

              Text(translate.content,
                style: k2dRegular.copyWith(fontSize: 17,color: ColorResources.textPrimary),
              ).pad(left: 15,right: 15,bottom: 10,top: 10),
              quill.QuillToolbar.basic(controller: _quillController,
                showLink: true,).pad(left: 15,right: 15,bottom: 15),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: ColorResources.textMute),
                  color: Colors.white,
                ),
                width: context.width,
                constraints: const BoxConstraints(
                    minHeight: 500
                ),
               // height: 40,
                child: quill.QuillEditor.basic(
                  controller: _quillController,
                  readOnly: false,
                ),
              ).pad(left: 15,right: 15,bottom: 15),
            ],
          ),
        ),
      ),
    );
  }
}
