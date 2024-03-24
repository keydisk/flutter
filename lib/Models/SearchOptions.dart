/// 소팅 타입
enum SortingType {
  accuracy(paramName: 'accuracy', title: '정확도순'),
  latest(paramName: 'latest', title: '최신순');

  const SortingType({
    required this.paramName,
    required this.title,
  });

  final String paramName;
  final String title;
}

enum SearchTarget {
  title(printTitle: '제목', paramName: 'title'),
  isbn(printTitle: 'ISBN', paramName: 'isbn'),
  publisher(printTitle: '출판사', paramName: 'publisher'),
  person(printTitle: '저자', paramName: 'person');

  const SearchTarget({
    required this.paramName,
    required this.printTitle,
  });

  final String paramName;
  final String printTitle;

  static List<SearchTarget> list = [title, isbn, publisher, person];
}
