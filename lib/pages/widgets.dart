import 'package:flutter/material.dart';
import 'package:flutter_learn/commons/values.dart';

/// 盒子
class InfoBox extends StatelessWidget {
  final String label;

  /// 消息
  final String message;

  /// 颜色
  final Color color;

  final Widget? child;

  const InfoBox({
    Key? key,
    required this.message,
    required this.color,
    required this.label,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 12),
      width: blockWidth,
      // height: blockHeight,
      duration: animationDuration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0D0D0D),
            ),
          ),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF0D0D0D),
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
