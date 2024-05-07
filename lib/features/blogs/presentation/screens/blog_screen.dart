import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/exports.dart';

class BlogsScreen extends StatelessWidget {
  BlogsScreen({super.key});

  final _appStrings = AppStrings();
  final _appNavigation = AppNavigation();
  final _appStyles = AppStyles();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appStrings.blogs),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              //_appNavigation.push(context: context, screen: AddNewBlogScreen());
            },
            icon: const Icon(CupertinoIcons.add),
          )
        ],
      ),
    );
  }
}
