import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/Tm_app_Bar.dart';

import '../widgets/task_item_widget.dart';

class CancelTaskListScreen extends StatefulWidget {
  const CancelTaskListScreen({super.key});

  @override
  State<CancelTaskListScreen> createState() => _CancelTaskListScreenState();
}

class _CancelTaskListScreenState extends State<CancelTaskListScreen> {
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
        //   label: 'Cancelled',
        //   color: Colors.lightGreen,
        //
        // );
      }
  );
}