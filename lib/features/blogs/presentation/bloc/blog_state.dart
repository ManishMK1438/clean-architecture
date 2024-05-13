part of 'blog_bloc.dart';

enum BlogStatus { loading, uploadSuccess, getSuccess, getByIdSuccess, failure }

final class BlogState extends Equatable {
  final BlogStatus status;
  final List<Blog> blogList;
  final Blog? blog;
  final String error;
  const BlogState(
      {this.blogList = const <Blog>[],
      this.status = BlogStatus.loading,
      this.blog,
      this.error = ""});

  @override
  // TODO: implement props
  List<Object?> get props => [status, blog, blogList, error];

  BlogState copyWith({
    BlogStatus? status,
    List<Blog>? blogList,
    Blog? blog,
    String? error,
  }) {
    return BlogState(
      status: status ?? this.status,
      blogList: blogList ?? this.blogList,
      blog: blog ?? this.blog,
      error: error ?? this.error,
    );
  }
}

/*final class BlogInitial extends BlogState {
  @override
  List<Object> get props => [];
}

final class BlogLoading extends BlogState {
  @override
  List<Object> get props => [];
}

final class UploadBlogSuccess extends BlogState {
  @override
  List<Object> get props => [];
}

final class FetchBlogsSuccess extends BlogState {
  final List<Blog> blogsList;
  const FetchBlogsSuccess({required this.blogsList});
  @override
  List<Object> get props => [blogsList];
}

final class FetchByIdBlogsSuccess extends BlogState {
  final Blog blog;

  const FetchByIdBlogsSuccess({required this.blog});
  @override
  List<Object> get props => [blog];
}

final class BlogFailure extends BlogState {
  final String error;

  @override
  List<Object> get props => [error];

  const BlogFailure({
    required this.error,
  });
}*/
