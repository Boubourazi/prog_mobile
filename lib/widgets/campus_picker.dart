import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:prog_mobile/widgets/liquid_swipe_container.dart';

class CampusPicker extends StatelessWidget {
  final List<String>? imageUrls;

  const CampusPicker({Key? key, @required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LiquidSwipe(
        enableSideReveal: true,
        waveType: WaveType.circularReveal,
        slideIconWidget: const Icon(Icons.arrow_back_ios_new),
        pages: imageUrls!
            .map(
              (e) => LiquidSwipeContainer(
                child: Image.asset(
                  e,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
