part of 'blog_bloc.dart';

sealed class BlogEvent extends Equatable {
  const BlogEvent();
}

class UploadBlog extends BlogEvent {
  final String id;
  final File image;
  final String title;
  final String content;
  final List<String> topics;

  @override
  // TODO: implement props
  List<Object?> get props => [id, image, title, content, topics];

  const UploadBlog({
    required this.id,
    required this.image,
    required this.title,
    required this.content,
    required this.topics,
  });
}

class ReceiveBlogs extends BlogEvent {
  @override
  List<Object?> get props => [];
}

class GetBlogById extends BlogEvent {
  final String id;
  const GetBlogById({required this.id});
  @override
  List<Object?> get props => [id];
}
