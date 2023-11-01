import 'package:cloud_firestore/cloud_firestore.dart';

import '../Controllers/Models/book_model.dart';

class BookService {
  final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('books');

  Future<List<Book>> getBooks() async {
    QuerySnapshot querySnapshot = await booksCollection.get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      // print('data ${data['title']}, 🔥 ${data['category']}');
      return Book(
        title: data['title'],
        rating: data['rating'],
        description: data['description'],
        cover: data['cover'],
        isFavorite: data['is_favorite'],
        author: data['author'],
        category: data['category'],
        chapters: (data['chapters'] as List<dynamic>).map((chapter) {
          return Chapter(
            title: chapter['title'],
            subtitle: chapter['subtitle'],
            pdf: chapter['pdf'],
          );
        }).toList(),
      );
    }).toList();
  }

  Future<List<BooksList>> getBooksByCategory() async {
    List<Book> allBooks = await getBooks();

    Map<String, List<Book>> booksByCategory = {};

    for (var book in allBooks) {
      if (booksByCategory.containsKey(book.category)) {
        booksByCategory[book.category]!.add(book);
      } else {
        booksByCategory[book.category] = [book];
      }
    }

    List<BooksList> result = booksByCategory.entries.map((entry) {
      return BooksList(category: entry.key, books: entry.value);
    }).toList();

    return result;
  }
}





/*Future<List<BooksList>> getBookByCategories() async {
    List<Book> allBooks = await getBooks();

    Map<String, List<Book>> booksByCategory = {};

    for (var book in allBooks) {
      if (booksByCategory.containsKey(book.category)) {
        booksByCategory[book.category]!.add(book);
      } else {
        booksByCategory[book.category] = [book];
      }
    }

    List<BooksList> result = booksByCategory.entries.map((entry) {
      return BooksList(category: entry.key, books: entry.value);
    }).toList();

    return result;
  }
  
  getBooks() {
  }
  */
  
 



