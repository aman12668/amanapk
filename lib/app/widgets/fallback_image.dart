import 'package:flutter/material.dart';

class FallBackImage extends StatelessWidget {
  const FallBackImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/image-not-load.png',
      filterQuality: FilterQuality.high,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
