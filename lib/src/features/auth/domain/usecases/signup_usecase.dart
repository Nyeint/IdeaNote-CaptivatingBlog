import '../entities/user_model.dart';
import '../repositories/remote/auth_repository.dart';

class SignUpUseCase{
  final AuthRepository repository;
  SignUpUseCase(this.repository);

  Future<UserModel> call({required String userName,required String password,required String email, required String accountName}){
    return repository.signUp(userName: userName, password: password,email: email,accountName: accountName);
  }
}