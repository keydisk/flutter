import 'package:flutter/material.dart';
import 'ScrollLocation.dart';


extension ScrollControllerExtension on ScrollController {
  ScrollLocation get scrollPosition {

    if (offset == position.maxScrollExtent && !position.outOfRange) {// 맨 밑
      // viewModel?.nextPage();
      return ScrollLocation.bottom;
    } else if (offset == position.minScrollExtent && !position.outOfRange) {// 맨 위

      return ScrollLocation.top;
    } else { // 기타

      return ScrollLocation.none;
    }
  }
}
