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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 16,
                          color:
                              task.status == true ? Colors.green : Colors.red,
                        )
                      ],
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title.toString().toUpperCase(),
                              // "sbjjsh fsnf s fhs fszfh zshf zsf zshfbzs fzsjhfbzs fzs f sfsf fgdgh",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(task.description.toString(),style: TextStyle(fontSize: 11),),
                            // Text("sjfjd fznd fz sfzs fzsf zshf znd jzds zs dsjhzsbzd gzdbjhz zsd gzj  g",style: TextStyle(fontSize: 11),),
                            Row(
                              children: [
                                Text(
                                  'Deadline : ',
                                  style:
                                      TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    formattedDate.toString(),
                                    // "sfnmknf mf sdsg jnf sfn snf szfn sjzfss fzsf sjf zs sfsddgfxg" ,
                                    style: TextStyle(
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Expected duration : ',
                                  style:
                                      TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    task.expectedDuration.toString(),
                                    
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          child: Row(
                            children: [
                              Text(
                                'Edit',
                                style: TextStyle(fontSize: 12),
                              ),
                              Icon(
                                Icons.edit,
                                color: Colors.blue,
                                size: 15,
                              ),
                            ],
                          )),
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
                          child: Row(
                            children: [
                              Text(
                                'Remove',
                                style: TextStyle(fontSize: 12),
                              ),
                              Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 15,
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
