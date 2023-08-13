import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idea_notes/src/features/auth/data/repositories/local/storage_repo_impl.dart';
import 'package:idea_notes/src/features/auth/domain/usecases/local_usecase.dart';
import 'package:idea_notes/src/features/auth/domain/usecases/login_usecase.dart';
import '../../../../helpers/error_handling/unknown_exception.dart';
import '../../../../helpers/utils/utility.dart';
import '../../data/datasources/user/user.dart';
import '../../data/repositories/remote/auth_repository_impl.dart';

// final hidePasswordProvider = StateProvider<bool?>(
//   (ref) => false,
// );

final logInControllerProvider = ChangeNotifierProvider((ref) {
  return LogInController(ref.container);
});

class LogInController extends ChangeNotifier {
  final ProviderContainer container;

  LogInController(this.container);

  Future<User?> logIn(
      {required String userName, required String password}) async {
    LogInUseCase useCase = LogInUseCase(container.read(authRepositoryProvider));
    Utility.showLoader(show: true);
    try {
      User user = await useCase.call(userName: userName, password: password) as User;
      LocalUseCase localUseCase = LocalUseCase(container.read(storageRepoImplProvider));
      localUseCase.saveUser(user);
      Utility.showLoader(show: false);
      
      return user;
    } on UnknownException catch (e) {
      Utility.showLoader(show: false);
      Utility.showToast(message: e.message.toString(), isError: true);
    }
    return null;
  }
}
