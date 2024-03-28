import 'package:flutter/material.dart';

class ToastView {

  static ToastView shared = ToastView();

  void toast({required BuildContext context, required String text}) async {
    OverlayEntry _overlay =
        OverlayEntry(builder: (_) => _ToastWidget(msg: text));

    Navigator.of(context).overlay!.insert(_overlay);

    await Future.delayed(const Duration(seconds: 2));
    _overlay.remove();
  }
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({super.key, required this.msg});

  final String msg;

  @override
  _ToastWidgetState createState() => _ToastWidgetState(msg);
}

/// SingleTickerProviderStateMixin <- 단일 애니메이션 컨트롤러 사용시 사용
/// 두개 이상의 애니메이션 컨트롤러를 사용 하려면 TickerProviderStateMixin 를 사용
class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late String _msg;
  late AnimationController _controller;
  late Animation<double> _animation;

  _ToastWidgetState(String _msg);

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));

    _controller.forward().whenComplete(() {
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: FadeTransition(
            opacity: _animation,
            child: Material(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey),
                  child: Text(_msg, style: TextStyle(color: Colors.white))),
            ),
          ),
        ),
      ),
    );
  }
}
