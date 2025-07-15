import 'package:flutter/material.dart';
import 'package:flutter_train_app/pages/home/widgets/trip_confirm_button.dart';
import 'package:flutter_train_app/pages/home/widgets/station_select_box.dart';
import 'package:flutter_train_app/pages/home/classes/variable_classes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

StationBoxData stationBoxData = StationBoxData();
//stationBoxData 클래스를 따로 만들었음... 코드가 너무 길어지길래
//여기 안에는 출발역 이름, 도착역 이름, 출발역과 도착역을 구분하는 변수, 역 이름 목록이 들어있음

class _HomePageState extends State<HomePage> {
  //지금 터치한 위젯이 출발역 위젯이냐, 도착역 위젯이냐에 따라서
  //stationList에서 앱바타이틀과, 역 선택 했을 시 그 역 이름을 어디 변수에 넣을것인가가 달라짐.
  bool departOrArrive = true;
  //기본값으로 출발역 위젯 true라고 치고, 도착역 위젯을 false라고 치치자
  //만약 출발역 위젯을 터치했을 땐 departOrArrive를 true로 설정하고,
  //도착역 위젯을 터치했을 땐 departOrArrive를 false로 설정하는 콜백함수를 만들어야 함.
  void setDepartOrArrive(bool newValue) {
    setState(() {
      stationBoxData.departOrArrive = newValue;
    });
  }

  //출발역과 도착역의 이름을 새롭게 저장하는 변수(사실 함수)
  String departStationName = '선택'; // 초기값
  setDepartStationName(String newValue) {
    setState(() {
      stationBoxData.departStationName = newValue;
    });
  }

  String arriveStationName = '선택'; // 초기값
  setArriveStationName(String newValue) {
    setState(() {
      stationBoxData.arriveStationName = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('기차 예매'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
            children: [
              StationSelectBox(
                stationBoxData,
                setDepartOrArrive, //이 함수를 호출하면 departOrArrive 변수가 변경됨
                setDepartStationName, // 출발역 이름 변경 함수
                setArriveStationName, // 도착역 이름 변경 함수
              ),
              SizedBox(height: 20),
              TripConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }
}
