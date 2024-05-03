part of 'blog_bloc.dart';

sealed class BlogState extends Equatable {
  const BlogState();
}

final class BlogInitial extends BlogState {
  @override
  List<Object> get props => [];
}

final class BlogLoading extends BlogState {
  @override
  List<Object> get props => [];
}

final class BlogSuccess extends BlogState {
  @override
  List<Object> get props => [];
}

final class BlogFailure extends BlogState {
  final String error;

  @override
  List<Object> get props => [error];

  const BlogFailure({
    required this.error,
  });
}
