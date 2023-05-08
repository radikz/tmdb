import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.grey,
            size: 40,
          ),
          SizedBox(
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
