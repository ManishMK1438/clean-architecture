import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_art/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final appStrings = AppStrings();

  final appFonts = AppStyles();

  final appNavigation = AppNavigation();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _nameCont = TextEditingController();
  final _emailCont = TextEditingController();
  final _passCont = TextEditingController();

  @override
  void dispose() {
    _nameCont.dispose();
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
                appStrings.signUp,
                style: appFonts.normal(size: 32),
              ),
              Gap(40.h),
              AuthField(
                hintText: appStrings.name,
                cont: _nameCont,
              ),
              Gap(20.h),
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
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          AuthSignUp(
                            name: _nameCont.text.trim(),
                            email: _emailCont.text.trim(),
                            password: _passCont.text.trim(),
                          ),
                        );
                  }
                },
                child: Text(appStrings.signUp),
              ),
              Gap(20.h),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: appStrings.alreadyHaveAccount,
                    style: appFonts.normal()),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => appNavigation.pop(context: context),
                    text: appStrings.login,
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
