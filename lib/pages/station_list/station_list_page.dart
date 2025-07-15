import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  StationListPage(
      {super.key,
      required this.departOrArrive,
      required this.stationList,
      required this.setDepartStationName,
      required this.setArriveStationName});
// 지금 이게 출발역을 눌러서 온 페이지인지, 도착역을 눌러서 온 건지에 대한 정보를 받아오는 것

  bool departOrArrive; // 지금 이게 출발역 눌러서 온 건지, 도착역 눌러서 온 건지에 대한 정보
  List<String> stationList; // 역 이름 목록, home_page에서 받아옴.거기 리스트 적어놓음.
  void Function(String newValue) setDepartStationName; // 출발역 이름 변경 함수
  void Function(String newValue) setArriveStationName; // 도착역 이름 변경 함수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(departOrArrive ? '출발역' : '도착역'),
        // 지금 이게 출발역을 눌러서 온 페이지인지, 도착역을 눌러서 온 건지에 대한 정보
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          //얘가 기막힌게, 컬렉션 내의 정보를 필요한만큼 불러옴
          itemCount: stationList.length,
          itemBuilder: (context, index) {
            return Station(
                context: context, // context 넘기기!
                stationName: stationList[index],
                setDepartStationName: setDepartStationName,
                setArriveStationName: setArriveStationName);
            //요 Station이 뭐냐면, 하나의 역을 표시하는 Container 위젯. 밑에 함수정의됨
          }, //Station은 매개변수로 stationList배열의 각 요소를 String타입으로 받아옴
        ),
      ),
    );
  }

  Widget Station({
    required BuildContext context, // context 추가!
    required String stationName,
    required void Function(String newValue) setDepartStationName,
    required void Function(String newValue) setArriveStationName,
  }) {
    return GestureDetector(
      onTap: () {
        if (departOrArrive) {
          setDepartStationName(stationName);
        } else {
          setArriveStationName(stationName);
        }
        Navigator.pop(context); // 이제 오류 없음!
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!),
          ),
        ),
        child: Text(
          stationName,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
