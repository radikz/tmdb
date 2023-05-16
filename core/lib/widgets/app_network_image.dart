import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage(
      {super.key, required this.imageUrl, this.height, this.width});

  final String imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '$BASE_IMAGE_URL$imageUrl',
      width: width,
      height: height,
      placeholder: (context, url) => Container(
        color: Colors.grey,
        height: 200,
        width: 90,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
