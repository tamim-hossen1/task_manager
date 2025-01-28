import 'package:task_manager/Data/models/task_model.dart';

class Urls{
  static const String _baseUrls='https://task.teamrabbil.com/api/v1';
  static const String registrationUrl='$_baseUrls/registration';
  static const String loginUrl='$_baseUrls/login';
  static const String createTaskUrl='$_baseUrls/createTask';
  static const String taskStatusCountBystatusUrl='$_baseUrls/taskStatusCount';

  static String taskListByStatusUrl(String status) =>
      '$_baseUrls/listTaskByStatus/$status';

    static String deletetaskUrl(String id) => '$_baseUrls/deleteTask/$id';

    static String updateTaskStatus(String id,String status) => '$_baseUrls/$id/$status';
}