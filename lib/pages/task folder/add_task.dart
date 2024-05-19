import 'package:flutter/material.dart';
import 'package:taskmanagementapp/model/task_model.dart';
import 'package:taskmanagementapp/pages/task%20folder/widgets/widget.dart';
import 'package:taskmanagementapp/services/notification_service.dart';
import 'package:taskmanagementapp/services/task_service.dart';
import 'package:uuid/uuid.dart';

class AddTask extends StatefulWidget {
  TaskModel? task;
  AddTask({super.key, this.task});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();

  DateTime dateTime = DateTime.now();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController expectedDuration = TextEditingController();

  TaskService service = TaskService();
  bool _isChecked = false;
  bool isEdit = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    expectedDuration.dispose();
    desc.dispose();
  }

  loadData() {
    if (widget.task != null) {
      title.text = widget.task!.title!;
      desc.text = widget.task!.description!;
      expectedDuration.text = widget.task!.expectedDuration!;
      dateTime = widget.task!.deadlineDate!;
      _isChecked = widget.task!.status!;
      setState(() {
        isEdit = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit == true ? "Update Task" : "Add New Task",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                textWidget("Title*"),
                SizedBox(
                  height: size.height * 0.01,
                ),
                myTextfieldWidget("Enter Title", title),
                SizedBox(
                  height: size.height * 0.01,
                ),
                textWidget("Description*"),
                SizedBox(
                  height: size.height * 0.01,
                ),
                myTextfieldWidget("Enter Description", desc),
                SizedBox(
                  height: size.height * 0.01,
                ),
                textWidget("Deadline*"),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: const Color.fromARGB(255, 50, 50, 50))),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            pickDateTime();
                          },
                          icon: Icon(Icons.event)),
                      Text(
                          '${dateTime.day} / ${dateTime.month} / ${dateTime.year}  -  ${dateTime.hour} : ${dateTime.minute}')
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                textWidget("Expected Task Duration*"),
                SizedBox(
                  height: size.height * 0.01,
                ),
                myTextfieldWidget(
                    "Enter Expected task duration", expectedDuration),
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (val) {
                        setState(() {
                          _isChecked = val!;
                          if (val == true) {
                            // _currText = ;
                          }
                        });
                      },
                    ),
                    Text("Completed")
                  ],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      );
                      final task;
                      if (isEdit) {
                        task = _edittask();
                      } else {
                        task = _addtask();
                      }
                      NotificationService.showSchedulenotification(
                          title:title.text.toString(), body: desc.text.toString(), payload: "${title.text.toString().toUpperCase()} : $dateTime \n 10 minutes left",scheduledNotificationDateTime: dateTime);
                      if (task != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(isEdit
                                ? "Task Updated successfully!!"
                                : "Task Added successfully!!")));
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/home');
                        // title.clear();
                        // desc.clear();
                        // dateTime = DateTime.now();
                        // expectedDuration.clear();
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18, top: 10, bottom: 10),
                        child: Text(
                          isEdit ? 'UPDATE' : "ADD",
                          style:const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;
    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      this.dateTime = dateTime;
    });
  }

  _addtask() async {
    var id = Uuid().v1();
    TaskModel model = TaskModel(
        id: id,
        title: title.text,
        description: desc.text,
        deadlineDate: dateTime,
        status: _isChecked,
        expectedDuration: expectedDuration.text);
    final task;

    task = await service.addTask(model);
    return task;
  }

  _edittask() async {
    TaskModel model = TaskModel(
        id: widget.task!.id,
        title: title.text,
        description: desc.text,
        deadlineDate: dateTime,
        status: _isChecked,
        expectedDuration: expectedDuration.text);

    final task = await service.updateTask(model);

    return task;
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050));

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
}
