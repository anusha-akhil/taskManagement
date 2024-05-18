import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:taskmanagementapp/model/task_model.dart';
import 'package:taskmanagementapp/pages/task%20folder/add_task.dart';
import 'package:taskmanagementapp/services/task_service.dart';

class TaskList extends StatefulWidget {
  List<TaskModel> taskList;
  TaskList({required this.taskList});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  TaskService service = TaskService();
  String? formattedDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.taskList.length,
      itemBuilder: (context, index) {
        TaskModel model = TaskModel();
        final task = widget.taskList[index];
        formattedDate =
            DateFormat('dd-MMM-yyyy    kk:mm:a').format(task.deadlineDate!);

        return Card(
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 10, right: 10),
            horizontalTitleGap: 4,
            title: Text(
              task.title.toString().toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.description.toString()),
                // Text(
                //   '${task.deadlineDate!.day} / ${task.deadlineDate!.month} / ${task.deadlineDate!.year}  -  ${task.deadlineDate!.hour} : ${task.deadlineDate!.minute}',
                //   style: TextStyle(color: Colors.green),
                // ),
                Text(
                  formattedDate.toString(),
                  style: TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.bold),
                ),
                Text(
                  task.expectedDuration.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
                // Divider(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Text(task.status == true ? "Completed" : "Pending")
                //   ],
                // )
              ],
            ),
            trailing: Wrap(
              spacing: 15,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTask(
                            task: task,
                          ),
                        ));
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.blue,
                    size: 17,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          "Do you want to delete this task?",
                          style: TextStyle(fontSize: 14),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                service.deleteTask(task.id.toString());
                                Navigator.pop(context);
                              },
                              child: Text("Ok"))
                        ],
                      ),
                    );
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 17,
                  ),
                )
              ],
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.circle,
                size: 16,
                color: task.status == true ? Colors.green : Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }
}
