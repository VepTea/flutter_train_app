import 'package:flutter/material.dart';
import 'package:flutter_train_app/pages/home/classes/variable_classes.dart';

class StationRoute extends StatelessWidget {
  const StationRoute({super.key, required this.stationBoxData});

  final StationBoxData stationBoxData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          stationBoxData.departStationName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purple,
            fontSize: 30,
          ),
        ),
        Icon(
          Icons.arrow_circle_right_outlined,
          size: 30,
        ),
        Text(
          stationBoxData.arriveStationName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purple,
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
