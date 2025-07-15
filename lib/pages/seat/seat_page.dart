import 'package:flutter/material.dart';
import 'package:flutter_train_app/pages/home/classes/variable_classes.dart';
import 'package:flutter_train_app/pages/seat/widgets/station_route.dart';
import 'package:flutter_train_app/pages/seat/widgets/guide_info.dart';
import 'package:flutter_train_app/pages/seat/widgets/seat_column.dart';
import 'package:flutter/cupertino.dart';

class SeatPage extends StatefulWidget {
  SeatPage({super.key, required this.stationBoxData});

  final StationBoxData stationBoxData;

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  String selectedColIndex = ' ';
  int selectedRowIndex = 0;

  void setSelectedColRowIndex(String newColValue, int newRowValue) {
    setState(() {
      // 같은 좌석을 다시 클릭하면 선택 해제
      if (selectedColIndex == newColValue && selectedRowIndex == newRowValue) {
        selectedColIndex = ' ';
        selectedRowIndex = 0;
      } else {
        // 다른 좌석을 클릭하면 해당 좌석 선택
        selectedColIndex = newColValue;
        selectedRowIndex = newRowValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('좌석선택'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StationRoute(stationBoxData: widget.stationBoxData), //여기 출발역, 도착역 표시
          GuideInfo(), //여기 안내 정보 표시

          Expanded(
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SeatColumn(
                      columnIndex: 'A',
                      selectedColIndex: selectedColIndex,
                      selectedRowIndex: selectedRowIndex,
                      onChanged: setSelectedColRowIndex,
                    ),
                    SeatColumn(
                      columnIndex: 'B',
                      selectedColIndex: selectedColIndex,
                      selectedRowIndex: selectedRowIndex,
                      onChanged: setSelectedColRowIndex,
                    ),
                    FakeSeatColumn(),
                    SeatColumn(
                      columnIndex: 'C',
                      selectedColIndex: selectedColIndex,
                      selectedRowIndex: selectedRowIndex,
                      onChanged: setSelectedColRowIndex,
                    ),
                    SeatColumn(
                      columnIndex: 'D',
                      selectedColIndex: selectedColIndex,
                      selectedRowIndex: selectedRowIndex,
                      onChanged: setSelectedColRowIndex,
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
// 버튼 아무것도 안선택하면 아무일도 안일어남
                  if (selectedColIndex == ' ' && selectedRowIndex == 0) {
                    return;
                  } else {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text('좌석 선택'),
                        content: Text('좌석을 선택하였습니다.'),
                        actions: [
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            child: Text('취소'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            child: Text('확인'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 2,
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  '좌석 선택',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
