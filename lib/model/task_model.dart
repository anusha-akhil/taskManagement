import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmanagementapp/utils.dart';

class TaskModel {
  String? title;
  String? description;
  DateTime? deadlineDate;
  String? expectedDuration;
  bool? status;
  String? id;
  TaskModel(
      {this.title,
      this.description,
      this.deadlineDate,
      this.expectedDuration,
      this.status,
      this.id});

  factory TaskModel.fromjson(DocumentSnapshot json) {
    Timestamp? timestamp=json["deadlineDate"];
    return TaskModel(
        title: json["title"],
        description: json["description"],
        deadlineDate: timestamp!.toDate(),
        expectedDuration: json["expectedDuration"],
        status: json["status"],
        id: json["id"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "deadlineDate": Utils.fromdateTime(deadlineDate!),
      "expectedDuration": expectedDuration,
      "status": status,
      "id": id
    };
  }
}
