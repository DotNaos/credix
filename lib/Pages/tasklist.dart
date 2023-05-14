// ignore_for_file: slash_for_doc_comments

/**
 * On this page the user can see what tasks he/she has to do
 * the tasks will provide the user with points
 * the user can see the task details by clicking on the task
 * if the user has completed the task, he/she can click on the check button
 * when the user clicks on the check button, the task will be marked as completed
 * and the user will gain points
 * if a task is not completed in a certain time, the task will be marked as failed
 * and the user will lose points
 */

import 'package:flutter/material.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Task List'),
      ],
    );
  }
}
