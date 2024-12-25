import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:tasks/core/app_db.dart';

import '../model/tasks_model.dart';

class TasksController extends GetxController {
  RxList<TasksModel> _taskList = RxList<TasksModel>([]);
  RxList<TasksModel> get taskList => RxList([..._taskList]);

  @override
  onInit() {
    getData();
    super.onInit();
  }

  Future<int> addNewTasks({TasksModel? tasksModel}) async {
    return await AppDatabase.insertTable(tasksModel);
  }

  Future<void> getData() async {
    final List<Map<String, dynamic>> getTaskList =
        await AppDatabase.getTasksData();
    _taskList.assignAll(
        getTaskList.map((data) => TasksModel.fromMap(data)).toList());
  }

  TasksModel findById(int tId) {
    return _taskList.firstWhere((element) => element.tId == tId);
  }

  editTasks({TasksModel? tasksModel}) async {
    await AppDatabase.updateDate(tasksModel!);
    getData();
  }

  deleteTask({TasksModel? tasksModel}) async {
    await AppDatabase.deleteTasks(tasksModel!);
    getData();
  }
}
