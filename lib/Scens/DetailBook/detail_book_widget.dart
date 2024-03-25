import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_project/Common/ModelIndex.dart';
import 'package:test_project/Models/BookModel.dart';
import 'package:test_project/Scens/Common/common_web_view_widget.dart';
import 'package:test_project/ViewModel/DetailBookViewModel.dart';
import 'package:test_project/Scens/Common/ImageWidget.dart';

import 'SubWidget/book_info_simple_widget.dart';

class DetailBookWidget extends StatelessWidget {
  final BookModel model;

  const DetailBookWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => DetailBookViewModel(model), child: _DetailBookWidget());
  }
}

class _DetailBookWidget extends StatelessWidget {
  // lazy DetailBookViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<DetailBookViewModel>(context, listen: true);
    // _viewModel = viewModel;

    // return LayoutBuilder(builder: (context, constraints) { });
    return Scaffold(
      appBar: AppBar(title: Text(viewModel.model.title)),
      body: Column(children: [
        Expanded(
            child: ListView(
          children: [
            Column(
              children: [
                _introInfo(viewModel),
                _line,
                _introTapList(viewModel),
                _line,
                _getBookMetaData(viewModel),
                _line,
                _contentInfo(viewModel),

                if (viewModel.authorBookList.isNotEmpty)
                  const Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 10), child:
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('작가의 다른 책',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ))
                      ]),
                  ),
                if (viewModel.authorBookList.isNotEmpty)
                  _authorBookList(context, viewModel),

                if (viewModel.publisherBookList.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('같은 출판사의 다른 책',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ))
                        ]),
                  ),

                if (viewModel.publisherBookList.isNotEmpty)
                  _publisherBookList(context, viewModel),
              ],
            )
          ],
        )),

        _line,
        Text(viewModel.model.printPrice),
        _goWebViewBottomBtn(context, viewModel),
      ]),
    );
  }

  Widget get _line {
    return Container(
      height: 1.0,
      color: Colors.grey,
    );
  }

  /// 책 상세정보 웹뷰로 이동
  Widget _goWebViewBottomBtn(
      BuildContext context, DetailBookViewModel viewModel) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 80,
            color: Colors.blue,
            child: const Center(
                child: Text('사러가기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ))),
          )
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                CommonWebViewWidget(url: viewModel.model.url)));
      },
    );
  }

  Widget _introInfo(DetailBookViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            // 여기다 적용하니.. 야가 줄어든다.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(viewModel.model.title),
                Text(viewModel.model.publisher),
                Text(viewModel.model.author),
              ],
            ),
          ),
          ImageWidget(
              imgUrl: viewModel.model.thumbnail,
              borderRadius: const Radius.circular(10))
        ],
      ),
    );
  }

  Widget _introTapList(DetailBookViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < viewModel.introTapList.length; i++)
            GestureDetector(
              child: Text(
                viewModel.introTapList[i].title,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: viewModel.selecTap == viewModel.introTapList[i]
                        ? FontWeight.bold
                        : FontWeight.normal),
              ),
              onTap: () {
                viewModel.selectTap = viewModel.introTapList[i];
              },
            ),
        ],
      ),
    );
  }

  Stack _getBookMetaData(DetailBookViewModel viewModel) {
    return Stack(
      children: [
        Visibility(
          visible: viewModel.selecTap == SelectBookDetailTap.intro,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('저자 : ${viewModel.model.author}'),
                    if (viewModel.model.printTranslators.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Container(
                          height: 10.0,
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                    if (viewModel.model.printTranslators.isNotEmpty)
                      Text('역자 ${viewModel.model.printTranslators}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('출판 : ${viewModel.model.publisher}'),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Container(
                        height: 10.0,
                        width: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    Text('출간일 ${viewModel.model.printDate}'),
                  ],
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: viewModel.selecTap == SelectBookDetailTap.author,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('저자 : ${viewModel.model.author}'),
                  ],
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: viewModel.selecTap == SelectBookDetailTap.publisher,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('출판사 : ${viewModel.model.publisher}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _contentInfo(DetailBookViewModel viewModel) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Text(viewModel.model.contents));
  }

  Widget _publisherBookList(BuildContext context, DetailBookViewModel viewModel) {

    return Container(height: 230, child: ListView.builder(
        shrinkWrap: true,
    itemBuilder: (context, index) {

          var model = viewModel.publisherBookList[index];
      return GestureDetector(child: Padding(padding: const EdgeInsets.only(left: 10, right: 10), child: BookInfoSimpleWidget(model: model)), onTap: (){

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                CommonWebViewWidget(url: model.url)));
      },);
    },
    itemCount: viewModel.publisherBookList.length,
    scrollDirection: Axis.horizontal,),
    );
  }

  Widget _authorBookList(BuildContext context, DetailBookViewModel viewModel) {

    return Container(height: 230, child: ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {

        var model = viewModel.authorBookList[index];
        return GestureDetector(child: Padding(padding: const EdgeInsets.only(left: 10, right: 10), child: BookInfoSimpleWidget(model: model)), onTap: (){

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  CommonWebViewWidget(url: model.url)));
        },);
      },
      itemCount: viewModel.authorBookList.length,
      scrollDirection: Axis.horizontal,),
    );
  }


}
