import 'package:flutter/material.dart';

class HorizontalContainer extends StatelessWidget {
  final List<Widget> anyWidget;
  final Color? color;
  const HorizontalContainer({super.key, required this.anyWidget, this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ColoredBox(
        color: color ?? Colors.grey.shade300,
        child: SizedBox(
          height: 36,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 16,
              children: anyWidget,
            ),
          ),
        ),
      ),
    );
  }
}
