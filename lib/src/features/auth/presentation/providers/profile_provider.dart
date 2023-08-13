import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idea_notes/src/features/auth/data/repositories/local/storage_repo_impl.dart';
import 'package:idea_notes/src/features/auth/domain/usecases/local_usecase.dart';
import 'package:idea_notes/src/features/auth/domain/usecases/update_usecase.dart';
import '../../../../helpers/error_handling/unknown_exception.dart';
import '../../../../helpers/utils/utility.dart';
import '../../data/datasources/user/user.dart';
import '../../data/repositories/remote/auth_repository_impl.dart';


final profileProvider = ChangeNotifierProvider((ref) {
  return ProfileController(ref.container);
});

class ProfileController extends ChangeNotifier {
  final ProviderContainer container;
  ProfileController(this.container);
  User? user;
  bool isProfileLoading=false;

  Future<void> getUser() async {
    isProfileLoading=true;
    Utility.showLoader(show: true);
    try {
      LocalUseCase localUseCase = LocalUseCase(container.read(storageRepoImplProvider));
      user = await localUseCase.readUser() as User?;
      Utility.showLoader(show: false);
      isProfileLoading=false;
      notifyListeners();

    } on UnknownException catch (e) {
      Utility.showLoader(show: false);
      isProfileLoading=false;
      Utility.showToast(message: e.message.toString(), isError: true);
    }
  }
  Future<void> changeAccountName({required String accountName}) async{
    Utility.showLoader(show: true);
    try{
      UpdateUseCase useCase = UpdateUseCase(container.read(authRepositoryProvider));
      User userData = await useCase.changeAccountName(accountName: accountName) as User;
      LocalUseCase localUseCase = LocalUseCase(container.read(storageRepoImplProvider));
      localUseCase.saveUser(userData);
      user=userData;
      notifyListeners();
      Utility.showLoader(show: false);
      Utility.showToast(message: 'successfully updated');
    }on UnknownException catch (e) {
      Utility.showLoader(show: false);
      Utility.showToast(message: e.message.toString(), isError: true);
    }
  }
}
