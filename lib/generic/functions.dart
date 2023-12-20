import 'package:flutter/material.dart';

bool _ignorePositionChange = false;

Future<void> scrollToRefreshListener({required ScrollController controller}) async {
  if (controller.position.pixels < -18 && !_ignorePositionChange) {
    _ignorePositionChange = true;
    Future.delayed(const Duration(milliseconds: 3000), () {
      _ignorePositionChange = false;
    });
    controller.animateTo(
      -140,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}
