# flutter앱 개발자 ChoiJuyoung

## 적용 아키텍쳐 및 언어
MVVM, Dart

## 사용 프레임웍
* Flutter sdk : 3.19.4
* Dart version : 3.3.2
* 사용 프레임웤 :
  - debounce_throttle 2.0.0(텍스트 입력시 일정 시간 이후에 입력된 텍스트로 서버 조회를 하기 위해서 사용),
  - dio 5.4.1(http 통신을 위해 사용)
  - json_annotation 4.8.1 (json 파싱을 위해 사용)
  - provider 6.1.2 (mvvm 사용시 데이터 바인딩을 위해 사용)
  - intl 0.19.0 (금액 표시를 위해 사용)
  - webview_flutter: 4.7.0 (웹뷰 표시를 위해 사용)
  - firebase_core: 2.27.2 (파이어베이스 적용을 위해 사용, FCM, Crashlytics, firebase_analytics 등)
  - firebase_crashlytics: 3.4.20 (크래시 로그를 남기기 위해 사용)

## 구현사항
* 책 검색 (키보드로 입력시 입력이 끝나고 0.5초 이후에 검색 debounce사용)
* [카카오 책 검색 api 사용](https://dapi.kakao.com/v3/search/book)
* 책 상세보기
* 색 상세보기에서 책 선택시 웹뷰로 이동

## 향후 개선사항
* 스킴으로 모든 기능을 다 연결해서 외부에서 앱의 원하는 기능으로 연결 되게 구현

책 검색을 위해 debounce가 적용된 코드
<pre>
  <code>
    final waitTime = Duration(milliseconds: 500); inputSearchText = Debouncer(waitTime, initialValue: "",
checkEquality: false);
inputSearchText.values.listen((text) {
requestList(text: text, pageNo: _pageModel.currentPageNo, type:
_sorting, target: _target); });
  </code>
</pre>

책 상세보기에서 같은 작가 & 같은 출판사의 책 조회시 두 api호출 후 두 이벤트가 모두 발생한 이후 처리를 위한 코드
<pre>
  <code>
    List<Future<dynamic>> futures = [observerPublisherList, observerAuthorList];
List<dynamic> result = await Future.wait(futures);
  </code>
</pre>

파이어 베이스 크래시 애널리틱스 적용

![Alt Text](https://github.com/keydisk/portfolio/assets/23250335/d71b888f-167a-4ae3-bf36-323af3c33e57)
