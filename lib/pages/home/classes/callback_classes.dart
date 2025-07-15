import 'package:flutter/material.dart';
import 'package:flutter_train_app/pages/home/classes/variable_classes.dart';

class CallbackClasses {
  StationBoxData stationBoxData = StationBoxData();

  //stationSelectBox에서 지금 터치한 위젯이 출발역 위젯이냐, 도착역 위젯이냐에 따라서
  //stationList에서 앱바타이틀과, 역 선택 했을 시 그 역 이름을 어디 변수에 넣을것인가가 달라짐.

  void setDepartOrArrive(bool newValue) {
    stationBoxData.departOrArrive = newValue;
  }

  //출발역과 도착역의 이름을 새롭게 저장하는 변수(사실 함수)
  String departStationName = '선택'; // 초기값
  setDepartStationName(String newValue) {
    departStationName = newValue;
  }

  String arriveStationName = '선택'; // 초기값
  setArriveStationName(String newValue) {
    arriveStationName = newValue;
  }
}
