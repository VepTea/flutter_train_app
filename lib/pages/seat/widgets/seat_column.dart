import 'package:flutter/material.dart';

class SeatColumn extends StatelessWidget {
  SeatColumn(
      {required this.columnIndex,
      required this.selectedColIndex,
      required this.selectedRowIndex,
      required this.onChanged});

  final String columnIndex;
  final String selectedColIndex;
  final int selectedRowIndex;
  final Function(String, int) onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FakeSeat(rowIndex: columnIndex, alignData: Alignment.bottomCenter),
        seat(columnIndex: columnIndex, rowIndex: 1, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 2, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 3, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 4, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 5, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 6, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 7, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 8, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 9, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 10, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 11, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 12, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 13, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 14, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 15, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 16, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 17, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 18, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 19, onChanged: onChanged),
        SizedBox(height: 8),
        seat(columnIndex: columnIndex, rowIndex: 20, onChanged: onChanged),
      ],
    );
  }

  // 좌석 위젯 (선택 여부에 따라 색상 변경)
  Widget seat(
      {String? columnIndex, int? rowIndex, Function(String, int)? onChanged}) {
    bool isSelected =
        columnIndex == selectedColIndex && rowIndex == selectedRowIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: GestureDetector(
        onTap: () {
          onChanged!(columnIndex!, rowIndex!);
        },
        child: Container(
          width: 50,
          height: 50,
          child: Text(columnIndex.toString() + rowIndex.toString()),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.purple : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

// 페이크 좌석 위젯 (빈상자)
class FakeSeat extends StatelessWidget {
  FakeSeat({
    required this.rowIndex,
    this.alignData = Alignment.center,
  });

  final String rowIndex;
  final AlignmentGeometry alignData;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignData,
      width: 50,
      height: 50,
      child: Text(
        rowIndex.toString(),
        style: TextStyle(fontSize: 18),
        // Container의 child가 Text 하나일 때 textAlign은 동작하지 않습니다.
        // 대신 Container에 alignment: Alignment.center를 추가해야 텍스트가 중앙정렬됩니다.
        // textAlign은 제거해도 무방합니다.
      ),
    );
  }
}

class FakeSeatColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FakeSeat(rowIndex: ''),
        FakeSeat(rowIndex: '1'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '2'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '3'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '4'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '5'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '6'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '7'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '8'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '9'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '10'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '11'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '12'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '13'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '14'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '15'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '16'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '17'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '18'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '19'),
        SizedBox(height: 8),
        FakeSeat(rowIndex: '20'),
      ],
    );
  }
}
