import 'package:clean_art/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_art/features/auth/presentation/screens/sign_up_screens/sign_up_screen.dart';
import 'package:clean_art/features/blogs/presentation/screens/blog_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/exports.dart';
import '../../widgets/auth_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final appStrings = AppStrings();
  final appFonts = AppStyles();
  final appNavigation = AppNavigation();
  final _toast = Toasts();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _emailCont = TextEditingController();
  final _passCont = TextEditingController();

  @override
  void dispose() {
    _emailCont.dispose();
    _passCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: appPadding.w),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appStrings.login,
                style: appFonts.normal(size: 32),
              ),
              Gap(40.h),
              AuthField(
                hintText: appStrings.email,
                cont: _emailCont,
              ),
              Gap(20.h),
              AuthField(
                hintText: appStrings.password,
                cont: _passCont,
                obscure: true,
              ),
              Gap(60.h),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailure) {
                    _toast.errorToast(context: context, text: state.error);
                  }
                  if (state is AuthSuccess) {
                    _toast.successToast(
                        context: context, text: appStrings.userLoggedIn);
                    appNavigation.pushAndRemove(
                        context: context, screen: BlogsScreen());
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const AppLoader();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_key.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthLogin(
                                email: _emailCont.text.trim(),
                                password: _passCont.text.trim(),
                              ),
                            );
                      }
                    },
                    child: Text(appStrings.login),
                  );
                },
              ),
              Gap(20.h),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: appStrings.dontHaveAccount, style: appFonts.normal()),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => appNavigation.push(
                          context: context, screen: SignUpScreen()),
                    text: appStrings.signUp,
                    style: appFonts.normal(
                        weight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary)),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
