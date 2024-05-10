import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/blogs/domain/usecases/fetch_blogs.dart';

import '../../domain/entities/blog.dart';
import '../../domain/usecases/upload_blog.dart' as use_case;

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final use_case.UploadBlog _uploadBlogUseCase;
  final FetchBlogs _fetchBlogs;
  BlogBloc(
      {required use_case.UploadBlog uploadBlogUseCase,
      required FetchBlogs fetchBlogs})
      : _uploadBlogUseCase = uploadBlogUseCase,
        _fetchBlogs = fetchBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<UploadBlog>(_uploadBlog);
    on<ReceiveBlogs>(_receiveBlogs);
  }

  _uploadBlog(UploadBlog event, Emitter<BlogState> emit) async {
    final response = await _uploadBlogUseCase(use_case.UploadBlogParams(
        userId: event.id,
        image: event.image,
        title: event.title,
        content: event.content,
        topics: event.topics));

    response.fold(
      (l) => emit(BlogFailure(error: l.message)),
      (r) => emit(
        UploadBlogSuccess(),
      ),
    );
  }

  _receiveBlogs(ReceiveBlogs event, Emitter<BlogState> emit) async {
    final resp = await _fetchBlogs(NoParams());

    resp.fold((l) => emit(BlogFailure(error: l.message)),
        (r) => emit(FetchBlogsSuccess(blogsList: r)));
  }
}
