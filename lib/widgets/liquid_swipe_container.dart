import 'package:flutter/material.dart';

class LiquidSwipeContainer extends StatelessWidget {
  final Widget? child;
  const LiquidSwipeContainer({Key? key, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: FittedBox(
        fit: BoxFit.cover,
        child: child,
      ),
    );
  }
}
