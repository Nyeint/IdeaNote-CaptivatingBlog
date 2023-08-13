import '../entities/user_model.dart';
import '../repositories/remote/auth_repository.dart';

class UpdateUseCase{
  final AuthRepository repository;
  UpdateUseCase(this.repository);

  Future<UserModel> changeAccountName({required String accountName}){
    return repository.changeAccountName(accountName: accountName);
  }
}