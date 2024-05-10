import 'package:clean_art/features/blogs/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/exports.dart';
import '../bloc/blog_bloc.dart';
import 'add_new_blog_screen.dart';

class BlogsScreen extends StatefulWidget {
  BlogsScreen({super.key});

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
                // FirebaseAuth.instance.signOut();
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
              if (state is BlogLoading) {
                return const AppLoader();
              }
              if (state is BlogFailure) {
                return Center(child: AppErrorWidget(error: state.error));
              }
              if (state is FetchBlogsSuccess) {
                return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: appPadding),
                    itemBuilder: (cts, index) =>
                        BlogCard(blog: state.blogsList[index]),
                    separatorBuilder: (ctx, ind) => Gap(20.h),
                    itemCount: state.blogsList.length);
              }
              return const SizedBox();
            },
          ),
        ));
  }
}
