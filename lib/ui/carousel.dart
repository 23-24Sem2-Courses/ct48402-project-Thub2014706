import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class MyCarousel extends StatefulWidget {
  const MyCarousel({Key? key}) : super(key: key);

  @override
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        height: 150,
        aspectRatio: 16 / 9,
        viewportFraction: 1.0,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        controller: CarouselController(),
        pageSnapping: true,
        scrollDirection: Axis.horizontal,
        pauseAutoPlayOnTouch: true,
        pauseAutoPlayOnManualNavigate: true,
        pauseAutoPlayInFiniteScroll: true,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        disableCenter: true,
        slideIndicator: CircularSlideIndicator(),
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/green.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
