import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/blogs/domain/usecases/fetch_blogs.dart';

import '../../domain/entities/blog.dart';
import '../../domain/usecases/fetch_blog_by_id.dart';
import '../../domain/usecases/upload_blog.dart' as use_case;

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final use_case.UploadBlog _uploadBlogUseCase;
  final FetchBlogs _fetchBlogs;
  final FetchBlogById _blogsById;

  BlogBloc(
      {required use_case.UploadBlog uploadBlogUseCase,
      required FetchBlogs fetchBlogs,
      required FetchBlogById fetchBlogById})
      : _uploadBlogUseCase = uploadBlogUseCase,
        _fetchBlogs = fetchBlogs,
        _blogsById = fetchBlogById,
        super(const BlogState()) {
    on<BlogEvent>(
        (event, emit) => emit(state.copyWith(status: BlogStatus.loading)));
    on<UploadBlog>(_uploadBlog);
    on<ReceiveBlogs>(_receiveBlogs);
    on<GetBlogById>(_getById);
  }

  _uploadBlog(UploadBlog event, Emitter<BlogState> emit) async {
    final response = await _uploadBlogUseCase(use_case.UploadBlogParams(
        userId: event.id,
        image: event.image,
        title: event.title,
        content: event.content,
        topics: event.topics));

    response.fold(
      (l) => emit(state.copyWith(error: l.message)),
      (r) => emit(
        state.copyWith(status: BlogStatus.uploadSuccess),
      ),
    );
  }

  _receiveBlogs(ReceiveBlogs event, Emitter<BlogState> emit) async {
    final resp = await _fetchBlogs(NoParams());

    resp.fold(
        (l) => emit(state.copyWith(error: l.message)),
        (r) =>
            emit(state.copyWith(status: BlogStatus.getSuccess, blogList: r)));
  }

  _getById(GetBlogById event, Emitter<BlogState> emit) async {
    final resp = await _blogsById(event.id);

    resp.fold(
      (l) => emit(state.copyWith(error: l.message)),
      (r) => emit(
        state.copyWith(status: BlogStatus.getByIdSuccess, blog: r),
      ),
    );
  }
}
