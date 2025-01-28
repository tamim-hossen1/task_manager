import 'package:flutter/material.dart';
import 'package:task_manager/Data/Services/network_caller.dart';
import 'package:task_manager/Data/models/task_model.dart';
import 'package:task_manager/Data/utils/Urls.dart';
import 'package:task_manager/ui/widgets/Circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snackBarMessage.dart';

class TaskItemWidget extends StatefulWidget {
  const TaskItemWidget({
    super.key,
    required this.taskModel, required this.screenTitle, required this.refreshList,
  });

  final TaskModel taskModel;
  final String screenTitle;
  final VoidCallback refreshList;

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  bool _isDeletingINProgress = false;
  bool _updateTaskStatusInProgress=false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 10,
      child: ListTile(
        title: Text(widget.taskModel.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description ?? ''),
            Text(widget.taskModel.createdDate ?? ''),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(widget.taskModel.status ?? ''),
                ),
                Row(
                  children: [
                    Visibility(
                      visible: _isDeletingINProgress==false,
                      replacement: CenteredCircularProgressIndicator(),
                      child: IconButton(
                        onPressed: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text('Are you sure to Delete this item?'),
                                  actions: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }, icon: Text('No'),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _delete(widget.taskModel.sId!);
                                        Navigator.pop(context);
                                      }, icon: Text('Yes'),
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: _isDeletingINProgress ? Colors.grey : Colors.red,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _showupdatStatusDialog(widget.taskModel.sId!);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _delete(String id) async {
    _isDeletingINProgress=true;
    setState(() {});

    NetworkResponse response =
    await NetworkCaller.getRequest(Url: Urls.deletetaskUrl(id));


    if (response.isSuccess) {
      showSnackBarMessage(context, 'Successfully delete th task items.');
    } else {
      showSnackBarMessage(context, 'Failed to delete the task.');
    }
    _isDeletingINProgress=false;
    setState(() {});

  }

  Future<void> _updateTaskStatues(String id,String status) async{
    _updateTaskStatusInProgress=true;
    setState(() {});

    NetworkResponse response=await NetworkCaller.getRequest(Url: Urls.updateTaskStatus(id, status));

    if(response.isSuccess){
      showSnackBarMessage(context, 'Successfully update the task status');
    }
    else{
      showSnackBarMessage(context, 'Failed to update status');
    }
    _updateTaskStatusInProgress=false;
    setState(() {});

  }

  bool _isCurrentStatus(String status) {
    return widget.taskModel.status == status;
  }

  void _showupdatStatusDialog(String id){
    showDialog(
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
            title:const Text('Select Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('New'),
                  trailing:
                  _isCurrentStatus('New')
                  ? const Icon(Icons.check) : null,
                  onTap: (){
                    if(_isCurrentStatus('New')){
                      return;
                    }
                    _updateTaskStatues(id, 'New');
                    Navigator.pop(context);
                  },

                ),

                ListTile(
                  title: Text('Progress'),
                  trailing: _isCurrentStatus('Progresss')
                  ? const Icon(Icons.check) : null,
                  onTap: (){
                    if(_isCurrentStatus('Progress')){
                      return;
                    }
                    _updateTaskStatues(id, 'Progress');
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  title: Text('Completed'),
                  trailing: _isCurrentStatus("Completed")
                  ? Icon(Icons.check) : null,

                  onTap: (){
                    if(_isCurrentStatus('Completed')){
                      return;
                    }
                    _updateTaskStatues(id, 'Completed');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Cancelled'),
                  trailing: _isCurrentStatus('Cancelled')
                  ? const Icon(Icons.check) : null,
                  onTap: (){
                    if(_isCurrentStatus('Cancelled')){
                      return;
                    }
                    _updateTaskStatues(id, 'Cancelled');
                    Navigator.pop(context);
                  },
                )


              ],
            ),
          );
        }
    );
  }
}
