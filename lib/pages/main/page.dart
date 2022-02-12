import 'package:flutter/material.dart';
import 'package:flutter_learn/pages/provider/page.dart';

/// 主页面
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void jump(Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return page;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('状态管理Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () => jump(ProviderDemoPage()),
              child: Text('Provider'),
            ),
            TextButton(
              onPressed: () => jump(ProviderDemoPage()),
              child: Text('GetX'),
            ),
          ],
        ),
      ),
    );
  }
}
