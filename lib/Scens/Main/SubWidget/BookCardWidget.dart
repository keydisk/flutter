import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_project/Common/ModelIndex.dart';
import 'package:test_project/Scens/Common/ImageWidget.dart';

class BookCardWidget extends StatelessWidget {
  final BookModel model;
  final double textMargin = 0.68;
  const BookCardWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context, constraints) { // <- 상위 뷰의 크기 가져오는 메소드
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: constraints.maxWidth / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 1)),
                child: ImageWidget(
                    imgUrl: model.thumbnail, borderRadius: const Radius.circular(10)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _wrappPadding(constraints, Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        model.title,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        textAlign: TextAlign.justify,
                      )), ),
                  // SizedBox(
                  //
                  //   width: constraints.maxWidth * textMargin,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 10),
                  //     child: Text(
                  //       model.title,
                  //       style: const TextStyle(
                  //           fontSize: 17, fontWeight: FontWeight.bold),
                  //       overflow: TextOverflow.visible,
                  //       softWrap: true,
                  //       textAlign: TextAlign.justify,
                  //     ),
                  //   ),
                  // ),

                  _wrappPadding(constraints,
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '${"BookSearch.Element.Author".tr()} : ${model.author}',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  // "Element.Author"
                  //     "Element.SalePrice"
                  //     "Element.NormalPrice"
                  _wrappPadding(constraints,
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(model.publisher)) ),
                  _wrappPadding(constraints, Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(model.status)) ),

                  _wrappPadding(constraints, Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Text(model.printPrice))),

                  _wrappPadding(constraints,
                     Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(

                        '${tr("BookSearch.Element.PublisingDate")} : ${model.printDate}',
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        textAlign: TextAlign.end,
                        style: const TextStyle(color: Colors.orange),
                      ),
                    ),
                  ),
                ],
              )
            ]),
      );
    });
  }

  Widget _wrappPadding(BoxConstraints constraints, Widget widget) {
    return SizedBox(
        // width: MediaQuery.of(context).size.width * textMargin, <- 현재 디바이스의 넓이
        width: constraints.maxWidth * textMargin,
        child: widget
    );
  }

}
