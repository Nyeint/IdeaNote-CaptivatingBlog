import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idea_notes/src/features/auth/data/repositories/remote/auth_repository_impl.dart';
import 'package:idea_notes/src/features/auth/domain/usecases/signup_usecase.dart';
import '../../../../helpers/error_handling/unknown_exception.dart';
import '../../../../helpers/utils/utility.dart';
import '../../data/datasources/user/user.dart';

final signUpControllerProvider = ChangeNotifierProvider((ref) =>
    SignUpController(ref.read(authRepositoryProvider)));

class SignUpController extends ChangeNotifier{
  final AuthRepositoryImpl repoImpl;
  SignUpController(this.repoImpl);

  Future<User?> signUp(
      {required String userName, required String password,required String email, required String accountName}) async{
    SignUpUseCase useCase=SignUpUseCase(repoImpl);
    Utility.showLoader(show: true);
    try{
      User user =await useCase.call(userName: userName, password: password,email: email, accountName: accountName) as User;
      Utility.showLoader(show: false);
      Utility.showToast(message:'Account is successfully created');
      return user;
      // await useCase.call(userName: userName, password: password,email: email, accountName: accountName).then(
      //     (value){
      //       Utility.showLoader(show: false);
      //       Utility.showToast(message:'Account is successfully created');
      //     } );
    }on UnknownException catch(e){
      Utility.showLoader(show: false);
      Utility.showToast(message: e.message.toString(), isError: true);
    }
    return null;
  }
}