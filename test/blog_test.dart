import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idea_notes/i18n/strings.g.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/auth/data/datasources/user/user.dart';
import 'package:idea_notes/src/features/blog/data/datasources/blog/blog.dart';
import 'package:idea_notes/src/features/blog/domain/entities/blog_model.dart';
import 'package:idea_notes/src/features/blog/domain/repositories/blog_repository.dart';
import 'package:idea_notes/src/features/blog/domain/usecases/view_blog_usecase.dart';
import 'package:idea_notes/src/features/blog/presentation/screens/view_blog.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockCreateBlogUseCase extends Mock{
  final MockBlogRepository repository;
  MockCreateBlogUseCase(this.repository);
  Future<void> createBlog({required String title, required String content, required String userId}){
    return repository.createBlog(title: title, content: content, userId: userId);
  }
}

class MockBlogRepository extends Mock implements BlogRepository{
  @override
  Future<void> createBlog({required String title, required String content, required String userId}) async {
    print("Creation blog is success");
  }

  @override
  Future<void> deleteBlog({required String id}) {
    // TODO: implement deleteBlog
    throw UnimplementedError();
  }

  @override
  Future<void> removeVote({required String objectId}) {
    // TODO: implement removeVote
    throw UnimplementedError();
  }

  @override
  Future<void> updateBlog({required String objectId, required String title, required String content}) {
    // TODO: implement updateBlog
    throw UnimplementedError();
  }

  @override
  Future<List<BlogModel>> viewAllBlog({required int limit}) async{
    print("GEREKJRK DATA");
    // try {
    //   final QueryBuilder<ParseObject> parseQuery =
    //   QueryBuilder<ParseObject>(ParseObject('blog'))
    //     ..includeObject(['user']);
    //   // ..excludeKeys(['ACL','voter','content']);
    //   parseQuery.setLimit(limit);
    //   final ParseResponse response = await parseQuery.query();
    //
    //   /// get relation by id
    //   if (!response.success) {
    //     throw UnknownException(response.error!.message.toString());
    //   } else {
    //     if (response.results == null) {
    //       return <Blog>[];
    //     }
    //     List<Blog> blogList = [];
    //     for (var i = 0; i < response.results!.length; i++) {
    //       final voterRelation =
    //       response.results![i].get<ParseRelation<ParseObject>>('voter');
    //       final voterList = await voterRelation.getQuery().find();
    //       blogList.add(
    //           Blog.fromParseObject(response.results![i], voterList));
    //     }
    //     return blogList;
    //   }
    // } catch (e) {
    //   throw UnknownException(e.toString());
    // }

    User user=User(
        objectId: "objectId",
        createdAt: DateTime.now(),
        username: "username",
        accountName: "accountName");
    List<User> voter=[
      User(
        objectId: "objectId",
        createdAt: DateTime.now(),
        username: "username",
        accountName: "accountName")];
    Blog blog= Blog(
        objectId: "objectId",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        title: "title",
        content: "content",
        user: user,
        voter: voter);
    List<Blog> blogList = [];
    blogList.add(blog);
    return blogList;
  }

  @override
  Future<BlogModel> viewBlogDetail({required String objectId}) {
    // TODO: implement viewBlogDetail
    throw UnimplementedError();
  }

  @override
  Future<List<BlogModel>> viewMyBlog({required String userId, required int limit}) {
    // TODO: implement viewMyBlog
    throw UnimplementedError();
  }

  @override
  Future<void> voteBlog({required String objectId}) {
    // TODO: implement voteBlog
    throw UnimplementedError();
  }
}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main(){
  late MockCreateBlogUseCase createBlogUseCase;
  late MockBlogRepository mockBlogRepository;
  late ViewBlogUseCase viewBlogUseCase;
  MockSharedPreferences sharedPreferences= MockSharedPreferences();
  setUp(() {
    mockBlogRepository = MockBlogRepository();
    createBlogUseCase = MockCreateBlogUseCase(mockBlogRepository);
    viewBlogUseCase = ViewBlogUseCase(mockBlogRepository);
  });

  testWidgets(
      "Blog List Widgets",
          (widgetTester) async {
        var result = await viewBlogUseCase.viewAllBlog(limit: 1);
        await widgetTester.pumpWidget(
                ProviderScope(
                    overrides: [
                      sharedPrefsProvider.overrideWithValue(sharedPreferences),
                    ],
                    child: TranslationProvider(
                        child: const Directionality(
                            textDirection: TextDirection.ltr,
                        child: ViewBlog()))));
        expect(find.text("No Blog"), findsOneWidget);
        // verifyNever(mockBlogRepository.viewAllBlog(limit: 1));
        // verify(viewBlogUseCase.viewAllBlog(limit: 1)).called(1);
        // await widgetTester.tap(find.text("About the data"));
        // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

  test('Create Blog Case',() async{
    createBlogUseCase.createBlog(
        title: "title",
        content: "content",
        userId: "userId");
    verify(createBlogUseCase.createBlog(
        title: "title",
        content: "content",
        userId: "userId")).called(1);
  });
}