import 'package:flutter_test/flutter_test.dart';
import 'package:idea_notes/src/features/auth/data/datasources/user/user.dart';
import 'package:idea_notes/src/features/auth/domain/entities/user_model.dart';
import 'package:idea_notes/src/features/auth/domain/repositories/remote/auth_repository.dart';
import 'package:idea_notes/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:idea_notes/src/features/auth/domain/usecases/signup_usecase.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {
  @override
  Future<void> forgotPassword({required String email}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<UserModel> logIn(
      {required String userName, required String password}) async {
    User user=
      User(
        objectId: 'objectId',
        username: userName,
        createdAt: DateTime.now(),
        email: 'email', accountName: "accountName");
    print("USERS IS $user");
    return user;
  }

  @override
  Future<User> signUp(
      {required String userName,
      required String password,
      required String email, required String accountName}) async {
    return
      User(
        objectId: 'objectId',
        username: userName,
        createdAt: DateTime.now(),
        email: email,
        accountName: accountName);
  }
}

void main() {
  // final userRepository = MockAuthRepository();
  late LogInUseCase logInUseCase;
  late MockAuthRepository mockAuthRepository;
  setUpAll(() {
    mockAuthRepository = MockAuthRepository();
    logInUseCase = LogInUseCase(mockAuthRepository);
  });

  test('Log In state',() async{
    final result = await logInUseCase.call(
      userName: 'Stray Kids',
      password: 'first class final',
    );
    expect(result,  isA<User>());
  });


  test('LogIn should return UserModel', () async {
    UserModel user = User(
        objectId: 'objectId',
        username: "userName",
        createdAt: DateTime.now(),
        email: 'email', accountName: "accountName");

    when(mockAuthRepository.logIn(
      userName: 'Stray Kids',
      password: 'first class final',
    )).thenAnswer((_) => Future.value(user));

    final result = await logInUseCase.call(
      userName: 'Stray Kids',
      password: 'first class final',
    );

    verify(mockAuthRepository.logIn(
      userName: 'Stray Kids',
      password: 'first class final',
    )).called(1);

    // verify(logInUseCase.call(
    //   userName: 'Stray Kids',
    //   password: 'first class final',
    // )).called(1);
    expect(result,  isA<User>());
    });

    test('Sign Up should return UserModel', () async{
      UserModel userModel;
      verify(mockAuthRepository.signUp(
          userName: 'Stray Kids',
          password: 'first class final',
          email: 'skz@gmail.com',
          accountName: 'skz'
      )).called(1);
      userModel = await SignUpUseCase(mockAuthRepository).call(
        userName: 'Stray Kids',
        password: 'first class final',
        email: 'skz@gmail.com',
        accountName: 'skz',
      );
      when(await mockAuthRepository.signUp(
          userName: 'Stray Kids',
          password: 'first class final',
          email: 'skz@gmail.com',
          accountName: 'skz'
      )).thenAnswer((_) => userModel as User);
      expect(userModel, isA<User>());
    });
  }