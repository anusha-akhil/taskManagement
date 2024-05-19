import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taskmanagementapp/model/task_model.dart';
import 'package:taskmanagementapp/pages/widgets/widgets.dart';

class TaskService {
  CollectionReference taskInstance =
      FirebaseFirestore.instance.collection('Task');
  /////////////////////////////////////////////////
  Future<TaskModel?> addTask(TaskModel task) async {
    try {
      // task.id = taskInstance.id;

      final datamap = task.toMap();
      await taskInstance.doc(task.id).set(datamap);
      // return data;
      return task;
    } on FirebaseException catch (e) {
      showToastWidget('Erron on adding task');
    }
  }

  ////////////////////////////////////////////////////////////////////////
  Stream<List<TaskModel>> getallTasks() {
    try {
      return taskInstance.snapshots().map((QuerySnapshot snapshot) {
        return snapshot.docs.map((DocumentSnapshot doc) {
          return TaskModel.fromjson(doc);
        }).toList();
      });
    } on FirebaseException catch (e) {
      // print(e);
      throw (e);
    }
  }

  /////////////////////////////////////////////////////
  updateTask(TaskModel task) {
    try {
      final taskMap = task.toMap();
      // print("update-----$taskMap--${task.id}");
      taskInstance.doc(task.id).update(taskMap);
    } on FirebaseException catch (e) {
      // print(e);
      throw (e);
    }
  }
  //////////////////////////////////////////////////////
  deleteTask(String id){
     try {
      taskInstance.doc(id).delete();
    } on FirebaseException catch (e) {
      // print(e);
      throw (e);
    }
  }
}
