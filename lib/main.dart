/*
플러터 샘플 코드 작성
* */
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Scens/Main/BookSearch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


final supportedLocales = [const Locale('en', 'US'), const Locale('ko', 'KR')];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(
    EasyLocalization(
      // 지원 언어 리스트
        supportedLocales: supportedLocales,
        //path: 언어 파일 경로
        path: 'assets/translations',
        //fallbackLocale supportedLocales에 설정한 언어가 없는 경우 설정되는 언어
        fallbackLocale: const Locale('en', 'US'),
        //startLocale을 지정하면 초기 언어가 설정한 언어로 변경됨
        //만일 이 설정을 하지 않으면 OS 언어를 따라 기본 언어가 설정됨
        // startLocale: Locale('ko', 'KR'),

        child: const BookSearch()),
  );
  // runApp(const BookSearch());
}
