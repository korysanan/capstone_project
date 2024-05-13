import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

class PostImages extends StatefulWidget {
  List<dynamic>? images;

  PostImages({required this.images, super.key});

  @override
  State<PostImages> createState() => _PostImagesState();
}

class _PostImagesState extends State<PostImages> {
  int activeIndex = 0;

  Widget imageSlider(imageUrl, index) => Container(
        width: double.infinity,
        height: 240,
        color: Colors.grey,
        child: Image.network(imageUrl, fit: BoxFit.cover),
      );

  Widget indicator() => Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        alignment: Alignment.bottomCenter,
        child: AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: widget.images!.length,
          effect: JumpingDotEffect(
              dotHeight: 6,
              dotWidth: 6,
              activeDotColor: Colors.white,
              dotColor: Colors.white.withOpacity(0.6)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        CarouselSlider.builder(
          options: CarouselOptions(
            initialPage: 0,
            viewportFraction: 1,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) => setState(
              () {
                activeIndex = index;
              },
            ),
          ),
          itemCount: widget.images?.length,
          itemBuilder: (context, index, realIndex) {
            final imageUrl = widget.images?[index];
            return imageSlider(imageUrl, index);
          },
        ),
        Align(alignment: Alignment.bottomCenter, child: indicator())
      ],
    );
  }
}
