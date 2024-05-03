import 'package:flutter/material.dart';
import 'package:star_wars_app/src/core/utils/custom_colors.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';

class CustomNavigationTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  const CustomNavigationTab(
      {super.key, required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isSelected
              ? CustomColors.tertiaryColor
              : CustomColors.primaryColor),
      height: 36,
      width: title.length * 13.5,
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: openSansMedium(color: isSelected ? Colors.cyan : Colors.white),
        ),
      ),
    );
  }
}
