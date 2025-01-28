import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/ScreenBackground.dart';
import 'package:task_manager/ui/widgets/Tm_app_Bar.dart';

import '../widgets/task_item_widget.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}



class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappBar(),
      body: ScreenBackground(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildTaskListView(),
          ),
      ),

    );
  }
}


Widget _buildTaskListView() {
  return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context,index){
        // return Task_itemWidget(
        //   taskModel: '',
        //   label: 'In Progress',
        //   color: Colors.green,
        // );
      }
  );
}