import 'package:flutter/material.dart';
import 'package:flutter_learn/commons/values.dart';
import 'package:provider/provider.dart';

import 'notifiers.dart';

/// Provider Demo
class ProviderDemoPage extends StatefulWidget {
  const ProviderDemoPage({Key? key}) : super(key: key);

  @override
  _ProviderDemoPageState createState() => _ProviderDemoPageState();
}

class _ProviderDemoPageState extends State<ProviderDemoPage> {
  final tick = Tick();

  void onTap() {
    debugPrint('-> onTap : ${tick.a}');

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
      ),
    );
  }
}

class PageBody extends StatelessWidget {
  const PageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('\n');
    debugPrint('build -> page widget');

    final readTick = context.read<Tick>();

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText1!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          /// Consumer
          Consumer<Tick>(
            builder: (_, tick, __) {
              debugPrint('build -> Consumer<Tick>');

              final str = '  Consumer<Tick>\n\n'
                  '  tick is $tick\n\n'
                  '  rebuild: tick call notifyListeners';

              return AnimatedContainer(
                alignment: Alignment.centerLeft,
                width: blockWidth,
                height: blockHeight,
                color: _color(tick.i),
                duration: animationDuration,
                child: Text(str),
              );
            },
          ),

          /// Selector
          Selector<Tick, int>(
            selector: (_, tick) => tick.a,
            builder: (_, a, __) {
              debugPrint('build -> Selector<Tick, int> : (watch a)');

              final str = '  Selector<Tick, int> (watch a)\n\n'
                  '  a is :$a\n\n'
                  '  rebuild: tick.a has changed';

              return AnimatedContainer(
                alignment: Alignment.centerLeft,
                width: blockWidth,
                height: blockHeight,
                color: _color(a),
                duration: animationDuration,
                child: Text(str),
              );
            },
          ),

          /// Selector
          Selector<Tick, int>(
            selector: (_, tick) => tick.b,
            builder: (_, b, __) {
              debugPrint('build -> Selector<Tick, int> : (watch b)');

              final str = '  Selector<Tick, int> (watch b)\n\n'
                  '  b is $b\n\n'
                  '  rebuild: tick.b has changed';

              return AnimatedContainer(
                alignment: Alignment.centerLeft,
                width: blockWidth,
                height: blockHeight,
                color: _color(b),
                duration: animationDuration,
                child: Text(str),
              );
            },
          ),

          ///  使用 Builder
          Builder(
            builder: (context) {
              debugPrint('build -> Builder');

              return AnimatedContainer(
                alignment: Alignment.centerLeft,
                width: blockWidth,
                height: blockHeight,
                color: _color(readTick.i),
                duration: animationDuration,
                child: Text('  Builder\n\n'
                    '  $readTick\n\n'
                    '  rebuild: page build called  '),
              );
            },
          ),

          /// 使用 Widget
          Box(
              i: readTick.a,
              str: '  Box -自定义 widget\n\n'
                  '   $readTick\n\n'
                  'rebuild: page build called'),
        ],
      ),
    );
  }
}

class Box extends StatelessWidget {
  final int i;

  final String str;

  const Box({
    Key? key,
    required this.i,
    required this.str,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('build -> Box');

    return AnimatedContainer(
      alignment: Alignment.centerLeft,
      width: blockWidth,
      height: blockHeight,
      color: _color(i),
      duration: animationDuration,
      child: Text(str),
    );
  }
}

Color _color(int i) {
  return vCardColors[i % vCardColors.length]!;
}
