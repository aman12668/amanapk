import 'package:ENEB_HUB/app/Widgets/consttants.dart';

import 'package:ENEB_HUB/app/screens/main/widgets/book_rating.dart';
import 'package:ENEB_HUB/app/screens/main/widgets/two_side_rounded_button.dart';
import 'package:ENEB_HUB/app/widgets/fallback_image.dart';
import 'package:ENEB_HUB/core/Controllers/Models/book_model.dart';
import 'package:ENEB_HUB/core/providers/books.provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReadingListCard extends ConsumerStatefulWidget {
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
  ConsumerState<ReadingListCard> createState() => _ReadingListCardState();
}

class _ReadingListCardState extends ConsumerState<ReadingListCard> {
  void favToggle() {
    setState(() {
      widget.book.isFavorite = !widget.book.isFavorite;
    });
    ref.read(booksProvider.notifier).toggleFavorite(widget.book);
  }

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
            child: CachedNetworkImage(
              imageUrl: widget.book.cover,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => FallBackImage(),
            ),
          ),
          Positioned(
            top: 35,
            right: 10,
            child: Column(
              children: <Widget>[
                IconButton(
                  icon: widget.book.isFavorite
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                        )
                      : const Icon(
                          Icons.favorite_border,
                        ),
                  onPressed: () => favToggle(),
                ),
                BookRating(score: widget.book.rating),
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
                            text: "${widget.book.title}\n",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: widget.book.author,
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
                          onTap: widget.pressDetails,
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
                          press: () => widget.pressRead,
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
