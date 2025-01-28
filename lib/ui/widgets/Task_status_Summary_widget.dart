
import 'package:flutter/material.dart';

class Task_Status_summary_counter extends StatelessWidget {
  const Task_Status_summary_counter({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final String count;


  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 16),
        child: Column(
          children: [
            Text(count,style: textTheme.titleLarge,),
            Text(title,style: textTheme.titleSmall,),
          ],
        ),
      ),
    );
  }
}
