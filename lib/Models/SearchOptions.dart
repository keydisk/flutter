import 'package:easy_localization/easy_localization.dart';

/// 소팅 타입
enum SortingType {
  accuracy(paramName: 'accuracy', title: "SearchTarget.accuracy"),
  latest(paramName: 'latest', title: "SearchTarget.latest" );

  const SortingType({
    required this.paramName,
    required this.title,
  });

  final String paramName;
  final String title;

  static List<SortingType> list = [accuracy, latest];
}

enum SearchTarget {

  title(printTitle: "BookSearch.TargetName.title", paramName: 'title'),
  isbn(printTitle: "BookSearch.TargetName.isbn", paramName: 'isbn'),
  publisher(printTitle: "BookSearch.TargetName.publisher", paramName: 'publisher'),
  person(printTitle: "BookSearch.TargetName.author", paramName: 'person');

  const SearchTarget({
    required this.paramName,
    required this.printTitle,
  });

  final String paramName;
  final String printTitle;

  static List<SearchTarget> list = [title, isbn, publisher, person];
}
