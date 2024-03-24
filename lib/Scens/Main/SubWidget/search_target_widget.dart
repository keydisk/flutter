import 'package:flutter/material.dart';
import 'package:test_project/ViewModel/MainViewModel.dart';

import '../../../Models/SearchOptions.dart';
import 'package:provider/provider.dart';

/// 검색 타겟 옵션
class SearchTargetWidget extends StatelessWidget {


  final MainViewModel viewModel;
  const SearchTargetWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    // 아래 애는 뷰 모델이 다양할때 쓰는 애 실제 구현된애는 하나만 뷰모델 쓸때 쓰는 애
    // return MultiProvider(
    //   providers: [ChangeNotifierProvider<MainViewModel>(create: (_) => MainViewModel())],
    //   child: _BookSearch(),
    // );
    return ChangeNotifierProvider(
        create: (_) => MainViewModel(), child: _SearchTargetWidgetState());
  }

}

class _SearchTargetWidgetState extends StatelessWidget {
  List<SearchTarget> targetList = [SearchTarget.title, SearchTarget.publisher, SearchTarget.isbn, SearchTarget.person];

  @override
  Widget build(BuildContext context) {
    return Container(child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [

      for(int i = 0; i<targetList.length;i++)
        Container(child: Column(children: [
          Padding(padding: const EdgeInsets.all(10), child: Text(targetList[i].printTitle),),
        ],), decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(5)), ),

    ], ),
    );
  }
}
