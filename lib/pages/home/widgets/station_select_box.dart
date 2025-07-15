import 'package:flutter/material.dart';
import 'package:flutter_train_app/pages/station_list/station_list_page.dart';
import 'package:flutter_train_app/pages/home/classes/variable_classes.dart';

class StationSelectBox extends StatelessWidget {
  StationSelectBox(
    this.stationBoxData, //출발역, 도착역, 역목록을 넘겨줌 (클래스로 정의되어있는 거)
    this.setDepartOrArrive, // ← 이 부분 추가!
    this.setDepartStationName, // 출발역 이름 변경 함수
    this.setArriveStationName, // 도착역 이름 변경 함수
  );
  StationBoxData stationBoxData;
  void Function(bool newValue) setDepartOrArrive; // 콜백함수, departOrArrive 변수 변경
  void Function(String newValue) setDepartStationName; // 출발역 이름 변경 함수
  void Function(String newValue) setArriveStationName; // 도착역 이름 변경 함수

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          selectedStation(
              context: context,
              // build 함수에서 받은 context를 selectedStation 함수에 전달해야 합니다.
              // onTap에서 Navigator.push 등으로 화면 이동을 할 때,
              // 현재 위젯이 트리에서 어디에 있는지(위치 정보)가 반드시 필요하기 때문입니다.
              // context가 없으면 Navigator가 동작하지 않거나 에러가 발생합니다.
              label: '출발역',
              stationName: stationBoxData.departStationName,
              departOrArrive: true,
              setDepartOrArrive: setDepartOrArrive,
              stationList: stationBoxData.stationList,
              setDepartStationName: setDepartStationName,
              setArriveStationName: setArriveStationName),
          Container(width: 2, height: 50, color: Colors.grey[400]), // 세로선
          selectedStation(
              context: context, // context 넘기기!
              label: '도착역',
              stationName: stationBoxData.arriveStationName,
              departOrArrive: false,
              setDepartOrArrive: setDepartOrArrive,
              stationList: stationBoxData.stationList,
              setDepartStationName: setDepartStationName,
              setArriveStationName: setArriveStationName),
        ],
      ),
    );
  }

  Expanded selectedStation({
    required BuildContext context, // context 추가!
    required String label,
    required String stationName,
    required bool departOrArrive,
    required void Function(bool newValue) setDepartOrArrive,
    required List<String> stationList,
    required void Function(String newValue) setDepartStationName,
    required void Function(String newValue) setArriveStationName,
  }) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        //이 Container 위젯을 터치했을 경우에, StationList 위젯이 나오게 하고싶다.

        child: GestureDetector(
          onTap: () {
            setDepartOrArrive(departOrArrive);
            print('현재 departOrArrive 변수 값 : $departOrArrive');
            // 출발역 위젯을 터치했을 경우에는 DepartOrArrive를 true로 설정하고,
            // 도착역 위젯을 터치했을 경우에는 DepartOrArrive를 false로 설정한다.
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StationListPage(
                      departOrArrive: departOrArrive,
                      stationList: stationList,
                      setDepartStationName: setDepartStationName,
                      setArriveStationName: setArriveStationName)),
            );
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label, // 출발역 또는 도착역 표시
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  stationName, // 출발역 또는 도착역의 이름이 여기 표시됨
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
