import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/upload_blog.dart' as use_case;

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final use_case.UploadBlog _uploadBlogUseCase;

  BlogBloc({required use_case.UploadBlog uploadBlogUseCase})
      : _uploadBlogUseCase = uploadBlogUseCase,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => BlogLoading());
    on<UploadBlog>(_uploadBlog);
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
        BlogSuccess(),
      ),
    );
  }
}
