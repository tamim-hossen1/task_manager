import 'package:flutter/material.dart';
import 'package:task_manager/Data/Services/network_caller.dart';
import 'package:task_manager/Data/models/task_count_by_status_model.dart';
import 'package:task_manager/Data/models/task_list_By_status.dart';
import 'package:task_manager/Data/utils/Urls.dart';
import 'package:task_manager/ui/screen/New_task_Screen.dart';
import 'package:task_manager/ui/widgets/Circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/ScreenBackground.dart';
import 'package:task_manager/ui/widgets/snackBarMessage.dart';

import '../widgets/Task_status_Summary_widget.dart';
import '../widgets/Tm_app_Bar.dart';
import '../widgets/task_item_widget.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});


  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {

  bool _taskStatusByCountInProgress=false;
  bool _GetnewTaskListInProgrss=false;

  TaskCountByStatusModel? taskCountByStatusModel;
  TaskListByStatusModel? newTaskListModle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _GetTaskStatusByCount();
    // _GetNewTaskList();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: TMappBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _build_Task_Summary_by_status(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Visibility(
                    visible: _GetnewTaskListInProgrss==false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: _buildTaskListView()),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewTaskScreen.name);
        },
        child: Icon(Icons.add),
      ),
    );
  }

Widget _buildTaskListView() {
    return ListView.builder(
              itemCount: newTaskListModle?.taskList?.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context,index){
                return TaskItemWidget(
                  taskModel: newTaskListModle!.taskList![index],
                  label: 'New',
                  color: Colors.lightBlueAccent,

                );
                }
            );
  }

Widget _build_Task_Summary_by_status() {
    return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Visibility(
              visible: _taskStatusByCountInProgress==false,
              replacement: CenteredCircularProgressIndicator(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    shrinkWrap: true,
                    itemCount: taskCountByStatusModel?.taskList?.length ?? 0,
                      itemBuilder: (context,index){
                      return Task_Status_summary_counter(
                          title: taskCountByStatusModel!.taskList![index].sId ?? '',
                          count: taskCountByStatusModel!.taskList![index].sum.toString(),
                      );

                      }
                  ),
                ),
              ),
            ),
          );
  }


  Future<void> _GetTaskStatusByCount() async{
    _taskStatusByCountInProgress=true;
    setState(() {});
     NetworkResponse response=await NetworkCaller.getRequest(Url:Urls.taskStatusCountBystatusUrl);

     if(response.isSuccess){
       taskCountByStatusModel=TaskCountByStatusModel.fromJson(response.responseData!);
     }
     else{
       showSnackBarMessage(context, response.errorMessage);
     }
     _taskStatusByCountInProgress=false;
     setState(() {});
  }

  // Future<void> _GetNewTaskList() async{
  //   _GetnewTaskListInProgrss=true;
  //   setState(() {});
  //   NetworkResponse response=await NetworkCaller.getRequest(Url:Urls.taskListByStatusUrl('New'));
  //
  //   if(response.isSuccess){
  //     newTaskListModle=TaskListByStatusModel.fromJson(response.responseData!);
  //   }
  //   else{
  //     showSnackBarMessage(context, response.errorMessage);
  //   }
  //   _GetnewTaskListInProgrss=false;
  //   setState(() {});
  // }
}

