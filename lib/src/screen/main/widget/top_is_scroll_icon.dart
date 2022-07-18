import 'package:flutter/material.dart';

class TopIsScrollIcon extends StatelessWidget {
  const TopIsScrollIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 5,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(20)),
    );
  }
}
