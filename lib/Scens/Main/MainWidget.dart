import 'package:flutter/material.dart';
import 'package:test_project/Scens/BookSearchMain/BookSearch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'JyChoi Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: _MainWidget());
  }

}

class _MainWidget extends StatelessWidget {
  const _MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: const Text("JyChoi Flutter")),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [

            _setLeftAlignView(GestureDetector(
              child: const Text("책 검색"),
              onTap: () {

                print("책 검색으로 이동");
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const BookSearch()));
                //
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => const BookSearch()));
              },
            )),
            _setLeftAlignView(GestureDetector(
              child: const Text("외부 앱 호출"),
              onTap: () async {

                const url = 'https://google.com';
                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              },
            )),
            _setLeftAlignView(GestureDetector(
              child: const Text("크래시 테스트"),
              onTap: () {
                throw Exception();
              },
            )),
          ]),
        ));
  }

  Widget _setLeftAlignView(Widget view) {
    return SizedBox(child: Row(
      children: [view, SizedBox()],
    ), height: 50);
  }
}


