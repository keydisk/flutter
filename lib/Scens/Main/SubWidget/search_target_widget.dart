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
    // return ChangeNotifierProvider(
    //     create: (_) => MainViewModel(), child: _SearchTargetWidgetState());
    return _SearchTargetWidgetState(viewModel: viewModel,);
  }
}

class _SearchTargetWidgetState extends StatelessWidget {
  final MainViewModel viewModel;
  const _SearchTargetWidgetState({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // var viewModel = Provider.of<MainViewModel>(context, listen: true);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < SearchTarget.list.length; i++)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              child: Container(
                child: Column(
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(SearchTarget.list[i].printTitle),
                      ),
                      onTap: () {

                        viewModel.target = SearchTarget.list[i];
                      },
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    border: viewModel.target == SearchTarget.list[i]
                        ? Border.all(color: Colors.black)
                        : Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
        ],
      ),
    );
  }
}
