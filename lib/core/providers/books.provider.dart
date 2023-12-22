import 'package:ENEB_HUB/core/Controllers/Models/book_model.dart' as book_model;

import 'package:ENEB_HUB/core/Database/books.service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class BooksNotifier extends ChangeNotifier {
  List<book_model.BooksList>? books;
  List<book_model.BooksList>? originalBooks;

  List<book_model.Category>? categories;

  List<book_model.StudyLevel>? studyLevelList;

  dynamic selectedStudyLevel = 'All';

  Future<void> getBooks() async {
    try {
      final result = await BookService().getBooksByCategory();
      books = result;
      originalBooks = [...result];

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
    getBooks();
    notifyListeners();
  }

  getCategories() async {
    final result = await BookService().getCategories();
    categories = result;
    notifyListeners();
  }

  getStudyLevel() async {
    final result = await BookService().getStudyLevels();
    studyLevelList = result;
    notifyListeners();
  }

  filterBooksByStudyLevel(dynamic studyLevel) {
    selectedStudyLevel = studyLevel;
    books = originalBooks;

    final List<book_model.BooksList>? result;
    if (studyLevel is book_model.StudyLevel) {
      result = books
          ?.map((book_model.BooksList booksList) {
            return book_model.BooksList(
              category: booksList.category,
              books: booksList.books
                  .where((book) => book.studyLevel.id == studyLevel.id)
                  .toList(),
            );
          })
          .where((book_model.BooksList booksList) => booksList.books.isNotEmpty)
          .toList();
      books = result;
    }

    // Update the 'books' property of the current object

    notifyListeners();
  }
}

final booksProvider =
    ChangeNotifierProvider<BooksNotifier>((ref) => BooksNotifier());
