import 'package:alonecall/app/theme/theme.dart';
import 'package:alonecall/app/utils/asset_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget circularPhoto({String imageUrl}) => Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1.5,color: Colors.white)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.hundred),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          placeholder: (context, url) => Container(
            height: Dimens.screenHeight,
            width: Dimens.screenWidth,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetConstants.loading, fit: BoxFit.cover)),
          ),
          errorWidget: (context, url, dynamic error) => const Icon(Icons.error),
        ),
      ),
    );
