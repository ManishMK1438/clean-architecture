import '../exports.dart';

class AppNavigation {
  void push(
      {required BuildContext context, required Widget screen, Function? then}) {
    Navigator.of(context)
        .push(
          PageRouteBuilder(
            pageBuilder: (ctx, anim1, anim2) => screen,
            transitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder: (_, a, __, widget) =>
                FadeTransition(opacity: a, child: widget),
          ),
        )
        .then((value) => then);
  }

  void pushReplacement(
      {required BuildContext context, required Widget screen, Function? then}) {
    Navigator.of(context)
        .pushReplacement(
          PageRouteBuilder(
            pageBuilder: (ctx, anim1, anim2) => screen,
            transitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder: (_, a, __, widget) =>
                FadeTransition(opacity: a, child: widget),
          ),
        )
        .then((value) => then);
  }

  void pushAndRemove(
      {required BuildContext context, required Widget screen, Function? then}) {
    Navigator.of(context)
        .pushAndRemoveUntil(
            PageRouteBuilder(
              pageBuilder: (ctx, anim1, anim2) => screen,
              transitionDuration: const Duration(milliseconds: 200),
              transitionsBuilder: (_, a, __, widget) =>
                  FadeTransition(opacity: a, child: widget),
            ),
            (route) => false)
        .then((value) => then);
  }

  void pop({required BuildContext context, Function? then}) {
    Navigator.of(context).pop();
  }
}
