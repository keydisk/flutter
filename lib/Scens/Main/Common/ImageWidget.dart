import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  final String imgUrl;
  final Radius borderRadius;
  const ImageWidget({required this.imgUrl, required this.borderRadius});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImageWidget(imgUrl, borderRadius);
  }
}

class _ImageWidget extends State<ImageWidget> {
  final String url;
  final Radius borderRadius;

  _ImageWidget(this.url, this.borderRadius);

  @override
  Widget build(BuildContext context) {
    return
      ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
      url,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset('name');
      },
    ), );
  }
}
