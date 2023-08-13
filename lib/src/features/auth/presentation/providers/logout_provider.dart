import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idea_notes/src/features/auth/data/repositories/remote/auth_repository_impl.dart';
import 'package:idea_notes/src/features/auth/domain/usecases/local_usecase.dart';
import 'package:idea_notes/src/features/auth/domain/usecases/logout_usecase.dart';
import '../../../../helpers/error_handling/unknown_exception.dart';
import '../../../../helpers/utils/utility.dart';
import '../../data/repositories/local/storage_repo_impl.dart';

final logOutControllerProvider = ChangeNotifierProvider((ref) =>
    LogOutController(
      ref.container
    ));

class LogOutController extends ChangeNotifier{
  //final AuthRepositoryImpl repoImpl;
  final ProviderContainer container;
  LogOutController(this.container);

  Future<void> logOut() async{
    LogOutUseCase useCase=LogOutUseCase(container.read(authRepositoryProvider));
    LocalUseCase localUseCase=LocalUseCase(container.read(storageRepoImplProvider));
    Utility.showLoader(show: true);
    try{
      await useCase.call().then((value) async {
        localUseCase.deleteUser();
        Utility.showLoader(show: false);
      });
    }on UnknownException catch(e){
      Utility.showLoader(show: false);
      Utility.showToast(message: e.message.toString(), isError: true);
    }
  }
}