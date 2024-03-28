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
  - easy_localization: 3.0.5 (다국어 지원)

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

    List&lt;Future&lt;dynamic&gt;&gt; futures = [observerPublisherList, observerAuthorList];
List&lt;dynamic&gt; result = await Future.wait(futures);
  </code>
</pre>

다국어 지원
<pre>
  <code>
pubspec.yaml에
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  easy_localization: ^3.0.5

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^3.0.2

flutter:

  uses-material-design: true


    main.dart
    import 'package:easy_localization/easy_localization.dart';
    
    final supportedLocales = [const Locale('en', 'US'), const Locale('ko', 'KR')];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  runApp(
    EasyLocalization(
      // 지원 언어 리스트
        supportedLocales: supportedLocales,
        //path: 언어 파일 경로
        path: 'assets/translations',
        //fallbackLocale supportedLocales에 설정한 언어가 없는 경우 설정되는 언어
        fallbackLocale: const Locale('en', 'US'),
        //startLocale을 지정하면 초기 언어가 설정한 언어로 변경됨
        //만일 이 설정을 하지 않으면 OS 언어를 따라 기본 언어가 설정됨
        // startLocale: Locale('ko', 'KR'),

        child: const BookSearch()),
  );
  // runApp(const BookSearch());
}

다국어 지원을 위해 위의 사항 적용

다국어 파일 ko-KR <- 언어코드와 지역으로 .json 파일 이름 생성
"BookDetail": {
    "Intro": "소개",

    "Element": {
      "Publisher": "출판사"
    },

    "SearchedBook": "검색된 책 : {}",
}
위와 같이 있을때 하위 언어팩에 접근하기 위해서 tr("BookDetail.Element.Publisher") <- 이렇게 접근
"SearchedBook" 이 항목같이 하위의 {}를 정하고 데이터를 적용하려면 
"BookSearch".tr(gender: "SearchedBook", args: ["${viewModel.pageModel.totalCnt}"]) 이런식으로 {}에 적용할 데이터를 적용.

  </code>
</pre>