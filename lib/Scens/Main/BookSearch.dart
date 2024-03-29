import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:test_project/Common/ModelIndex.dart';
import 'package:test_project/Scens/DetailBook/detail_book_widget.dart';
import 'package:test_project/ViewModel/MainViewModel.dart';
import 'SubWidget/BookCardWidget.dart';
import 'package:provider/provider.dart';
import 'SubWidget/search_target_widget.dart';
import 'package:test_project/Scens/Common/toast_widget.dart';

class BookSearch extends StatelessWidget {
  const BookSearch({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    // 아래 애는 뷰 모델이 다양할때 쓰는 애 실제 구현된애는 하나만 뷰모델 쓸때 쓰는 애
    // return MultiProvider(
    //   providers: [ChangeNotifierProvider<MainViewModel>(create: (_) => MainViewModel())],
    //   child: _BookSearch(),
    // );

    return MaterialApp(
        title: 'My ®Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: ChangeNotifierProvider(
            create: (_) => MainViewModel(), child: _BookSearch())
    );
  }
}

class _BookSearch extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  _BookSearch() {
    _scrollController.addListener(() {
      scrollListener();
    });
  }

  MainViewModel? viewModel;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<MainViewModel>(context, listen: true);
    this.viewModel = viewModel;

    return Scaffold(
        appBar: AppBar(title: const Text('BookSearch.Title').tr()),
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            SearchTargetWidget(
              viewModel: viewModel,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: TextField (
                onChanged: (value) {
                  viewModel.searchText = value;
                },
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.only(left: 5, right: 5),
                  hintText: tr("BookSearch.TextField.PlaceHolder"),
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                // keyboardType: TextInputType.none,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(children: [
                    for(int i = 0; i < SortingType.list.length; i++)
                      Padding(padding: const EdgeInsets.only(right: 10), child:
                      GestureDetector(child: Text(SortingType.list[i].title.tr(), style: TextStyle(color: viewModel.sorting == SortingType.list[i] ? Colors.black : Colors.grey)), onTap: () {
                        viewModel.sorting = SortingType.list[i];
                      },)
                      )
                  ],),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
    // "Booksearch.SearchedBook".tr()
                  child: Text("BookSearch".tr(gender: "SearchedBook", args: ["${viewModel.pageModel.totalCnt}"]) ),
                ),
              ],
            ),
            if (viewModel.bookListCnt == 0)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tr(viewModel.searchText == "" ? "BookSearch.EmptySearchText" : "BookSearch.EmptyView"),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            else
              Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        child: BookCardWidget(model: viewModel.bookList[i]),
                        onTap: () {

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailBookWidget(
                                  model: viewModel.bookList[i])));
                        },
                      );
                    },
                    itemCount: viewModel.bookListCnt,
                    controller: _scrollController,
                  )),

          ],

        ),


        // if(kDebugMode)
      // 플로팅 버튼으로 크래시 테스트
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(onPressed: () {
        
        ToastView.shared.toast(context: context, text: 'test toast message');
        // throw Exception();
      }, elevation: 2, child:
      const Column(children: [
        Icon(Icons.account_tree),
        Text('크래시 테스트')
      ],),
      ),
    );
  }

  scrollListener() async {
    switch (_scrollController.scrollPosition) {
      case ScrollLocation.top:
        print('스크롤이 맨 위에 위치해 있습니다');
        break;
      case ScrollLocation.bottom:
        viewModel?.nextPage();
        print('스크롤이 맨 아래에 위치해 있습니다');
        break;
      default:
        break;
    }
  }
}
