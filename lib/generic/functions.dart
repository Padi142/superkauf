import 'package:easy_localization/easy_localization.dart';
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

String getDaysUntilString(DateTime futureDate) {
  final now = DateTime.now();
  final nowDate = DateTime(now.year, now.month, now.day);

  if (futureDate.isBefore(nowDate)) {
    return 'sale_expired'.tr();
  }

  final difference = futureDate.difference(nowDate).inDays;

  if (difference == 0) {
    return 'today_label'.tr();
  } else if (difference == 1) {
    return 'today_label'.tr();
  } else if (difference > 1 && difference <= 4) {
    return '${'ends_in_label'.tr()} $difference ${'ends_in_multiple_days_label'.tr()}';
  } else if (difference > 4) {
    return '${'ends_in_label'.tr()} $difference ${'ends_in_days_label'.tr()}';
  } else if (difference < 0) {
    return 'sale_expired'.tr();
  } else {
    return 'Invalid date'; // The provided date is in the past
  }
}
