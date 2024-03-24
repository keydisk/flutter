import "dart:io";
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_project/Common/ModelIndex.dart';

class APIClient {
  // "Content-type":"application/json; charset= utf-8"
  final _baseOptions = BaseOptions(
    headers: {
      "Authorization": "KakaoAK 15208ecfaeedf448c41c9312cd133cd5",
      "charset": "utf8",
      "Content-type": "application/json"
    },
    connectTimeout: Duration(seconds: 3),
    receiveTimeout: Duration(seconds: 3),
  );

  var dio = Dio();

  APIClient() {
    dio = Dio(_baseOptions);
  }

  Future requestData({required Map<String, dynamic> param}) async {
    try {
      var response = await dio.request<String>(
          'https://dapi.kakao.com/v3/search/book',
          queryParameters: param,
          options: Options(method: 'GET'));

      var rtnData = jsonDecode(response.data ?? "");

      return rtnData;
    } catch (e) {
      print('# error : $e');
    }
  }
}
