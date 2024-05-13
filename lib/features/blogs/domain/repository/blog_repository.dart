import 'dart:io';

import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/blogs/domain/entities/blog.dart';

abstract interface class BlogRepository {
  ResultVoid uploadBlog({
    // required String id,
    required String userId,
    required File image,
    required String title,
    required String content,
    required List<String> topics,
  });

  ResultFuture<List<Blog>> fetchBlogs();

  ResultFuture<Blog> getBlogById({required String id});
}
