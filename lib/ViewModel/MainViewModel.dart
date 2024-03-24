import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:test_project/APIs/APIClient.dart';
import '../Common/ModelIndex.dart';

/*
jychoi 책 리스트의 비지니스 로직 처리 뷰 모델
* */
class MainViewModel extends ChangeNotifier with ApiInterfaceMixin {
  final waitTime = Duration(milliseconds: 500);
  final contentEditController = TextEditingController();
  List<BookModel> _list = [];
  PageInfoModel _pageModel = PageInfoModel(isEnd: false, pagableCnt: 0, totalCnt: 0, currentPageNo: 1);
  List<BookModel> get bookList => _list;
  int get bookListCnt => _list.length;
  Debouncer inputSearchText = Debouncer(Duration(milliseconds: 500),
      initialValue: "", checkEquality: false);
  final api = APIClient();

  String _text = "";

  MainViewModel() {
    inputSearchText = Debouncer(waitTime, initialValue: "", checkEquality: false);

    inputSearchText.values.listen((text) {
      requestList(text: text, pageNo: _pageModel.currentPageNo, type: SortingType.accuracy, target: SearchTarget.title);
    });

    if(kDebugMode) {
      print('debug Mode');
    }
  }

  set searchText(String text) {

    _text = text;

    if (text == "") {
      // 입력이 없으면 기존에 리스트에 할당된 데이터를 날린다.

      _list = [];
      _pageModel.currentPageNo = 0;
      notifyListeners();
    } else {
      inputSearchText.setValue(text);
    }
  }

  // PageInfoModel
  requestList({required String text,  required int pageNo,  required SortingType type,  required SearchTarget target}) {

    api.requestData(param: getParam(text: text, pageNo: pageNo, type: type, target: target)).then((json) {

      List<dynamic> jsonList = json['documents'];


      var lastIndex = 0;

      try {
        lastIndex = _list.last.index;

      } catch(e) {
        print(e);
        lastIndex = 0;
      }

      var tmpList = jsonList.map((model) {
        var rtnModel = BookModel.fromJson(model);
        lastIndex += 1;
        rtnModel.index = lastIndex;
        return rtnModel;
      }).toList();

      for (var element in tmpList) {

        _list.add(element);
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

  nextPage(int index) {

    // ~/ 첨보는 연산자... 정수값을 결과값으로 갖는다고 한다.
    var pageNo = index ~/ PageInfoModel.pageSize + 1;

    if(_pageModel.isEnd || (index % PageInfoModel.pageSize != 0 && _pageModel.currentPageNo >= pageNo) ) {

      return;
    }

    print('next page');
    _pageModel.currentPageNo = pageNo;
    requestList(text: _text, pageNo: _pageModel.currentPageNo, type: SortingType.accuracy, target: SearchTarget.title);
  }

}
