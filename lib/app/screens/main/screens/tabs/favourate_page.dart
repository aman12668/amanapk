import 'package:ENEB_HUB/app/screens/main/widgets/book_placeholder-card.widget.dart';
import 'package:ENEB_HUB/app/screens/main/widgets/reading_card_list.dart';
import 'package:ENEB_HUB/core/Controllers/Models/book_model.dart';
import 'package:ENEB_HUB/core/Database/books.service.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Book>? books;
  @override
  void initState() {
    loadBooks();

    super.initState();
  }

  void loadBooks() async {
    final result = await BookService().getFavoriteBooks();

    setState(() {
      books = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 85),
      child: createList(context),
    );
  }

  Widget createList(BuildContext ctx) {
    if (books?.isEmpty ?? true) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(height: 25),
        padding: const EdgeInsets.symmetric(horizontal: 25)
            .copyWith(bottom: 120, top: 80),
        itemBuilder: (context, index) {
          return const BookPlaceholderCard();
        },
      );
    } else {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: books!.length,
        separatorBuilder: (context, index) => const SizedBox(height: 25),
        padding: const EdgeInsets.symmetric(horizontal: 25)
            .copyWith(bottom: 120, top: 80),
        itemBuilder: (context, index) {
          final book = books?[index];
          return ReadingListCard(
            book: book!,
          );
        },
      );
    }
    ;
  }
}
