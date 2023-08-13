import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/i18n/strings.g.dart';
import 'package:idea_notes/src/features/blog/data/datasources/blog/blog.dart';
import 'package:idea_notes/src/features/blog/presentation/providers/blog_provider.dart';
import '../../../../core/core.dart';
import '../../../../helpers/utils/utility.dart';
import '../../../../route/route_names.dart';
import '../../../auth/presentation/widgets/custom_button.dart';
import '../../../auth/presentation/widgets/custom_textform_field.dart';
import '../providers/check_state_provider.dart';
import '../widgets/custom_app_bar.dart';

class EditBlogView extends ConsumerStatefulWidget {
  Blog blog;
  EditBlogView({Key? key, required this.blog}) : super(key: key);

  @override
  EditBlogViewState createState() => EditBlogViewState();
}

class EditBlogViewState extends ConsumerState<EditBlogView> {
  final TextEditingController _titleController = TextEditingController();
  quill.QuillController quillController = quill.QuillController.basic();

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      //final blog=ref.watch(blogProvider).blogDetail;

      quillController=quill.QuillController(
        document: quill.Document.fromJson(jsonDecode(widget.blog.content??'')),
        selection: const TextSelection.collapsed(offset: 0),
      );
      _titleController.text=widget.blog.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    final translate = Translations.of(context).blog;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          text: 'Edit Blog',
            onTap: (){
              ref.read(tabIndex.notifier).state = 2;
              context.goNamed(RouteNames.account);
            },
          hasWidget: true,
          widget:
              CustomizedButton(
                  name: translate.save,
                  width: 100,
                  onTap: () async {
                    if(_titleController.text.isEmpty){
                      Utility.showToast(message: translate.enter_data(data: translate.title),isError: true);
                    }
                    else if(quillController.document.isEmpty()){
                      Utility.showToast(message: translate.enter_data(data: translate.content),isError: true);
                    }
                    else{
                      String data= jsonEncode(quillController.document.toDelta().toJson());
                      await ref.read(blogProvider).updateBlog(objectId: widget.blog.objectId, title: _titleController.text, content: data).then((value){
                        ref.read(tabIndex.notifier).state = 2;
                        context.goNamed(RouteNames.account);
                      });
                    }
                  })
        ) ,
        backgroundColor: Colors.grey[200],
        body:
        SingleChildScrollView(
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
                //fillColor: ColorResources.background,
              ).pad(left: 15,right: 15,bottom: 15),

              Text(translate.content,
                style: k2dRegular.copyWith(fontSize: 17,color: ColorResources.textPrimary),).pad(left: 15,right: 15,bottom: 10,top: 10),
              quill.QuillToolbar.basic(controller: quillController,
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
                  controller: quillController,
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
