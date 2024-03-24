class PageInfoModel {
  /// 페이지 크기
  static final pageSize = 10;

  /// 페이지 끝 여부
  var isEnd = false;

  /// 페이징 가능한 카운트
  int pagableCnt;

  /// 전체 엘리먼트 개수
  var totalCnt = 0;

  /// 현재 페이지
  var currentPageNo = 1;

  PageInfoModel(
      {required this.isEnd,
      required this.pagableCnt,
      required this.totalCnt,
      required this.currentPageNo});
}
