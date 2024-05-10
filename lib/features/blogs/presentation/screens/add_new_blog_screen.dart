import 'dart:io';

import 'package:clean_art/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:clean_art/features/blogs/presentation/widgets/blog_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/exports.dart';

class AddNewBlogScreen extends StatefulWidget {
  const AddNewBlogScreen({super.key});

  @override
  State<AddNewBlogScreen> createState() => _AddNewBlogScreenState();
}

class _AddNewBlogScreenState extends State<AddNewBlogScreen> {
  final _appStrings = AppStrings();
  final _appNavigation = AppNavigation();
  final _appStyles = AppStyles();
  final _imgPicker = PickImage();
  final _toast = Toasts();

  final _titleCont = TextEditingController();
  final _contentCont = TextEditingController();

  File? _pickedImg;
  List<String> _selectedTopics = [];
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleCont.dispose();
    _contentCont.dispose();
    super.dispose();
  }

  _pickImg() async {
    final file = await _imgPicker.pickImage();
    if (file != null) {
      setState(() {
        _pickedImg = file;
      });
    }
  }

  Widget _selectImage() {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      height: 150.h,
      decoration: BoxDecoration(
          border: Border.all(color: focusedBorderColor),
          borderRadius: BorderRadius.circular(12)),
      child: _pickedImg != null
          ? InkWell(
              onTap: _pickImg,
              child: Image.file(
                _pickedImg!,
                fit: BoxFit.cover,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  icon: const Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                  onPressed: _pickImg,
                  label: Text(
                    _appStrings.selectImage,
                    style: _appStyles.normal(weight: FontWeight.w400),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _topics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _selectedTopics.isNotEmpty
              ? "${_appStrings.selectTopics}  ${_selectedTopics.length} ${_appStrings.selected}"
              : _appStrings.selectTopics,
          style: _appStyles.normal(),
        ),
        Gap(20.h),
        SizedBox(
          height: 40.h,
          child: ListView.separated(
            itemBuilder: (context, index) => _topicContainer(
              index: index,
              text: _appStrings.blogTopics[index],
            ),
            separatorBuilder: (ctx, index) => Gap(20.w),
            itemCount: _appStrings.blogTopics.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
          ),
        ),
      ],
    );
  }

  Widget _topicContainer({required int index, required String text}) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_selectedTopics.contains(text)) {
            _selectedTopics.remove(text);
          } else {
            _selectedTopics.add(text);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        decoration: BoxDecoration(
            color: _selectedTopics.contains(text)
                ? Theme.of(context).colorScheme.secondary
                : Colors.transparent,
            border: _selectedTopics.contains(text)
                ? null
                : Border.all(color: focusedBorderColor),
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            text,
            style: _appStyles.normal(size: 14),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appStrings.createBlogs),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: appPadding),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                Gap(30.h),
                _selectImage(),
                Gap(30.h),
                _topics(),
                Gap(40.h),
                BlogField(
                  hintText: _appStrings.title,
                  cont: _titleCont,
                  maxLines: 1,
                ),
                Gap(20.h),
                BlogField(
                  hintText: _appStrings.content,
                  cont: _contentCont,
                ),
                Gap(40.h),
                BlocConsumer<BlogBloc, BlogState>(
                  listener: (context, state) {
                    if (state is BlogFailure) {
                      _toast.errorToast(context: context, text: state.error);
                    }
                    if (state is UploadBlogSuccess) {
                      _appNavigation.pop(context: context);
                      _toast.successToast(
                          context: context,
                          text: _appStrings.blogUploadedSuccess);
                    }
                  },
                  builder: (context, state) {
                    if (state is BlogLoading) {
                      return const AppLoader();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate() &&
                            _pickedImg != null) {
                          final posterId = (context.read<AppUserCubit>().state
                                  as AppUserLoggedIn)
                              .user
                              .id;
                          context.read<BlogBloc>().add(
                                UploadBlog(
                                    id: posterId,
                                    image: _pickedImg!,
                                    title: _titleCont.text.trim(),
                                    content: _contentCont.text.trim(),
                                    topics: _selectedTopics),
                              );
                        }
                        if (_pickedImg == null) {
                          _toast.errorToast(
                              context: context,
                              text: _appStrings.pleaseSelectImg);
                        }
                      },
                      child: Text(_appStrings.upload),
                    );
                  },
                ),
                Gap(40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
