import 'package:clean_art/core/exports.dart';
import 'package:clean_art/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_art/features/auth/presentation/screens/sign_up_screens/login_screen.dart';
import 'package:clean_art/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:clean_art/features/blogs/presentation/screens/blog_screen.dart';
import 'package:clean_art/firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();
  runApp(
    DevicePreview(
      //enabled: !kReleaseMode,
      enabled: false,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => serviceLocator<AuthBloc>(),
              ),
              BlocProvider(
                create: (_) => serviceLocator<BlogBloc>(),
              ),
            ],
            child: MaterialApp(
                locale: DevicePreview.locale(context),
                builder: DevicePreview.appBuilder,
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: AppTheme.darkMode,
                home: child),
          );
        },
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return BlogsScreen();
            } else {
              return const LoginScreen();
            }
          },
        ));
  }
}
