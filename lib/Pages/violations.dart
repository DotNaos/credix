// ignore_for_file: slash_for_doc_comments

/**
 * On this page the user can see the list of violations he/she has made in the past
 * the user can see the violation details by clicking on the violation
 * the user can see the number of points he/she has lost 
 */

/** Element: ViolationList
 * 
 *  | Date | Violation | Points lost    |
 *  |------|-----------|----------------|
 *  | > (Click here to see the details) |
 *  | [Violation details]               |
 * 
 */

import 'package:flutter/material.dart';

class ViolationListPage extends StatefulWidget {
  const ViolationListPage({super.key});

  @override
  _ViolationListPageState createState() => _ViolationListPageState();
}

class _ViolationListPageState extends State<ViolationListPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Violation List'),
      ],
    );
  }
}
