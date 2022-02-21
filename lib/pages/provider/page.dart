import 'package:flutter/material.dart';
import 'package:flutter_learn/commons/urils.dart';
import 'package:provider/provider.dart';

import '../widgets.dart';
import 'notifiers.dart';

/// Provider 是对 InheritedWidget 的封装，如果对 InheritedWidget 不了解则需要先去熟悉一下
///
/// Provider 使用 extension 对 BuildContext 进行了扩展，比较常用的有 context.read<T>() 和
/// context.watch<T>().
///
/// BuildContext 本质上就是 Element，而 Inherited 则是通过调用 Element
/// 的 markNeedsRebuild 来实现在屏幕绘制下一帧重新构建组件的。
/// 所以使用时需要注意你使用哪个 context 就代表哪个 Element 会被通知刷新。
///
dynamic readme;

/// Provider Demo
class ProviderDemoPage extends StatelessWidget {
  final tick = Tick();

  void onTap() {
    debugPrint('-> onTap : ${tick.i}');

    tick.increment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Demo'),
      ),
      body: Center(
        child: ChangeNotifierProvider.value(
          value: tick,
          child: const PageBody(),
        ),
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

    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 8,
        children: [
          Text('每次点击 i 自增1 \n每2次点击 i_2 自增1 \n每4次点击 i_4 自增1'),

          /// Consumer
          Consumer<Tick>(
            builder: (_, tick, __) {
              debugPrint('build -> Consumer<Tick>');

              return InfoBox(
                label: 'Consumer<Tick>',
                color: asColor(tick.i),
                message: '$tick\n\n'
                    'Consumer<Tick> 会监听 tick 对象的变化, 每当 tick 对象的 notifyListeners() 函数被调用, builder(...) 都会被重新调用, 即使没有任何改变',
              );
            },
          ),

          ///  使用 Builder
          Builder(
            builder: (context) {
              debugPrint('build -> Builder context.watch<Tick>()');

              final _tick = context.watch<Tick>();

              return InfoBox(
                label: 'context.watch<Tick>()',
                color: asColor(_tick.i),
                message: '$_tick\n\n'
                    'watch 会监听 tick 对象的变化, 每当 tick 对象的 notifyListeners() 函数被调用, builder(...) 都会被重新调用, 即使没有任何改变',
              );
            },
          ),

          /// Selector
          Selector<Tick, int>(
            selector: (_, obs) => obs.i_2,
            builder: (_, i_2, __) {
              debugPrint('build -> Selector<Tick, int> : (watch i_2)');

              return InfoBox(
                label: 'selector: (_, obs) => obs.i_2',
                color: asColor(i_2),
                message: 'tick.a: $i_2\n\n'
                    'selector 仅在 tick.a 发生变化时收到通知, 在不关心其他成员变化的场景中非常适用',
              );
            },
          ),

          /// Selector
          Selector<Tick, int>(
            selector: (_, obs) => obs.i_4,
            builder: (_, i_4, __) {
              debugPrint('build -> Selector<Tick, int> : (watch i_4)');

              return InfoBox(
                label: 'selector: (_, obs) => obs.i_4',
                color: asColor(i_4),
                message: 'tick.b: $i_4\n\n'
                    'selector 仅在 tick.b 发生变化时收到通知, 在不关心其他成员变化的场景中非常适用',
              );
            },
          ),

          ///  使用 Builder
          Builder(
            builder: (context) {
              final _tick = context.read<Tick>();

              debugPrint('build -> Builder context.read<Tick>()');

              return InfoBox(
                label: 'context.read<Tick>() 点击调用+',
                color: asColor(_tick.i),
                message: '$_tick\n\n'
                    'context.read<Tick>() 在 builder 函数执行时获取 tick 的引用, 在 tick 对象发生变化时并不会刷新当前 widget, 适合用来在子节点调用顶层对象的函数',
                child: ElevatedButton(
                    onPressed: () {
                      debugPrint('-> onTap : ${_tick.i}');

                      _tick.increment();
                    },
                    child: Text('点击调用 tick.increment')),
              );
            },
          ),
        ],
      ),
    );
  }
}
