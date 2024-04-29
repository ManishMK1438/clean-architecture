import 'package:clean_art/core/exports.dart';

class AppTheme {
  static _border({Color? color}) => OutlineInputBorder(
        borderSide: BorderSide(color: color ?? borderColor),
        borderRadius: BorderRadius.circular(textFieldBorderRadius),
      );
  static final darkMode = ThemeData.dark().copyWith(
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(textFieldPadding),
          border: _border(),
          enabledBorder: _border(),
          focusedBorder: _border(color: focusedBorderColor),
          errorBorder: _border(color: errorBorderColor)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(btnBorderRadius))),
        fixedSize: MaterialStateProperty.all<Size>(Size(btnWidth, btnHeight)),
        backgroundColor: MaterialStateProperty.all<Color>(darkBtnColor),
        elevation: MaterialStateProperty.all<double>(0),
        textStyle: MaterialStateProperty.all<TextStyle>(
            AppStyles().darkBtnTextStyle()),
      )));
}
