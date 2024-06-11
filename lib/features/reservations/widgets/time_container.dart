import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/core/repositories/slots/domain/slot_domain.dart';

import '../../../core/app/styles/dimensions.dart';

class TimeContainer extends StatelessWidget {
  const TimeContainer({
    super.key,
    required this.isSelected,
    required this.slotDomain,
    this.onTap,
    required this.chosenDate,
  });

  final bool isSelected;
  final SlotDomain slotDomain;
  final DateTime chosenDate;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final slotNoActive = DateTime.now().isAfter(
      DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          int.parse(slotDomain.time.split(':')[0]),
          int.parse(slotDomain.time.split(':')[1]),
          int.parse(slotDomain.time.split(':')[2])),
    );
    final DateTime now = DateTime.now();
    return Material(
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: AppDimensions.tinyMedium,
          cornerSmoothing: 1,
        ),
      ),
      color: slotDomain.status == true ||
              slotNoActive && now.isDateEqual(chosenDate)
          ? context.color.backgroundColor.withOpacity(.5)
          : isSelected
              ? context.color.tertiary
              : context.color.onTertiary,
      child: InkWell(
        borderRadius: SmoothBorderRadius(
          cornerRadius: AppDimensions.tinyMedium,
          cornerSmoothing: 1,
        ),
        onTap: slotDomain.status == true ||
                slotNoActive && now.isDateEqual(chosenDate)
            ? null
            : onTap,
        child: Column(
          children: [
            Text(
              convertTimeFormat(slotDomain.time),
              style: context.text.rfDewiBold16.copyWith(
                color: slotDomain.status == true ||
                        slotNoActive && now.isDateEqual(chosenDate)
                    ? context.color.primary.withOpacity(.4)
                    : context.color.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${slotDomain.price.price} ₽',
              style: context.text.rfDewiRegular12.copyWith(
                  color: slotDomain.status == true ||
                          slotNoActive && now.isDateEqual(chosenDate)
                      ? context.color.primary.withOpacity(.4)
                      : context.color.primary),
            ),
          ],
        ).paddingSymmetric(
          horizontal: 24,
          vertical: 10,
        ),
      ),
    ).paddingOnly(bottom: 12);
  }
}

String convertTimeFormat(String timeString) {
  List<String> timeParts = timeString.split(':');

  if (timeParts.length >= 2) {
    int hours = int.tryParse(timeParts[0]) ?? 0;
    int minutes = int.tryParse(timeParts[1]) ?? 0;
    if (hours >= 0 && hours <= 23 && minutes >= 0 && minutes <= 59) {
      String formattedTime =
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
      return formattedTime;
    }
  }

  return 'Invalid time format';
}

extension CompareDates on DateTime {
  bool isDateEqual(DateTime date2) {
    return year == date2.year && month == date2.month && day == date2.day;
  }
}
