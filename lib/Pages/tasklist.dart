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

import 'dart:math';

import 'package:flutter/material.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      // All completed tasks will be shown at the bottom of the list
      for (int i = 0; i < 100; i++)
        const TaskListItem(
          key: Key('TaskListItem'),
        ),
    ]);
  }
}

class TaskListItem extends StatefulWidget {
  const TaskListItem({super.key});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  // List of all possible tasks to complete to gain points
  static final List<String> _taskTitles = <String>[
    'Visit your grandparents',
    'Visit your parents',
    'Go to the shrine in the new year and pray for good luck',
  ];

  var isCompleted = false;

  @override
  Widget build(BuildContext context) {
    int randomIndex = Random().nextInt(_taskTitles.length);
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: isCompleted ? Colors.green : Colors.red,
          width: .25,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        splashColor: Colors.transparent,
        title: Text(_taskTitles[randomIndex]),
        trailing: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: isCompleted
              ? const Icon(Icons.check_box,
                  color: Colors.green, key: Key('completed'))
              : const Icon(Icons.check_box_outline_blank,
                  color: Colors.red, key: Key('incomplete')),
        ),
        onTap: () {
          setState(() {
            isCompleted = !isCompleted;
          });
        },
      ),
    );
  }
}
