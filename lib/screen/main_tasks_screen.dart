import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasks/controller/tasks_controller.dart';
import 'package:tasks/model/tasks_model.dart';
import '../widgets/show_bottom_sheet.dart';

class MainTasksScreen extends StatelessWidget {
  MainTasksScreen({Key? key}) : super(key: key);

  final taskController = Get.put(TasksController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasks',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Obx(
              () => taskController.taskList.isNotEmpty
                  ? ListView.separated(
                      itemCount: taskController.taskList.value.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Slidable(
                          startActionPane: ActionPane(
                            motion: ScrollMotion(),
                            extentRatio: 0.2,
                            children: [
                              SlidableAction(
                                onPressed: (_) {
                                  TasksModel _taskModel =
                                      taskController.findById(taskController
                                          .taskList.value[index].tId!);

                                  taskController.deleteTask(
                                    tasksModel: _taskModel,
                                  );
                                },
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                                taskController.taskList.value[index].tTitle!),
                            subtitle: Text(
                              taskController.taskList.value[index].tDate!,
                            ),
                            leading: CircleAvatar(
                              radius: 30,
                              child: FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Osama'
                                      //'${taskController.taskList.value[index].tTime.format(context)}',
                                      ),
                                ),
                              ),
                            ),
                            trailing: Icon(
                              Icons.more_horiz_outlined,
                              color: Colors.black87,
                            ),
                          ),
                          endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (_) => Get.toNamed(
                                    ShowBottomSheet.routeName,
                                    arguments: {
                                      'tId': taskController
                                          .taskList.value[index].tId,
                                    }),
                                backgroundColor: Colors.lightGreen,
                                label: 'Edite',
                                icon: Icons.edit,
                                foregroundColor: Colors.white,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (cont, int b) {
                        return Divider(
                          color: Colors.white24,
                        );
                      },
                    )
                  : Center(
                      child: Text('Add New Task'),
                    ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(ShowBottomSheet.routeName),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
