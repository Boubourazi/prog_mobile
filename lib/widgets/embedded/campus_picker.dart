import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:prog_mobile/widgets/embedded/liquid_swipe_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:prog_mobile/logic/store.dart';

class CampusPicker extends StatefulWidget {
  final List<Map<String, String>>? imageUrls;

  const CampusPicker({Key? key, @required this.imageUrls}) : super(key: key);

  @override
  State<CampusPicker> createState() => _CampusPickerState();
}

class _CampusPickerState extends State<CampusPicker> {
  @override
  Widget build(BuildContext context) {
    GlobalStore store = VxState.store;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 300,
        child: LiquidSwipe(
          initialPage: store.currentCampus,
          onPageChangeCallback: (page) => ChangeCurrentCampus(page),
          positionSlideIcon: 0.82,
          enableSideReveal: true,
          waveType: WaveType.circularReveal,
          slideIconWidget: const Icon(Icons.arrow_back_ios_new),
          pages: widget.imageUrls!
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
    );
  }
}
