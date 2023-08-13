import 'package:flutter/material.dart';
import '../../entities/user_model.dart';

abstract class StorageRepo{
  ///user
  Future<void> saveUser(UserModel user);
  Future<UserModel?> readUser();
  Future<void> deleteUser();

  ///theme
  Future<void> saveTheme(int theme);
  Future<int?> readTheme();

  ///language
  Future<void> saveLocale(Locale locale);
  Future<Locale?> readLocale();
}