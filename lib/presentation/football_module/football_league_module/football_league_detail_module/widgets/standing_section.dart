import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StandingSection extends StatelessWidget {
  final String label;
  final Iterable<int> data;
  final bool isLast;

  const StandingSection({
    super.key,
    required this.label,
    required this.data,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: isLast ? 16 : 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          for (var d in data) _buildWrapper('$d'),
        ],
      ),
    );
  }

  Widget _buildWrapper(String data) {
    return Container(
      height: 56,
      alignment: Alignment.center,
      child: Text(
        data,
        style: Get.textTheme.bodyLarge,
      ),
    );
  }
}
