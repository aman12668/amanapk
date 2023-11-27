import 'package:ENEB_HUB/app/screens/main/screens/details_screen.dart';
import 'package:ENEB_HUB/app/screens/main/widgets/book_placeholder-card.widget.dart';
import 'package:ENEB_HUB/app/screens/main/widgets/book_rating.dart';
import 'package:ENEB_HUB/app/screens/main/widgets/image_slider.dart';
import 'package:ENEB_HUB/app/screens/main/widgets/reading_card_list.dart';
import 'package:ENEB_HUB/app/screens/main/widgets/two_side_rounded_button.dart';
import 'package:ENEB_HUB/core/Database/books.service.dart';
import 'package:ENEB_HUB/core/providers/books.provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ENEB_HUB/app/Widgets/consttants.dart';

import '../../../../core/Controllers/Models/book_model.dart';
import 'drawer/widget/navigation_drawer_widget.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

// class HomeScreenTest extends StatelessWidget {
//   const HomeScreenTest({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Center(
//             child: Text("Login Successfull"),
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//               },
//               child: const Text('Log Out Now'))
//         ],
//       ),
//     );
//   }
// }

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _booksFutre;

  @override
  void initState() {
    _booksFutre = loadBooks();
    super.initState();
  }

  Future<void> loadBooks() async {
    await ref.read(booksProvider.notifier).getBooks();
    // await BookService().updateBooksCategoryField();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // drawer: NavigationDrawerWidget(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage("assets/images/main_page_bg.png"),
                  //   alignment: Alignment.topCenter,
                  //   fit: BoxFit.fitWidth,
                  // ),
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: size.height * .1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.headline4,
                        children: const [
                          TextSpan(text: "What are you \nLearning "),
                          TextSpan(
                              text: "today?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const ImageSliderFirebase(),
                  buildCategoryButtons(context),
                  buildBooksList(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headline4,
                            children: const [
                              TextSpan(text: "Best of the "),
                              TextSpan(
                                text: "day",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        bestOfTheDayCard(size, context),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headline4,
                            children: const [
                              TextSpan(text: "Continue "),
                              TextSpan(
                                text: "reading...",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(38.5),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 33,
                                color: const Color(0xFFD3D3D3).withOpacity(.84),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(38.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 20),
                                    child: Row(
                                      children: <Widget>[
                                        const Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Crushing & Influence",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "Unknown",
                                                style: TextStyle(
                                                  color: kLightBlackColor,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text(
                                                  "Chapter 7 of 10",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: kLightBlackColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          "assets/images/book-1.png",
                                          width: 55,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 7,
                                  width: size.width * .65,
                                  decoration: BoxDecoration(
                                    color: kProgressIndicator,
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryButtons(BuildContext ctx) {
    final categoryList = ref.watch(booksProvider).categories;

    return FutureBuilder(
      future: _booksFutre,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            (categoryList.isEmpty)) {
          return Container(
            height: 30,
            margin: const EdgeInsets.only(top: 24),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 233, 233),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'English',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Container(
            height: 30,
            margin: const EdgeInsets.only(top: 24),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              clipBehavior: Clip.none,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final cat = categoryList[index];
                print(categoryList.toString());
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 233, 233),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      cat,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget buildBooksList(BuildContext context) {
    final booksList = ref.watch(booksProvider).books;

    return FutureBuilder(
      future: _booksFutre,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            (booksList?.isEmpty ?? true)) {
          return SizedBox(
            height: 285,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              separatorBuilder: (context, index) => const SizedBox(
                width: 24,
              ),
              itemBuilder: (context, index) {
                return const BookPlaceholderCard();
              },
            ),
          );
        } else {
          return ListView.separated(
            itemCount: booksList!.length,
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            clipBehavior: Clip.none,
            padding: const EdgeInsets.all(0).copyWith(bottom: 40, top: 40),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              BooksList books = booksList![index];
              return SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              books.category.name.capitalize(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Read More',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black38,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.black38,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      height: 250,
                      width: double.infinity,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        clipBehavior: Clip.none,
                        itemCount: books.books.length,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 24,
                        ),
                        itemBuilder: (context, index) {
                          final book = books.books[index];
                          return ReadingListCard(
                            book: book,
                            pressDetails: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailsScreen(
                                      book: book,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Container bestOfTheDayCard(Size size, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 245,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 24,
                top: 24,
                right: size.width * .35,
              ),
              height: 247,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFEAEAEA).withOpacity(.45),
                borderRadius: BorderRadius.circular(29),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: const Text(
                      "New York Time Best For 11th March 2020",
                      style: TextStyle(
                        fontSize: 9,
                        color: kLightBlackColor,
                      ),
                    ),
                  ),
                  Text(
                    "How To Win \nFriends &  Influence",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Text(
                    "Gary Venchuk",
                    style: TextStyle(color: kLightBlackColor),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: BookRating(score: 4.9),
                        ),
                        Expanded(
                          child: Text(
                            "When the earth was flat and everyone wanted to win the game of the best and people….",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              color: kLightBlackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              "assets/images/book-3.png",
              width: size.width * .37,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: 40,
              width: size.width * .3,
              child: TwoSideRoundedButton(
                text: "Read",
                radious: 24,
                press: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
