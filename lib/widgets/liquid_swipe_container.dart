import 'package:flutter/material.dart';

class LiquidSwipeContainer extends StatelessWidget {
  final Widget? child;
  final String? name;
  const LiquidSwipeContainer({Key? key, @required this.child, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: FittedBox(
        fit: BoxFit.cover,
        child: child!,
      ),
    );
  }
}
