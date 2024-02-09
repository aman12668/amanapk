import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

import '../Controllers/Models/book_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class BookService {
  final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('books');

  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  final CollectionReference studyLevelCollection =
      FirebaseFirestore.instance.collection('study_levels');

  Future<List<Book>> getBooks() async {
    QuerySnapshot querySnapshot = await booksCollection.get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      // print('🔥 ${data['study_level']}');
      return Book(
        id: data['id'],
        title: data['title'],
        rating: data['rating'],
        description: data['description'],
        cover: data['cover'],
        isFavorite: data['is_favorite'],
        author: data['author'],
        category: Category(
            id: data['category']['id'], name: data['category']['name']),
        studyLevel: StudyLevel(
            id: data['study_level']['id'], name: data['study_level']['name']),
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

    final groupedBooks = groupBy(allBooks, (Book book) => book.category.id);

    // Transform the grouped map to a list of BooksList
    final result = groupedBooks.entries
        .map((entry) => BooksList(
              category: Category(
                  id: entry.key, name: entry.value.first.category.name),
              books: entry.value,
            ))
        .toList();

    return result;
  }

  Future<List<Category>> getCategories() async {
    QuerySnapshot querySnapshot = await categoriesCollection.get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      // print('🔥 ${data['category']['id']}');
      return Category(id: data['id'], name: data['name']);
    }).toList();
  }

  Future<List<StudyLevel>> getStudyLevels() async {
    QuerySnapshot querySnapshot = await studyLevelCollection.get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      // print('🔥 ${data['category']['id']}');
      return StudyLevel(id: data['id'], name: data['name']);
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

  // Future<void> addCategoryDocument() async {
  //   CollectionReference categoriesCollection =
  //       FirebaseFirestore.instance.collection('categories');

  //   // List of categories
  //   List<String> categoryList = [
  //     'Social Studies',
  //     'व्याकरण',
  //     'Zoology',
  //     'Grammer',
  //     'Exam Practice Set',
  //     'Physics',
  //     'English',
  //     'Accounting',
  //     'Advanced Level Physics',
  //     'Important Conversions',
  //     'Chemistry',
  //     'VIP Series',
  //     'Botany',
  //     'All Projects',
  //     'Practical Files',
  //     'Economics',
  //     'Past Paper Solutions',
  //     'Olympiad Questions',
  //     'Homework',
  //     'Mathematics',
  //     'H.C. Verma Physics',
  //     'Exam Questions',
  //     'Physics Numericals',
  //     'Computer Science',
  //     'नेपाली',
  //     'Exam Probable MCQs',
  //     'Old Is Gold Solution',
  //     'Olympiad Resources',
  //     'Diagrammatic Questions',
  //     'Technical Stream',
  //     'University Physics',
  //     'Featured'
  //   ];

  //   // Generate a random id and select a random category name
  //   // String randomlyGeneratedId = generateRandomId();
  //   // String randomlySelectedCategory = getRandomCategory(categoryList);

  //   // Add the document to the collection
  //   for (var element in categoryList) {
  //     await categoriesCollection.add({
  //       'id': const Uuid().v4(),
  //       'name': element,
  //     });
  //   }
  // }

  Future<void> addStudyLevelDocument() async {
    CollectionReference categoriesCollection =
        FirebaseFirestore.instance.collection('study_levels');

    // List of categories
    List<String> arr = [
      'See',
      'Class 11',
      'Class 12',
      'Ioe',
      'Iom',
    ];

    // Generate a random id and select a random category name
    // String randomlyGeneratedId = generateRandomId();
    // String randomlySelectedCategory = getRandomCategory(categoryList);

    // Add the document to the collection
    for (var element in arr) {
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
  Category getRandomCategory(List<Category> categoryList) {
    return categoryList[Random().nextInt(categoryList.length)];
  }

// Function to get a random StudyLevel from the list
  StudyLevel getRandomStudyLevel(List<StudyLevel> studyLevelList) {
    return studyLevelList[Random().nextInt(studyLevelList.length)];
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

  Future<void> updateDocumentsWithRandomCategory() async {
    try {
      // Step 1: Retrieve all documents from the collection
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('books').get();

      // Step 2: Get the list of categories
      List<Category> categories = await getCategories();

      // Step 3: Update each document with a randomly selected category
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        Category randomCategory = getRandomCategory(categories);
        await document.reference.update({'category': randomCategory});
      }

      print('Documents updated successfully.');
    } catch (e) {
      print('Error updating documents: $e');
    }
  }

  Future<void> updateDocumentsWithRandomStudyLevel() async {
    try {
      // Step 1: Retrieve all documents from the collection
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('books').get();

      // Step 2: Get the list of categories
      List<StudyLevel> studyLevels = await getStudyLevels();

      // Step 3: Update each document with a randomly selected category
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        StudyLevel randomCategory = getRandomStudyLevel(studyLevels);

        print('🔴, ${randomCategory}');

        await document.reference.update({
          'study_level': {"id": randomCategory.id, "name": randomCategory.name}
        });
      }

      print('Documents updated successfully.');
    } catch (e) {
      print('Error updating documents: $e');
    }
  }

  List<Book> findUniqueItemsByCategory(List<Book> books) {
    Set<String> uniqueCategories = <String>{};
    List<Book> uniqueItems = [];

    for (Book book in books) {
      String categoryId = book.category.id;

      if (!uniqueCategories.contains(categoryId)) {
        uniqueCategories.add(categoryId);
        uniqueItems.add(book);
      }
    }

    return uniqueItems;
  }

  Future<List<Book>> getFavoriteBooks() async {
    final books = await getBooks();
    List<Book> result = books.where((book) => book.isFavorite).toList();
    return result;
  }

  toggleFavorite(String bookId, bool isFavorite) async {
    try {
      QuerySnapshot querySnapshot =
          await booksCollection.where('id', isEqualTo: bookId).get();

      if (querySnapshot.docs.isNotEmpty) {
        // If there are matching documents, update the first one (you might need to handle multiple matches differently)
        String documentId = querySnapshot.docs[0].id;
        await booksCollection
            .doc(documentId)
            .update({'is_favorite': isFavorite});

        print('🔴 success ');
      } else {
        // Handle the case where no matching documents were found
        print('No document found with bookId $bookId.');
      }
    } catch (e) {
      print('Error updating is_favorite field: $e');
    }
  }
}
