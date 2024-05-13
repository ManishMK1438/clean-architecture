import 'dart:io';

import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/blogs/data/datasources/blog_firebase_datasource.dart';
import 'package:clean_art/features/blogs/data/models/blog_model.dart';
import 'package:clean_art/features/blogs/domain/entities/blog.dart';
import 'package:clean_art/features/blogs/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogFirebaseDataSource _dataSource;
  final _uuid = const Uuid();
  BlogRepositoryImpl({required BlogFirebaseDataSource dataSource})
      : _dataSource = dataSource;

  @override
  ResultVoid uploadBlog({
    required String userId,
    required File image,
    required String title,
    required String content,
    required List<String> topics,
  }) async {
    try {
      BlogModel _model = BlogModel(
        id: _uuid.v1(),
        userId: userId,
        imageUrl: "imageUrl",
        title: title,
        content: content,
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final imgResp =
          await _dataSource.uploadImage(blogModel: _model, file: image);
      _model = _model.copyWith(imageUrl: imgResp);
      final response = await _dataSource.uploadBlog(blogModel: _model);
      return Right(response);
    } on ServerError catch (e) {
      return Left(ServerError(message: e.message));
    }
  }

  @override
  ResultFuture<List<Blog>> fetchBlogs() async {
    try {
      final resp = await _dataSource.getBlogs();
      return Right(resp);
    } on ServerError catch (e) {
      return Left(ServerError(message: e.message));
    }
  }

  @override
  ResultFuture<Blog> getBlogById({required String id}) async {
    try {
      final resp = await _dataSource.getBlogById(id: id);
      return Right(resp);
    } on ServerError catch (e) {
      return Left(ServerError(message: e.message));
    }
  }
}
