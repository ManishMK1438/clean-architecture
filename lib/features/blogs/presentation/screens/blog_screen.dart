import 'package:clean_art/features/blogs/presentation/screens/view_blog_screen.dart';
import 'package:clean_art/features/blogs/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/exports.dart';
import '../bloc/blog_bloc.dart';
import 'add_new_blog_screen.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  final _appStrings = AppStrings();

  final _appNavigation = AppNavigation();

  final _appStyles = AppStyles();

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(ReceiveBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_appStrings.blogs),
          actions: [
            IconButton(
              onPressed: () {
                _appNavigation.push(
                    context: context, screen: const AddNewBlogScreen());
              },
              icon: const Icon(CupertinoIcons.add),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: BlocBuilder<BlogBloc, BlogState>(
            builder: (context, state) {
              if (state.status == BlogStatus.loading) {
                return const AppLoader();
              }
              if (state.status == BlogStatus.failure) {
                return Center(child: AppErrorWidget(error: state.error));
              }
              if (state.status == BlogStatus.getSuccess ||
                  state.status == BlogStatus.getByIdSuccess) {
                return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: appPadding),
                    itemBuilder: (cts, index) => InkWell(
                        onTap: () {
                          context
                              .read<BlogBloc>()
                              .add(GetBlogById(id: state.blogList[index].id));
                          _appNavigation.push(
                              context: context, screen: ViewBlogScreen());
                        },
                        child: BlogCard(blog: state.blogList[index])),
                    separatorBuilder: (ctx, ind) => Gap(20.h),
                    itemCount: state.blogList.length);
              }
              return const SizedBox();
            },
          ),
        ));
  }
}
