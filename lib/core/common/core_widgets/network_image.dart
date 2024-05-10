import 'package:flutter/cupertino.dart';

import '../../exports.dart';

class CachedNetImgWidget extends StatelessWidget {
  final String url;
  final BoxFit? boxFit;
  const CachedNetImgWidget({super.key, required this.url, this.boxFit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: boxFit,
      imageUrl: url,
      errorWidget: (_, error, l) => const Icon(Icons.error_outline_outlined),
      placeholder: (_, str) => const CupertinoActivityIndicator(),
    );
  }
}
