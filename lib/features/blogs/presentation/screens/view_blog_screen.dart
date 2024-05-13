import 'package:clean_art/features/blogs/domain/entities/blog.dart';
import 'package:clean_art/features/blogs/presentation/widgets/topics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/exports.dart';
import '../bloc/blog_bloc.dart';

class ViewBlogScreen extends StatelessWidget {
  ViewBlogScreen({super.key});

  final _appStrings = AppStrings();
  final _appStyle = AppStyles();

  Widget _header({required Blog blog}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          blog.title,
          style: _appStyle.normal(size: 22, weight: FontWeight.bold),
        ),
        Gap(6.h),
        Text(
          timeAgo(dateTime: blog.updatedAt),
          style: _appStyle.normal(
              size: 16, weight: FontWeight.bold, color: Colors.grey),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appStrings.details),
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state.status == BlogStatus.loading) {
            return const AppLoader();
          }
          if (state.status == BlogStatus.failure) {
            return AppErrorWidget(error: state.error);
          }
          if (state.status == BlogStatus.getByIdSuccess) {
            return Padding(
              padding: const EdgeInsets.all(appPadding),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetImgWidget(url: state.blog!.imageUrl),
                    Gap(20.h),
                    Topics(topics: state.blog!.topics),
                    Gap(20.h),
                    _header(blog: state.blog!),
                    Gap(20.h),
                    Text(
                      state.blog!.content,
                      style: _appStyle.normal(size: 16),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
