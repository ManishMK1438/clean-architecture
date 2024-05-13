import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/blogs/domain/entities/blog.dart';

import '../repository/blog_repository.dart';

class FetchBlogById implements UseCase<Blog, String> {
  final BlogRepository _repository;
  FetchBlogById({required BlogRepository repository})
      : _repository = repository;

  @override
  ResultFuture<Blog> call(String params) async {
    return await _repository.getBlogById(id: params);
  }
}
/*

class FetchByIdParams{
  final String id;
  FetchByIdParams({required this.id});
}*/
