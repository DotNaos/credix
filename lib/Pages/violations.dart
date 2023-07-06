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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Components/listcomponent.dart';

class ViolationListPage extends StatefulWidget {
  const ViolationListPage({super.key});

  @override
  _ViolationListPageState createState() => _ViolationListPageState();
}

class _ViolationListPageState extends State<ViolationListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('violations')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                for (int i = 0; i < snapshot.data!.docs.length; i++)
                  ListComponent(
                    date: snapshot.data!.docs[i]['date'],
                    pointsCount: snapshot.data!.docs[i]['pointsCost'],
                    details: snapshot.data!.docs[i]['description'].toString(),
                  ),
              ],
            );
          }),
    ]);
  }
}
