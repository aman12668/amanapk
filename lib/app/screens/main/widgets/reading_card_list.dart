import 'package:ENEB_HUB/app/Widgets/consttants.dart';

import 'package:ENEB_HUB/app/screens/main/widgets/book_rating.dart';
import 'package:ENEB_HUB/app/screens/main/widgets/two_side_rounded_button.dart';
import 'package:ENEB_HUB/core/Controllers/Models/book_model.dart';
import 'package:flutter/material.dart';

class ReadingListCard extends StatelessWidget {
  final Book book;
  final Function()? pressDetails;
  final Function? pressRead;

  const ReadingListCard({
    super.key,
    required this.book,
    this.pressDetails,
    this.pressRead,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 202,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 220,
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
          ),
          Positioned(
            top: 0,
            child: Image.network(
              book.cover,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 35,
            right: 10,
            child: Column(
              children: <Widget>[
                IconButton(
                  icon: book.isFavorite
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                        )
                      : const Icon(
                          Icons.favorite_border,
                        ),
                  onPressed: () {},
                ),
                BookRating(score: book.rating),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 85,
              width: 202,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: RichText(
                      maxLines: 2,
                      text: TextSpan(
                        style: const TextStyle(color: kBlackColor),
                        children: [
                          TextSpan(
                            text: "${book.title}\n",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: book.author,
                            style: const TextStyle(
                              color: kLightBlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: pressDetails,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            child: const Text("Details"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TwoSideRoundedButton(
                          text: "Read",
                          press: () => pressRead,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
