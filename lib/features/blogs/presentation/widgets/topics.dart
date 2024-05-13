import '../../../../core/exports.dart';

class Topics extends StatelessWidget {
  final List<String> _topics;
  const Topics({super.key, required List<String> topics}) : _topics = topics;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(
      _topics.length,
      (index) => Container(
        margin: EdgeInsets.only(left: 5.w),
        child: Chip(
          label: Text(
            _topics[index],
          ),
        ),
      ),
    ));
  }
}
