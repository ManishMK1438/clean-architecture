import 'package:clean_art/core/exports.dart';

class Blog extends Equatable {
  final String id;
  final String userId;
  final String imageUrl;
  final String title;
  final String content;
  final List<String> topics;
  final DateTime updatedAt;

  const Blog({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.topics,
    required this.updatedAt,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, userId, imageUrl, title, content, topics, updatedAt];
}
