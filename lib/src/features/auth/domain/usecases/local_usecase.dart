import 'package:idea_notes/src/features/auth/domain/repositories/local/storage_repo.dart';
import 'package:flutter/material.dart';
import '../entities/user_model.dart';

class LocalUseCase{
  final StorageRepo repo;
  LocalUseCase(this.repo);

  ///user
  Future<void> saveUser(UserModel user)async{
    return repo.saveUser(user);
  }
  Future<UserModel?> readUser()async{
    return await repo.readUser();
  }
  Future<void> deleteUser()async{
    return repo.deleteUser();
  }

  ///theme
  Future<void> saveTheme(int theme)async{
    return repo.saveTheme(theme);
  }
  Future<int?> readTheme()async{
    return repo.readTheme();
  }

  ///language
  Future<void> saveLocale(Locale locale)async{
    return repo.saveLocale(locale);
  }
  Future<Locale?> readLocale()async{
    return repo.readLocale();
  }
}