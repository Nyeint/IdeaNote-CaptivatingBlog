import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idea_notes/src/features/auth/data/repositories/remote/auth_repository_impl.dart';
import 'package:idea_notes/src/features/auth/domain/usecases/forgot_password_usecase.dart';
import '../../../../helpers/error_handling/unknown_exception.dart';
import '../../../../helpers/utils/utility.dart';

final forgotPasswordControllerProvider = ChangeNotifierProvider((ref) =>
    ForgotPasswordController(ref.read(authRepositoryProvider)));

class ForgotPasswordController extends ChangeNotifier{
  final AuthRepositoryImpl repoImpl;
  ForgotPasswordController(this.repoImpl);

  Future<void> forgotPassword({required String email}) async{
    ForgotPasswordUseCase useCase=ForgotPasswordUseCase(repoImpl);
    Utility.showLoader(show: true);
    try{
      await useCase.call(email: email).then((value){
        Utility.showLoader(show: false);
        Utility.showToast(message:'successfully sent reset password instructions', isError: true);
      });
    }on UnknownException catch(e){
      Utility.showLoader(show: false);
      Utility.showToast(message: e.message.toString(), isError: true);
    }
  }
}