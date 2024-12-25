import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasks/controller/tasks_controller.dart';
import 'package:tasks/core/app_db.dart';
import 'package:tasks/model/tasks_model.dart';

class ShowBottomSheet extends StatefulWidget {
  static const routeName = 'ShowBottomSheet';
  ShowBottomSheet({Key? key}) : super(key: key);

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  bool _isfirst = true;
  Map<String, dynamic>? _taskArg;
  final _formKey = GlobalKey<FormState>();
  var _timeController = TextEditingController();
  var _dateController = TextEditingController();
  var _titleontroller = TextEditingController();

  TimeOfDay? _selectTime;
  DateTime? _selectDate;
  final controller = Get.put(TasksController());

  onSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    if (_taskArg == null) {
      int result = await controller.addNewTasks(
          tasksModel: TasksModel(
        tTitle: _titleontroller.text,
        tDate: DateFormat.yMd().format(d!),
      ));

      print('Value Id ====================' + result.toString());
      Get.back();
    } else {
      controller.editTasks(
        tasksModel: TasksModel(
          tId: _taskArg!['tId'],
          tTitle: _titleontroller.text,
          tDate: DateFormat.yMd().format(_selectDate!),
        ),
      );
      Get.back();
    }
  }

  @override
  void didChangeDependencies() {
    if (_isfirst) {
      _taskArg =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

      if (_taskArg != null) {
        TasksModel _tasksModel = controller.findById(_taskArg!['tId']);
        _selectDate = DateFormat.yMd().parse(_tasksModel.tDate!);
        _titleontroller.text = _tasksModel.tTitle!;

        _dateController.text = DateFormat.yMd().format(_selectDate!);

        //_selectTime = _tasksModel.tTime!;
        //_timeController.text = _tasksModel.tTime.format(context);
      }
      _isfirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _taskArg == null ? 'Add Task' : 'Edite Task',
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _titleontroller,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Not Null';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                    prefixIcon: Icon(
                      Icons.title,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white24,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 15,
                ),
                textfieldwidget(
                  controller: _dateController,
                  labeltext: 'Data',
                  icons: Icons.date_range,
                  textInputType: TextInputType.text,
                  enable: true,
                  onTop: () => getDatePicker(),
                ),
                SizedBox(
                  height: 15,
                ),
                // textfieldwidget(
                //   controller: _timeController,
                //   labeltext: 'Time',
                //   icons: Icons.timer,
                //   textInputType: TextInputType.text,
                //   enable: true,
                //   onTop: () => getTimePicer(),
                // ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: onSave,
                  child: Text(
                    _taskArg == null ? 'Add Task' : 'Edite Task',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  textfieldwidget(
      {covariant TextEditingController? controller,
      required String labeltext,
      required IconData icons,
      required TextInputType textInputType,
      required bool enable,
      covariant var onTop}) {
    return TextFormField(
      controller: controller,
      onTap: onTop,
      readOnly: enable,
      validator: (v) {
        if (v!.isEmpty) {
          return 'Not Null';
        }
      },
      decoration: InputDecoration(
        labelText: labeltext,
        prefixIcon: Icon(
          icons,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.white24,
          ),
        ),
      ),
      keyboardType: textInputType,
    );
  }

  getTimePicer() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then(
      (value) => setState(
        () {
          _selectTime = value ?? TimeOfDay.now();
          _timeController.text =
              value?.format(context) ?? TimeOfDay.now().format(context);
        },
      ),
    );
  }

  getDatePicker() async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (_datePicker != null) {
      setState(() {
        _selectDate = _datePicker!;
        _dateController.text = DateFormat.yMd().format(
          _datePicker,
        );
      });
    } else {
      print('Date Nulllllllllllllllllllllllllll');
    }
  }
}
