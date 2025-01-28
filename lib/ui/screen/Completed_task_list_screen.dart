import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/Tm_app_Bar.dart';

import '../widgets/task_item_widget.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() => _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappBar(),
      body: _buildTaskListView(),
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
        //   label: 'Completed',
        //   color: Colors.greenAccent,
        // );
      }
  );
}
