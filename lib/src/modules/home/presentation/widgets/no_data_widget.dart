import 'package:flutter/material.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';

class NoDataWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  const NoDataWidget({super.key, required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(icon),
          Text(
            message,
            style: openSansBoldText(),
          ),
          Text(
            'The API is not updated \nor\n There are no actual data',
            textAlign: TextAlign.center,
            style: openSansRegular(color: Colors.grey.shade600),
          )
        ],
      ),
    );
  }
}
