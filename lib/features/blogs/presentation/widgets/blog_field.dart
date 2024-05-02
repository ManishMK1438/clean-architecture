import '../../../../core/exports.dart';

class BlogField extends StatelessWidget {
  final String _hintText;
  final TextEditingController _cont;
  final bool _obscure;
  final int? _maxLines;
  BlogField(
      {super.key,
      required String hintText,
      required TextEditingController cont,
      int? maxLines,
      bool obscure = false})
      : _hintText = hintText,
        _cont = cont,
        _maxLines = maxLines,
        _obscure = obscure;
  final _appStr = AppStrings();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: _maxLines,
      validator: (val) {
        if (val!.trim().isEmpty) {
          return "$_hintText ${_appStr.authValidatorStr}";
        }
        return null;
      },
      obscureText: _obscure,
      controller: _cont,
      decoration: InputDecoration(
          labelText: _hintText,
          hintText: _hintText,
          border: const OutlineInputBorder()),
    );
  }
}
