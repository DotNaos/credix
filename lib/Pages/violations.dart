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
import 'package:credix/components/listcomponent.dart';
import 'package:credix/Components/headercomponent.dart';
import 'package:credix/res/TextStyles.dart';

class ViolationListPage extends StatefulWidget {
  const ViolationListPage({super.key});

  @override
  _ViolationListPageState createState() => _ViolationListPageState();
}

class _ViolationListPageState extends State<ViolationListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      for (int i = 0; i < 100; i++)
        ListComponent(
          header: HeaderComponent(
            headers: [
              Text(
                  '${DateTime.now().day}:${DateTime.now().month}:${DateTime.now().year}',
                  style: TextStyles.header()),
              Text('Nummer: ${i + 1}', style: TextStyles.header()),
              Text(
                '${(i % 2 * 20 + 10 * (i % 3) + 10).floor()}',
                style: TextStyles.header(color: Colors.red),
              ),
            ],
          ),
          details: Text(
            'Das von Ihnen geleitete chinesische Unternehmen wird beschuldigt, gegen das Arbeitsrecht verstoßen zu haben. Es wird behauptet, dass das Unternehmen eine Reihe von Mitarbeitern ohne ordnungsgemäße Arbeitsverträge beschäftigt hat und diese Mitarbeiter möglicherweise nicht angemessen entlohnt hat. Es besteht auch der Verdacht, dass das Unternehmen seine Mitarbeiter gezwungen hat, unbezahlte Überstunden zu leisten und ihre Arbeit unter gefährlichen Bedingungen auszuführen. Darüber hinaus wird das Unternehmen beschuldigt, in einigen Fällen Kinderarbeit betrieben zu haben.',
            style: TextStyles.details(),
            textAlign: TextAlign.start,
          ),
        ),
    ]);
  }
}
