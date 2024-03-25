import 'package:flutter/widgets.dart';
import 'package:test_project/APIs/APIClient.dart';
import '../Common/ModelIndex.dart';

enum SelectBookDetailTap {
  intro(title: '소개'),
  author(title: '저자'),
  publisher(title: '출판사명');

  const SelectBookDetailTap({
    required this.title,
  });

  final String title;
}

/// 책상세
class DetailBookViewModel extends ChangeNotifier with ApiInterfaceMixin {
  APIClient _api = APIClient();

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

    var observerPublisherList = _api.requestBookInfoData(
        param: getParam(
            text: model.publisher,
            pageNo: 1,
            type: SortingType.latest,
            target: SearchTarget.publisher));

    var observerAuthorList = _api.requestBookInfoData(
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
