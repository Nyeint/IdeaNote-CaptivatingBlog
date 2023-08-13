import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idea_notes/src/features/auth/data/repositories/local/storage_repo_impl.dart';

import '../../domain/usecases/local_usecase.dart';

final settingsProvider = ChangeNotifierProvider((ref) =>
    SettingsController(ref.container)
);

class SettingsController extends ChangeNotifier{
  final ProviderContainer container;
  SettingsController(this.container);
  int? themeData=0;
  Locale? locale;

  saveTheme(int theme){
    LocalUseCase localUseCase = LocalUseCase(container.read(storageRepoImplProvider));
    themeData=theme;
    notifyListeners();
    localUseCase.saveTheme(theme);
    // container.read(storageRepoImplProvider).saveTheme(theme);
    notifyListeners();
  }

  saveLocale(Locale localeData){
    LocalUseCase localUseCase = LocalUseCase(container.read(storageRepoImplProvider));
    locale=localeData;
    localUseCase.saveLocale(localeData);
    notifyListeners();
  }

  readTheme()async{
    LocalUseCase localUseCase = LocalUseCase(container.read(storageRepoImplProvider));
    themeData=await localUseCase.readTheme();
    notifyListeners();
  }
  readLocale()async{
    LocalUseCase localUseCase = LocalUseCase(container.read(storageRepoImplProvider));
    locale = await localUseCase.readLocale();
    notifyListeners();
  }
}