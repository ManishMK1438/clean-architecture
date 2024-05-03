import 'package:clean_art/features/blogs/domain/entities/blog.dart';

class BlogModel extends Blog {
  const BlogModel({
    required super.id,
    required super.userId,
    required super.imageUrl,
    required super.title,
    required super.content,
    required super.topics,
    required super.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'imageUrl': imageUrl,
      'title': title,
      'content': content,
      'topics': topics,
      'updatedAt': updatedAt
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
        id: map['id'] as String,
        userId: map['userId'] as String,
        imageUrl: map['imageUrl'] as String,
        title: map['title'] as String,
        content: map['content'] as String,
        topics: map['topics'] ?? [],
        updatedAt: map['updatedAt']);
  }

  BlogModel copyWith({
    String? id,
    String? userId,
    String? imageUrl,
    String? title,
    String? content,
    List<String>? topics,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      content: content ?? this.content,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
