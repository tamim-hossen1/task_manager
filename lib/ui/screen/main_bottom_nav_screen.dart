import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/Cancel_task_list_screen.dart';
import 'package:task_manager/ui/screen/Completed_task_list_screen.dart';
import 'package:task_manager/ui/screen/Progress_task_list_Screeb.dart';
import 'package:task_manager/ui/screen/new_task_list_Screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});
  static const String name='/main-bottom-nav-screen';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex=0;
  List<Widget> _screen=[
    NewTaskListScreen(),
    ProgressTaskListScreen(),
    CompletedTaskListScreen(),
    CancelTaskListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index){
          _selectedIndex=index;
          setState(() {});

        },
          destinations: [
        NavigationDestination(icon: Icon(Icons.new_label_outlined), label:'New'),
            NavigationDestination(icon: Icon(Icons.refresh), label: 'progress'),
            NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
            NavigationDestination(icon: Icon(Icons.cancel), label: 'cancel'),
      ]),

    );
  }
}
