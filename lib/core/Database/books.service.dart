import 'package:cloud_firestore/cloud_firestore.dart';

import '../Controllers/Models/book_model.dart';

class BookService {
  final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('books');

  Future<List<Book>> getBooks() async {
    QuerySnapshot querySnapshot = await booksCollection.get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      print('🔴 $data');
      return Book(
        title: data['title'],
        rating: data['rating'],
        description: data['description'],
        cover: data['cover'],
        isFavorite: data['is_favorite'],
        author: data['author'],
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
}








