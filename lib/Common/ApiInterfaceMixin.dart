import 'ModelIndex.dart';

/*
api 파라매터 구현한 인터페이스 추가
 */

mixin class ApiInterfaceMixin {
  Map<String, dynamic> getParam(
      {required String text,
      required int pageNo,
      required SortingType type,
      required SearchTarget target}) {
    // ignore: prefer_collection_literals
    Map<String, dynamic> param = Map<String, dynamic>();

    param["query"] = Uri.encodeComponent(text);
    param["page"] = pageNo;
    param["sort"] = type.paramName;
    param["size"] = PageInfoModel.pageSize;
    param["target"] = target.paramName;

    print('param : $param');

    return param;
  }
}
