import '../entities/blog_model.dart';

abstract class BlogRepository{
  Future<List<BlogModel>> viewAllBlog({required int limit});
  Future<List<BlogModel>> viewMyBlog({required String userId, required int limit});
  Future<BlogModel> viewBlogDetail({required String objectId});
  Future<void> createBlog({required String title, required String content, required String userId});
  Future<void> deleteBlog({required String id});
  Future<void> updateBlog({required String objectId, required String title, required String content});
  Future<void> voteBlog({required String objectId});
  Future<void> removeVote({required String objectId});
}