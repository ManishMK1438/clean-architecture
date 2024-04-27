import '../../../../core/exports.dart';

class AuthField extends StatelessWidget {
  final String _hintText;

  const AuthField({super.key, required String hintText}) : _hintText = hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: _hintText, border: const OutlineInputBorder()),
    );
  }
}
