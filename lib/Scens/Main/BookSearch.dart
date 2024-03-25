import 'package:flutter/material.dart';
import 'package:test_project/Common/ModelIndex.dart';
import 'package:test_project/Scens/DetailBook/detail_book_widget.dart';
import 'package:test_project/ViewModel/MainViewModel.dart';
import 'SubWidget/BookCardWidget.dart';
import 'package:provider/provider.dart';

import 'SubWidget/search_target_widget.dart';

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
    return ChangeNotifierProvider(
        create: (_) => MainViewModel(), child: _BookSearch());
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

    // final viewModel = Provider.of<MainViewModel>(context);
    return MaterialApp(
        title: 'My ®Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        home: Scaffold(
            appBar: AppBar(title: const Text('책 정보 조회')),
            body: Column(
              children: [
                SearchTargetWidget(
                  viewModel: viewModel,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: TextField(
                    controller: viewModel.contentEditController,
                    onChanged: (value) {
                      viewModel.searchText = value;
                    },
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(),
                      labelText: 'search text',
                      contentPadding: EdgeInsets.all(0),
                    ),
                    keyboardType: TextInputType.none,
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
                            GestureDetector(child: Text(SortingType.list[i].title, style: TextStyle(color: viewModel.sorting == SortingType.list[i] ? Colors.black : Colors.grey)), onTap: () {
                              viewModel.sorting = SortingType.list[i];
                            },)
                          )
                      ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text('검색된 책 : ${viewModel.pageModel.totalCnt}'),
                    ),
                  ],
                ),
                if (viewModel.searchText == "" && viewModel.bookListCnt == 0)
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '검색어를 입력하십시오.',
                          style: TextStyle(
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
            )));
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
