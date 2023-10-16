import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ENEB_HUB/Widgets/consttants.dart';

class BookPlaceholderCard extends StatelessWidget {
  const BookPlaceholderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 245,
        width: 202,
        margin: const EdgeInsets.only(bottom: 40),
        child: Stack(children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 221,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 33,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
