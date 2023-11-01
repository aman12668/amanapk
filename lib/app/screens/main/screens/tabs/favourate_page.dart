import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FavoritePage(),
    );
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Coming Soon....'),
      ),
      body: ResponsiveFavoriteList(),
    );
  }
}

class ResponsiveFavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // For larger screens, use a GridView with multiple columns.
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // You can adjust this as needed
            ),
            itemCount: 10, // Adjust the number of items as needed
            itemBuilder: (context, index) {
              return FavoriteItem(
                  title: 'Item $index', isFavorite: index.isEven);
            },
          );
        } else {
          // For smaller screens, use a ListView.
          return ListView.builder(
            itemCount: 10, // Adjust the number of items as needed
            itemBuilder: (context, index) {
              return FavoriteItem(
                  title: 'Item $index', isFavorite: index.isEven);
            },
          );
        }
      },
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final String title;
  final bool isFavorite;

  FavoriteItem({
    required this.title,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : null,
        ),
        title: Text(title),
      ),
    );
  }
}
