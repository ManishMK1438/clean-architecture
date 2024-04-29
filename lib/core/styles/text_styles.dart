import 'package:clean_art/core/exports.dart';

class AppStyles {
  TextStyle normal({double? size, FontWeight? weight, Color? color}) {
    return TextStyle(
      fontSize: size ?? 16.sp,
      fontWeight: weight ?? FontWeight.normal,
      color: color ?? Colors.white,
    );
  }

  TextStyle darkBtnTextStyle({double? size, FontWeight? weight, Color? color}) {
    return TextStyle(
      fontSize: size ?? 16.sp,
      fontWeight: weight ?? FontWeight.w600,
      color: color ?? Colors.white,
    );
  }
}
