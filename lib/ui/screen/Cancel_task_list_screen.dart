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

class CancelTaskListScreen extends StatefulWidget {
  const CancelTaskListScreen({super.key});


  @override
  State<CancelTaskListScreen> createState() => _CancelTaskListScreenState();
}

class _CancelTaskListScreenState extends State<CancelTaskListScreen> {

  bool _GetCancelledTaskListInProgrss=false;

  TaskCountByStatusModel? taskCountByStatusModel;
  TaskListByStatusModel _CancelledTaskListModle=TaskListByStatusModel();


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
          visible: _GetCancelledTaskListInProgrss == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(  /// TODO: Make it Operational
            onRefresh: () async {
              _getAllProgressTaskList();
            },
            child: Visibility(
              visible: _CancelledTaskListModle.taskList?.isNotEmpty ?? false,
              replacement: const EmptyListWidget(),
              child: ListView.builder(
                itemCount: _CancelledTaskListModle.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskItemWidget(
                    screenTitle: "ProgressTask",
                    taskModel: _CancelledTaskListModle.taskList![index],
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
    _GetCancelledTaskListInProgrss = true;
    setState(() {});
    final NetworkResponse response =
    await NetworkCaller.getRequest(Url: Urls.taskListByStatusUrl('Cancelled'));
    if (response.isSuccess) {
      _CancelledTaskListModle =TaskListByStatusModel.fromJson(response.responseData!);
      _GetCancelledTaskListInProgrss = false;
      setState(() {});
    } else {
      _GetCancelledTaskListInProgrss = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? "Get Progress task list has been failed!");
      }
    }
  }
}


