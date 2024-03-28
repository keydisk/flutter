import 'package:flutter/widgets.dart';
import '../Common/ModelIndex.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum SelectBookDetailTap {
  intro(title: 'BookDetail.Intro'),
  author(title: 'BookDetail.Author'),
  publisher(title: 'BookDetail.PublisingName');


  const SelectBookDetailTap({
    required this.title,
  });

  final String title;

  String get printTitle {
    return title.tr();
  }

}

/// 책상세
class DetailBookViewModel extends CommonViewModel with ApiInterfaceMixin {

  List<SelectBookDetailTap> introTapList = [
    SelectBookDetailTap.intro,
    SelectBookDetailTap.author,
    SelectBookDetailTap.publisher
  ];

  SelectBookDetailTap _selecTap = SelectBookDetailTap.intro;

  SelectBookDetailTap get selecTap => _selecTap;

  List<BookModel> _authorBookList = [];
  List<BookModel> get authorBookList => _authorBookList;
  List<BookModel> _publisherBookList = [];
  List<BookModel> get publisherBookList => _publisherBookList;

  set selectTap(SelectBookDetailTap tap) {
    print('tap : $tap');
    _selecTap = tap;
    notifyListeners();
  }

  final BookModel _data;

  BookModel get model {
    return _data;
  }

  DetailBookViewModel(BookModel model) : _data = model {

    requestDataList();
  }

  requestDataList() async {
    String author = '';
    try {
      if (model.authors.first != null) {
        author = model.authors.first;
        print('author $author');
      }
    } catch(e) {

    }

    var observerPublisherList = api.requestBookInfoData(
        param: getParam(
            text: model.publisher,
            pageNo: 1,
            type: SortingType.latest,
            target: SearchTarget.publisher));

    var observerAuthorList = api.requestBookInfoData(
        param: getParam(
            text: author,
            pageNo: 1,
            type: SortingType.latest,
            target: SearchTarget.person));

    List<Future<dynamic>> futures = [observerPublisherList, observerAuthorList];
    List<dynamic> result = await Future.wait(futures);

    print('result.length ${result.length}');
    observerPublisherList.then((value) {

      _publisherBookList = getReturnData(value).toList();
    });

    observerAuthorList.then((json) {

      _authorBookList = getReturnData(json).toList();
    });

    notifyListeners();
  }
}
