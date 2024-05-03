import 'package:flutter/material.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';

class RelatedPeopleContainer extends StatelessWidget {
  const RelatedPeopleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'People Associated With',
          style: openSansBoldText(fontSize: 16),
        ),
      ],
    );
  }
}
