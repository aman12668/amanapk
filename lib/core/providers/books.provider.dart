import 'package:ENEB_HUB/core/Controllers/Models/book_model.dart';
import 'package:ENEB_HUB/core/Database/books.service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ProductsNotifier extends ChangeNotifier {
  late List<Book> books;

  getBooks() async {
    try {
      final result = await BookService().getBooks();
      books = result;
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      // ...
    }
  }

  addToFavorite(
    Book book,
  ) {
    //...
  }
}

final productsProvider =
    ChangeNotifierProvider<ProductsNotifier>((ref) => ProductsNotifier());
