import '../../exports.dart';

class AppErrorWidget extends StatelessWidget {
  final String error;
  AppErrorWidget({super.key, required this.error});

  final _appImages = AppImages();
  final _appStyle = AppStyles();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(_appImages.errorGif),
          const SizedBox(
            height: 50,
          ),
          Text(
            error,
            style: _appStyle.normal(),
          )
        ],
      ),
    );
  }
}
