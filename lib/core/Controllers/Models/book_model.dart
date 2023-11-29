class Book {
  String id;
  String title;
  double rating;
  String description;
  String cover;
  bool isFavorite;
  List<Chapter> chapters;
  String author;
  Category category;
  StudyLevel studyLevel;
  Book({
    required this.id,
    required this.title,
    required this.rating,
    required this.description,
    required this.cover,
    required this.isFavorite,
    required this.chapters,
    required this.author,
    required this.category,
    required this.studyLevel,
  });
}

class BooksList {
  Category category;
  List<Book> books;
  BooksList({
    required this.category,
    required this.books,
  });
}

class Category {
  String id;
  String name;

  Category({required this.id, required this.name});
}

class StudyLevel {
  String id;
  String name;

  StudyLevel({required this.id, required this.name});
}

class Chapter {
  String title;
  String subtitle;
  String pdf;

  Chapter({
    required this.title,
    required this.subtitle,
    required this.pdf,
  });
}
