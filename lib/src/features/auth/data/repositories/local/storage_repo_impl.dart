import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/auth/domain/entities/user_model.dart';
import 'package:idea_notes/src/features/auth/domain/repositories/local/storage_repo.dart';
import '../../datasources/user/user.dart';

final storageRepoImplProvider = Provider((ref) => StorageRepoImpl(ref.container));

// final themeModeProvider = StateProvider<int>((ref) => 0);

class StorageRepoImpl implements StorageRepo {
  final ProviderContainer container;
  StorageRepoImpl(this.container);

  @override
  Future<void> deleteUser() async {
    final sharedPrefsHelper = container.read(sharedPrefsHelperProvider);
    await sharedPrefsHelper.remove(StorageKeys.user.name);
  }

  @override
  Future<Locale?> readLocale() async {
    final sharedPrefsHelper = container.read(sharedPrefsHelperProvider);
    String? locale = await sharedPrefsHelper.get<String>(StorageKeys.locale.name);
    return Locale(locale??'en');
  }

  @override
  Future<int?> readTheme() async {
    final sharedPrefsHelper = container.read(sharedPrefsHelperProvider);
    return await sharedPrefsHelper.get<int>(StorageKeys.theme.name);
  }

  @override
  Future<UserModel?> readUser() async {
    final sharedPrefsHelper = container.read(sharedPrefsHelperProvider);
    String? user = await sharedPrefsHelper.get<String>(StorageKeys.user.name);
    if(user == null){
      return null;
    }
    else{
      Map<String, dynamic> userJson = jsonDecode(user);
      return User.fromJson(userJson);
    }
  }

  @override
  Future<void> saveLocale(locale) async {
    final sharedPrefsHelper = container.read(sharedPrefsHelperProvider);
    await sharedPrefsHelper.set(StorageKeys.locale.name, locale.toString());
  }

  @override
  Future<void> saveTheme(theme) async {
    final sharedPrefsHelper = container.read(sharedPrefsHelperProvider);
    await sharedPrefsHelper.set(StorageKeys.theme.name, theme);
  }

  @override
  Future<void> saveUser(UserModel userModel) async {
    final sharedPrefsHelper = container.read(sharedPrefsHelperProvider);
    User user = userModel as User;
    await sharedPrefsHelper.set(
        StorageKeys.user.name.toString(), jsonEncode(user.toJson()));
  }
}

enum StorageKeys {
  user,
  theme,
  locale,
}

