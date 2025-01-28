import 'package:flutter/material.dart';
import 'package:task_manager/Data/Services/network_caller.dart';
import 'package:task_manager/Data/models/task_count_by_status_model.dart';
import 'package:task_manager/Data/models/task_list_By_status.dart';
import 'package:task_manager/Data/models/task_model.dart';
import 'package:task_manager/Data/utils/Urls.dart';
import 'package:task_manager/ui/screen/New_task_Screen.dart';
import 'package:task_manager/ui/widgets/Circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/ScreenBackground.dart';
import 'package:task_manager/ui/widgets/snackBarMessage.dart';

import '../widgets/EmptyList_Widget.dart';
import '../widgets/Task_status_Summary_widget.dart';
import '../widgets/Tm_app_Bar.dart';
import '../widgets/task_item_widget.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});


  @override
  State<CompletedTaskListScreen> createState() => _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {

  bool _GetCompletedTaskListInProgrss=false;

  TaskCountByStatusModel? taskCountByStatusModel;
  TaskListByStatusModel _CompletedTaskListModle=TaskListByStatusModel();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _GetTaskStatusByCount();
    _getAllProgressTaskList();
  }
  @override
  // Widget build(BuildContext context) {
  //
  //   return Scaffold(
  //     appBar: TMappBar(),
  //     body: ScreenBackground(
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Visibility(
  //                   visible: _GetnewTaskListInProgrss==false,
  //                   replacement: CenteredCircularProgressIndicator(),
  //                   child: _buildTaskListView(),
  //                 )
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () {
  //         Navigator.pushNamed(context, NewTaskScreen.name);
  //       },
  //       child: Icon(Icons.add),
  //     ),
  //   );
  // }
  //
  // Widget _buildTaskListView() {
  //   return ListView.builder(
  //       itemCount: _ProgressTaskListModle?.taskList?.length,
  //       shrinkWrap: true,
  //       primary: false,
  //       itemBuilder: (context,index){
  //         return TaskItemWidget(
  //           taskModel: _ProgressTaskListModle!.taskList![index],
  //
  //         );
  //       }
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappBar(),
      body: ScreenBackground(
        child: Visibility(
          visible: _GetCompletedTaskListInProgrss == false,
          replacement: CenteredCircularProgressIndicator(),
          child: RefreshIndicator(  /// TODO: Make it Operational
            onRefresh: () async {
              _getAllProgressTaskList();
            },
            child: Visibility(
              visible: _CompletedTaskListModle.taskList?.isNotEmpty ?? false,
              replacement: const EmptyListWidget(),
              child: ListView.builder(
                itemCount: _CompletedTaskListModle.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskItemWidget(
                    screenTitle: "ProgressTask",
                    taskModel: _CompletedTaskListModle.taskList![index],
                    refreshList: (){
                      _getAllProgressTaskList();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _getAllProgressTaskList() async {
    _GetCompletedTaskListInProgrss = true;
    setState(() {});
    final NetworkResponse response =
    await NetworkCaller.getRequest(Url: Urls.taskListByStatusUrl('Completed'));
    if (response.isSuccess) {
      _CompletedTaskListModle =TaskListByStatusModel.fromJson(response.responseData!);
      _GetCompletedTaskListInProgrss = false;
      setState(() {});
    } else {
      _GetCompletedTaskListInProgrss = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? "Get Progress task list has been failed!");
      }
    }
  }
}


