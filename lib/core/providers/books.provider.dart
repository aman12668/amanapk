import 'package:ENEB_HUB/core/Controllers/Models/book_model.dart';
import 'package:ENEB_HUB/core/Database/books.service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class BooksNotifier extends ChangeNotifier {
  List<BooksList>? books;

  Future<void> getBooks() async {
    try {
      final result = await BookService().getBooksByCategory();
      books = result;

      print('🔴, ${books}');
      notifyListeners();
    } catch (e) {
      //...
    } finally {
      // ...
    }
  }

  addToFavorite(
    Book book,
  ) async {
    // await BookService().addToFavorite(book);
  }

  removeFromFavorite(
    Book book,
  ) {
    //...
  }

  get categories {
    final result = books?.map((book) => book.category).toList() ?? [];
    notifyListeners();

    return result;
  }
}

final booksProvider =
    ChangeNotifierProvider<BooksNotifier>((ref) => BooksNotifier());
