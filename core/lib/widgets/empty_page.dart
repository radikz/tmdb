
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.grey,
            size: 40,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "There is no result",
            style: kHeading5,
          ),
        ],
      ),
    );
  }
}
