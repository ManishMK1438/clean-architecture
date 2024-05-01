import 'package:clean_art/core/exports.dart';

class Toasts {
  successToast({required BuildContext context, required String text}) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: text,
      ),
    );
  }

  errorToast({required BuildContext context, required String text}) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: text,
      ),
    );
  }

  infoToast({required BuildContext context, required String text}) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        message: text,
      ),
    );
  }
}
