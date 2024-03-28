import 'package:flutter/material.dart';
import 'package:test_project/ViewModel/MainViewModel.dart';

import '../../../Models/SearchOptions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

/// 검색 타겟 옵션
class SearchTargetWidget extends StatelessWidget {
  final MainViewModel viewModel;

  const SearchTargetWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

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
                        child: Text(SearchTarget.list[i].printTitle.tr()),
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
