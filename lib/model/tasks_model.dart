import 'dart:convert';

import 'package:flutter/material.dart';

class TasksModel {
   int? tId;
   String? tTitle;
   String? tDate;

  //late TimeOfDay tTime;
  //late bool tStatus;
  TasksModel({
     this.tId,
     this.tTitle,
     this.tDate,
    //required this.tTime,
    //required this.tStatus,
  });

  factory TasksModel.fromMap(Map<String, dynamic> taskMap) {
    return TasksModel(
      tId: taskMap['id'],
      tTitle: taskMap['title'],
      tDate: taskMap['endDate'],
      //tTime: taskMap['endTime'],
      // tStatus: taskMap['tStatus'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': tId,
      'title': tTitle,
      'endDate': tDate,
    };
  }

  String toJson() => json.encode(toMap());

  factory TasksModel.fromJson(String source) =>
      TasksModel.fromMap(json.decode(source));
}
