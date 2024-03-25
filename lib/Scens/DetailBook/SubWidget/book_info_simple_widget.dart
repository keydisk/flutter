import 'package:flutter/material.dart';
import 'package:test_project/Common/ModelIndex.dart';

import '../../Common/ImageWidget.dart';

class BookInfoSimpleWidget extends StatelessWidget {
  final BookModel model;

  const BookInfoSimpleWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(8.0)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 100,
            child: ImageWidget(
                imgUrl: model.thumbnail,
                borderRadius: const Radius.circular(10))),
        SizedBox(
          width: 100,
          child: Text(
            model.title,
            maxLines: 2,
          ),
        ),
        Text(model.printDate),
      ],
    ), ) ;
  }
}
