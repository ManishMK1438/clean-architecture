import 'dart:io';

import 'package:clean_art/core/exports.dart';

abstract interface class BlogRepository {
  ResultVoid uploadBlog({
    // required String id,
    required String userId,
    required File image,
    required String title,
    required String content,
    required List<String> topics,
  });
}
