import 'package:alonecall/app/modules/userDetails/controller/user_details_controller.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderCarousel extends StatelessWidget {
  SliderCarousel({this.sliderItem});
  final List<dynamic> sliderItem;
  @override
  Widget build(BuildContext context) => GetBuilder<UserDetailsController>(
    builder:(_con)=> SizedBox(
      height: Dimens.screenHeight,
      width: Dimens.screenWidth,
      child: CarouselSlider(
        items: List.generate(sliderItem.length, (index) => SizedBox(
          height: 200,
          width: Dimens.screenWidth,
          child: CachedNetworkImage(

            fit: BoxFit.cover,
            imageUrl: sliderItem[index] as String,
            placeholder: (context, url) =>Container(
                height:Dimens.screenHeight,
                width: Dimens.screenWidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/loading.gif'),
                  fit: BoxFit.cover
                )
              ),
                ),
            errorWidget: (context, url, dynamic error) => const Icon(Icons.error),
          ),
        ),),

        options: CarouselOptions(
          height: Dimens.screenHeight,
          aspectRatio: 1,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 8),
          autoPlayAnimationDuration:
          const Duration(milliseconds: 2000),
          //autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            _con.onChangedPage(index);
          },
          scrollDirection: Axis.horizontal,
        ),
      ),
    ),
  );
}
