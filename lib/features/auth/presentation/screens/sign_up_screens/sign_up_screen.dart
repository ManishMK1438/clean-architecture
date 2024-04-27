import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/auth/presentation/widgets/auth_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final appStrings = AppStrings();
  final appFonts = AppStyles();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: appPadding.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appStrings.signUp,
              style: appFonts.normal(size: 32),
            ),
            Gap(40.h),
            AuthField(hintText: appStrings.name),
            Gap(20.h),
            AuthField(hintText: appStrings.email),
            Gap(20.h),
            AuthField(hintText: appStrings.password),
            Gap(60.h),
            ElevatedButton(
              onPressed: () {},
              child: Text(appStrings.signUp),
            ),
          ],
        ),
      ),
    );
  }
}
