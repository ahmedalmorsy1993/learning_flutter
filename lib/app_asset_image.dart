import 'package:flutter/widgets.dart';

class AppAssetImage extends StatelessWidget {
  final String name;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const AppAssetImage({
    super.key,
    required this.name,
    this.fit,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset('images/$name', fit: fit, width: width, height: height);
  }
}
