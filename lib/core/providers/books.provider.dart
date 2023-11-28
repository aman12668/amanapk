import 'package:ENEB_HUB/core/Controllers/Models/book_model.dart' as book_model;
import 'package:ENEB_HUB/core/Database/books.service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class BooksNotifier extends ChangeNotifier {
  List<book_model.BooksList>? books;

  List<book_model.Category>? categories;

  List<String>? studyLevelList;

  Future<void> getBooks() async {
    try {
      final result = await BookService().getBooksByCategory();
      books = result;

      notifyListeners();
    } catch (e) {
      //...
    } finally {
      // ...
    }
  }

  toggleFavorite(
    book_model.Book book,
  ) async {
    await BookService().toggleFavorite(book.id, book.isFavorite ? false : true);
    notifyListeners();
  }

  getCategories() async {
    final result = await BookService().getCategories();
    categories = result;
    notifyListeners();
  }

  getStudyLevel() async {
    final result = books?.map((book) {
      return book.books.map((e) => e.studyLevel).toList();
    }).toList();

    // Flatten the nested structure

    print('result 🔥 ${result}');
    // categories = result;
    notifyListeners();
  }
}

final booksProvider =
    ChangeNotifierProvider<BooksNotifier>((ref) => BooksNotifier());
