

import 'package:flutter/material.dart';

class CrossFadeWidgetGlobal extends StatelessWidget {
  final Widget firstWidget;
  final Widget secondWidget;
  final bool isToggled;

  const CrossFadeWidgetGlobal({
    super.key,
    required this.firstWidget,
    required this.secondWidget,
    required this.isToggled,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      alignment: Alignment.center,
      excludeBottomFocus: true,
      firstChild: firstWidget,
      secondChild: secondWidget,

      crossFadeState: isToggled
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 1000),
    );
  }
}
