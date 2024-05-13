import 'package:clean_art/features/blogs/domain/entities/blog.dart';
import 'package:clean_art/features/blogs/presentation/widgets/topics.dart';

import '../../../../core/exports.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  BlogCard({super.key, required this.blog});

  final _appStyle = AppStyles();
  Widget _image() {
    return Container(
      height: 150.h,
      width: 1.sw,
      clipBehavior: Clip.hardEdge,
      //padding: EdgeInsets.all(8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: CachedNetImgWidget(
        url: blog.imageUrl,
        boxFit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _image(),
          Gap(12.h),
          Topics(
            topics: blog.topics,
          ),
          Gap(12.h),
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: _appStyle.normal(size: 22, weight: FontWeight.bold),
                ),
                Gap(12.h),
                Text(
                  blog.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: _appStyle.normal(size: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
