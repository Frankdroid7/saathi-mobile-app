import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:saathi/styles.dart';

class DurationContainer extends StatelessWidget {
  final int duration;
  final bool selected;
  final VoidCallback onTap;
  const DurationContainer(
      {Key? key,
      required this.onTap,
      required this.selected,
      required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: selected
              ? Border.all(width: 4, color: AppColors.primaryTextColor)
              : null,
        ),
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: duration == -1 ? 'Other' : '$duration\n',
              style: TextStyle(
                fontSize: 30,
                color: selected
                    ? AppColors.primaryTextColor
                    : AppColors.primaryTextColor.withOpacity(0.5),
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: duration == 1
                      ? 'month'
                      : duration == -1
                          ? ''
                          : 'months',
                  style: TextStyle(
                    fontSize: 16,
                    color: selected
                        ? AppColors.primaryTextColor
                        : AppColors.primaryTextColor.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
