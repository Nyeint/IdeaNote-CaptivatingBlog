import '../repositories/remote/auth_repository.dart';

class ForgotPasswordUseCase{
  final AuthRepository repository;
  ForgotPasswordUseCase(this.repository);

  Future<void> call({required String email}){
    return repository.forgotPassword(email: email);
  }
}