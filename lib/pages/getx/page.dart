import 'package:flutter/material.dart';
import 'package:flutter_learn/commons/urils.dart';
import 'package:get/get.dart';

import '../widgets.dart';
import 'model.dart';

class GetXDemoPage extends StatelessWidget {
  final tick = Get.put(Tick().obs);

  void onTap() {
    debugPrint('-> onTap : ${tick.value.i}');

    tick.value.increment();

    tick.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Demo'),
      ),
      body: Center(
        child: const PageBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTap,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PageBody extends StatelessWidget {
  const PageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('build -> page widget');

    final tick = Get.find<Rx<Tick>>();

    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 8,
        children: [
          Text('每次点击 i 自增1 \n每2次点击 i_2 自增1 \n每4次点击 i_4 自增1'),
          Obx(
            () {
              debugPrint('build -> Obx');

              return InfoBox(
                label: 'Obx',
                color: asColor(tick.value.i),
                message: '$tick\n\n'
                    'Obx 会监听 tick 对象的变化, 每当 tick 对象的 notifyListeners() 函数被调用, builder(...) 都会被重新调用, 即使没有任何改变',
              );
            },
          ),
        ],
      ),
    );
  }
}
