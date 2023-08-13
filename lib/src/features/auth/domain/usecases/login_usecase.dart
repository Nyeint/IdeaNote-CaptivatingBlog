import '../entities/user_model.dart';
import '../repositories/remote/auth_repository.dart';

class LogInUseCase{
  final AuthRepository repository;
  LogInUseCase(this.repository);

  Future<UserModel> call({required String userName, required String password}) async{
    return repository.logIn(userName: userName, password: password);
  }
}