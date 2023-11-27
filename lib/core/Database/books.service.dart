import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../Controllers/Models/book_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class BookService {
  final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('books');

  Future<List<Book>> getBooks() async {
    QuerySnapshot querySnapshot = await booksCollection.get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      // print('🔥 ${data['category']['id']}');
      return Book(
        title: data['title'],
        rating: data['rating'],
        description: data['description'],
        cover: data['cover'],
        isFavorite: data['is_favorite'],
        author: data['author'],
        category: Category(
            id: data['category']['id'], name: data['category']['name']),
        studyLevel: data['study_level'],
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

  Future<void> addIdsToDocuments() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('books');

    // Retrieve documents without an id
    QuerySnapshot querySnapshot = await booksCollection.get();

    // Assign unique IDs and update documents
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      String uniqueId =
          generateUniqueId(); // You need to implement this function
      await collection.doc(documentSnapshot.id).update({'id': uniqueId});
    }
  }

// Example of a function to generate a unique ID
  String generateUniqueId() {
    // You might use a package like uuid to generate unique IDs
    // Example: return Uuid().v4();
    // For simplicity, using timestamp as a unique ID in this example
    return const Uuid().v4();
  }

  Future<void> addCategoryDocument() async {
    CollectionReference categoriesCollection =
        FirebaseFirestore.instance.collection('categories');

    // List of categories
    List<String> categoryList = [
      'Social Studies',
      'व्याकरण',
      'Zoology',
      'Grammer',
      'Exam Practice Set',
      'Physics',
      'English',
      'Accounting',
      'Advanced Level Physics',
      'Important Conversions',
      'Chemistry',
      'VIP Series',
      'Botany',
      'All Projects',
      'Practical Files',
      'Economics',
      'Past Paper Solutions',
      'Olympiad Questions',
      'Homework',
      'Mathematics',
      'H.C. Verma Physics',
      'Exam Questions',
      'Physics Numericals',
      'Computer Science',
      'नेपाली',
      'Exam Probable MCQs',
      'Old Is Gold Solution',
      'Olympiad Resources',
      'Diagrammatic Questions',
      'Technical Stream',
      'University Physics',
      'Featured'
    ];

    // Generate a random id and select a random category name
    // String randomlyGeneratedId = generateRandomId();
    // String randomlySelectedCategory = getRandomCategory(categoryList);

    // Add the document to the collection
    for (var element in categoryList) {
      await categoriesCollection.add({
        'id': const Uuid().v4(),
        'name': element,
      });
    }
  }

// Function to generate a random ID
  String generateRandomId() {
    return const Uuid().v4();
  }

// Function to get a random category from the list
  String getRandomCategory(List<String> categoryList) {
    return categoryList[Random().nextInt(categoryList.length)];
  }

  Future<void> updateBooksCategoryField() async {
    // Reference to Firestore collections
    CollectionReference categoriesCollection =
        FirebaseFirestore.instance.collection('categories');
    CollectionReference booksCollection =
        FirebaseFirestore.instance.collection('books');

    // Fetch documents from the categories collection
    QuerySnapshot categoriesSnapshot = await categoriesCollection.get();

    // Iterate through categories and update books collection
    for (QueryDocumentSnapshot categoryDocument in categoriesSnapshot.docs) {
      // Get category data
      String categoryId = categoryDocument['id'];
      String categoryName = categoryDocument['name'];

      // Update all documents in the books collection with the category data
      await booksCollection
          .where('category',
              isEqualTo:
                  null) // Optionally, you can filter by documents without a category
          .get()
          .then((booksSnapshot) async {
        for (QueryDocumentSnapshot bookDocument in booksSnapshot.docs) {
          await booksCollection.doc(bookDocument.id).update({
            'category': {'id': categoryId, 'name': categoryName},
          });
        }
      });
    }
  }

  Future<List<BooksList>> getBooksByCategory() async {
    List<Book> allBooks = await getBooks();

    Map<Category, List<Book>> booksByCategory = {};

    for (var book in allBooks) {
      print('🔥 ${book}');
      if (booksByCategory.containsKey(book.category.id)) {
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

  Future<List<Book>> getFavoriteBooks() async {
    final books = await getBooks();
    List<Book> result = books.where((book) => book.isFavorite).toList();
    return result;
  }

  addToFavorite(String id, bool isFavorite) async {
    await booksCollection.doc(id).update({'is_favorite': isFavorite});
  }
}
