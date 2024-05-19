import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskmanagementapp/model/task_model.dart';
import 'package:taskmanagementapp/pages/task%20folder/task_list.dart';
import 'package:taskmanagementapp/services/auth_service.dart';
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
          title:const Text(
            "All Tasks",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          automaticallyImplyLeading: false,
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
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.2,
                      child: Lottie.asset('assets/no_data.json',)),
                const    Text(
                      'No Tasks!!!',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ));
              }
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                // print("sjbjhs------${snapshot.data!.length}");

                List<TaskModel> taskList = snapshot.data ?? [];
                return TaskList(
                  taskList: taskList,
                );
              }
              if (snapshot.hasError) {
                return const Text('Some Error Occured');
              }

              return Container();
            }));
  }
}
