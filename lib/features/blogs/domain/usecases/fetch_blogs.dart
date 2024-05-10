import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/blogs/domain/entities/blog.dart';
import 'package:clean_art/features/blogs/domain/repository/blog_repository.dart';

class FetchBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository _repository;
  FetchBlogs({required BlogRepository repository}) : _repository = repository;

  @override
  ResultFuture<List<Blog>> call(NoParams params) async {
    return await _repository.fetchBlogs();
  }
}
