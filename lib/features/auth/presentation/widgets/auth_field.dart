import '../../../../core/exports.dart';

class AuthField extends StatelessWidget {
  final String _hintText;
  final TextEditingController _cont;
  final bool _obscure;

  AuthField(
      {super.key,
      required String hintText,
      required TextEditingController cont,
      bool obscure = false})
      : _hintText = hintText,
        _cont = cont,
        _obscure = obscure;
  final _appStr = AppStrings();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if (val!.trim().isEmpty) {
          return "$_hintText ${_appStr.authValidatorStr}";
        }
        return null;
      },
      obscureText: _obscure,
      controller: _cont,
      decoration: InputDecoration(
          hintText: _hintText, border: const OutlineInputBorder()),
    );
  }
}
