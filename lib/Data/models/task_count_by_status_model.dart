import 'task_count_model.dart';

class TaskCountByStatusModel {
  String? status;
  List<TaskCountModel>? taskList;

  TaskCountByStatusModel({this.status, this.taskList});

  TaskCountByStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskCountModel>[];
      json['data'].forEach((v) {
        taskList!.add(TaskCountModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.taskList != null) {
      data['data'] = this.taskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

