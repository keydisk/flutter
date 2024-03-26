import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:test_project/APIs/APIClient.dart';
import 'package:test_project/Models/SearchOptions.dart';
import '../Common/ModelIndex.dart';

/*
jychoi 책 리스트의 비지니스 로직 처리 뷰 모델
* */
class MainViewModel extends ChangeNotifier with ApiInterfaceMixin {
  final waitTime = Duration(milliseconds: 500);
  final contentEditController = TextEditingController();
  List<BookModel> _list = [];
  PageInfoModel _pageModel = PageInfoModel(isEnd: false, pagableCnt: 0, totalCnt: 0, currentPageNo: 1);

  PageInfoModel get pageModel => _pageModel;
  List<BookModel> get bookList => _list;
  int get bookListCnt => _list.length;

  SortingType _sorting = SortingType.accuracy;
  SortingType get sorting => _sorting;
  set sorting(SortingType type) {
    _sorting = type;
    notifyListeners();

    requestList(text: searchText, pageNo: _pageModel.currentPageNo, type: _sorting, target: _target);
  }

  SearchTarget _target = SearchTarget.title;
  /// 검색할 타겟(책 제목, 저자, 출판사등~~)
  SearchTarget get target => _target;

  set target(SearchTarget target) {

    _target = target;
    notifyListeners();

    _pageModel.currentPageNo = 1;
    _pageModel.totalCnt = 0;

    if(searchText.isNotEmpty) {
      requestList(text: searchText, pageNo: _pageModel.currentPageNo, type: _sorting, target: _target);
    }
  }


  Debouncer inputSearchText = Debouncer(Duration(milliseconds: 500),
      initialValue: "", checkEquality: false);
  final api = APIClient();

  String _text = "";

  MainViewModel() {
    inputSearchText = Debouncer(waitTime, initialValue: "", checkEquality: false);

    inputSearchText.values.listen((text) {
      requestList(text: text, pageNo: _pageModel.currentPageNo, type: _sorting, target: _target);
    });

    if(kDebugMode) {
      print('debug Mode');
    }
  }

  set searchText(String text) {

    if (text == "") {
      // 입력이 없으면 기존에 리스트에 할당된 데이터를 날린다.

      _list = [];
      _pageModel.currentPageNo = 1;
      _pageModel.totalCnt = 0;
      notifyListeners();
    } else {
      if(_text != text) {
        _pageModel.currentPageNo = 1;
        _pageModel.totalCnt = 0;
        _list = [];
      }

      inputSearchText.setValue(text);
    }

    _text = text;
  }

  String get searchText {
    return _text;
  }


  // PageInfoModel
  requestList({required String text,  required int pageNo,  required SortingType type,  required SearchTarget target}) {

    api.requestBookInfoData(param: getParam(text: text, pageNo: pageNo, type: type, target: target)).then((json) {

      var lastIndex = 0;

      try {

        lastIndex = _list.last.index;
      } catch(e) {

        lastIndex = 0;
      }

      var tmpList = getReturnData(json).map((model) {

        lastIndex += 1;
        model.index = lastIndex;
        return model;
      }).toList();

      print('## _targe : $_target tmpList : ${tmpList.length} text $text');

      if(tmpList.isEmpty) {
        _list = [];
      } else {

        for (var element in tmpList) {
          _list.add(element);
        }
      }

      _pageModel = PageInfoModel(isEnd: json["meta"]["is_end"], pagableCnt: json["meta"]["pageable_count"],
          totalCnt: json["meta"]["total_count"],
          currentPageNo: _pageModel.currentPageNo);
      // 데이터 변경 알림
      notifyListeners();

    }).catchError((error) {
      print('parsing error : $error');
    });
  }

  nextPage() {

    print('next page');
    _pageModel.currentPageNo += 1;
    requestList(text: _text, pageNo: _pageModel.currentPageNo, type: _sorting, target: SearchTarget.title);
  }

}
