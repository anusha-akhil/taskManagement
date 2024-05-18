import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagementapp/model/task_model.dart';
import 'package:taskmanagementapp/pages/task%20folder/task_list.dart';
import 'package:taskmanagementapp/services/auth_service.dart';
import 'package:taskmanagementapp/services/notification_service.dart';
import 'package:taskmanagementapp/services/task_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  final AuthService _authService = AuthService();
  TaskService service = TaskService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
          
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                  onTap: () {
                    _authService.logout(context);
                  },
                  child: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  )),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
          onPressed: () {
            Navigator.pushNamed(context, "/addtask");
          },
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            'Add Task',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: StreamBuilder<List<TaskModel>>(
            stream: service.getallTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData && snapshot.data!.length == 0) {
                return Center(
                    child: Text(
                  'No Tasks!!!',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ));
              }
              if (snapshot.hasData && snapshot.data!.length > 0) {
                print("sjbjhs------${snapshot.data!.length}");

                List<TaskModel> taskList = snapshot.data ?? [];
                return TaskList(
                  taskList: taskList,
                );
              }
              if (snapshot.hasError) {
                return Text('Some Error Occured');
              }

              return Container();
            }));
  }
}
