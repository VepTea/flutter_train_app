import 'package:flutter/material.dart';

class GuideInfo extends StatelessWidget {
  const GuideInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          selectedOrNot(isSelected: true),
          SizedBox(width: 20),
          selectedOrNot(isSelected: false),
        ],
      ),
    );
  }

  Container selectedOrNot({bool isSelected = true}) {
    return Container(
      decoration: BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.purple : Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(width: 4),
            Text(isSelected ? '선택됨' : '선택 안됨'),
          ],
        ),
      ),
    );
  }
}
