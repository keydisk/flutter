import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class CommonWebViewWidget extends StatefulWidget {
  final String url;
  const CommonWebViewWidget({super.key, required this.url});

  @override
  State<CommonWebViewWidget> createState() => _CommonWebViewWidget(url: url);
}


class _CommonWebViewWidget extends State<CommonWebViewWidget> {

  final String url;

  _CommonWebViewWidget({required this.url});

  late WebViewController controller;

  String widgetTitle = '책 사기';

  setWebViewTitle() async {
    widgetTitle = await controller.getTitle() ?? '책사기';
  }

  @override
  void initState() {
    super.initState();

    widgetTitle = '';
    print('url : ${url}');
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            setState(() {

              setWebViewTitle();
            });

          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {

          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(title: Text(widgetTitle)),
    body: WebViewWidget(controller: controller),);
    // return SizedBox(
    //   width: size.width,
    //   height: size.height,
    //   child: WebViewWidget(controller: controller),
    // );
  }
}