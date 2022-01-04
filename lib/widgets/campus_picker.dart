import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:prog_mobile/widgets/liquid_swipe_container.dart';

class CampusPicker extends StatelessWidget {
  final List<Map<String, String>>? imageUrls;

  const CampusPicker({Key? key, @required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 300,
          child: LiquidSwipe(
            positionSlideIcon: 0.82,
            enableSideReveal: true,
            waveType: WaveType.liquidReveal,
            slideIconWidget: const Icon(Icons.arrow_back_ios_new),
            pages: imageUrls!
                .map(
                  (e) => LiquidSwipeContainer(
                      child: Image.asset(
                        e["url"]!,
                      ),
                      name: e["name"]),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
