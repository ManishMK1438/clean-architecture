import 'dart:io';

import 'package:clean_art/core/exports.dart';

import '../repository/blog_repository.dart';

class UploadBlog implements UseCase<void, UploadBlogParams> {
  final BlogRepository _repository;

  UploadBlog({required BlogRepository repository}) : _repository = repository;

  @override
  ResultFuture<void> call(UploadBlogParams params) async {
    return await _repository.uploadBlog(
      userId: params.userId,
      image: params.image,
      title: params.title,
      content: params.content,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String userId;
  final File image;
  final String title;
  final String content;
  final List<String> topics;

  const UploadBlogParams({
    required this.userId,
    required this.image,
    required this.title,
    required this.content,
    required this.topics,
  });
}
