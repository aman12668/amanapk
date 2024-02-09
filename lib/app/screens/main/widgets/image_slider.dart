import 'package:ENEB_HUB/app/widgets/fallback_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ENEB_HUB/app/widgets/consttants.dart';

class ImageSliderFirebase extends StatefulWidget {
  const ImageSliderFirebase({super.key});

  @override
  State<ImageSliderFirebase> createState() => _ImageSliderFirebaseState();
}

class _ImageSliderFirebaseState extends State<ImageSliderFirebase> {
  late Stream<QuerySnapshot> imageStream;
  int currentSlideIndex = 0;
  CarouselController carouselController = CarouselController();
  @override
  void initState() {
    super.initState();
    var firebase = FirebaseFirestore.instance;
    imageStream = firebase.collection("Image_Slider").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: imageStream,
        builder: (_, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.length > 1) {
            return CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index, ___) {
                  DocumentSnapshot sliderImage = snapshot.data!.docs[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(29),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 10),
                          blurRadius: 33,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                      imageUrl: sliderImage['img'],
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const FallBackImage(),
                    ),
                  );
                },
                options: CarouselOptions(
                  autoPlayCurve: Curves.fastOutSlowIn,
                  height: 150,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: const Duration(seconds: 6),
                  disableCenter: true,
                  viewportFraction: 1,
                  pageSnapping: true,
                  clipBehavior: Clip.none,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  onPageChanged: (index, _) {
                    setState(() {
                      currentSlideIndex = index;
                    });
                  },
                ));
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
