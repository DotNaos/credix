import 'package:flutter/material.dart';
// import the colors

/// This is the component that will be used in a the lists of the app
/// so it needs to be generic
///
/// The component looks like this:
///  *  |            Header component             |
///  *  |--------|-----------|--------------|-----|
///  *  | > (Click here to see the details)       |
///  *  | [details]                               |
///
/// the user can see details by clicking on the component
///
///
///  there is an optional check button that can be clicked to mark a task as completed
///  a completed task will be marked with a green check mark
///  an uncompleted task will be marked with a red cross mark
///
///  Make the component look pretty

class ListComponent extends StatefulWidget {
  const ListComponent({
    Key? key,
    required this.date,
    required this.pointsCount,
    required this.details,
  }) : super(key: key);

  final String date;
  final int pointsCount;
  final String details;

  @override
  _ListComponentState createState() => _ListComponentState();
}

class _ListComponentState extends State<ListComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailsPage(
              date: widget.date,
              details: widget.details,
              points: widget.pointsCount,
            ),
          ),
        );
      },
      child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 43, 46, 54),
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.473),
                blurRadius: 5,
                spreadRadius: 0.1,
                offset: Offset(0, 0),
                blurStyle: BlurStyle.normal,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.warning,
                    color: Colors.red,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.date,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                '-${widget.pointsCount}',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
    );
  }
}

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage(
      {super.key,
      required this.date,
      required this.details,
      required this.points});

  final String date;
  final String details;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details for $date'),
        backgroundColor: const Color.fromARGB(255, 7, 7, 7),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 43, 46, 54),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.473),
                      blurRadius: 5,
                      spreadRadius: 0.1,
                      offset: Offset(0, 0),
                      blurStyle: BlurStyle.normal,
                    ),
                  ]),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'On ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: date,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: '\nyou were reported',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                details,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 21,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 43, 46, 54),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.473),
                    blurRadius: 5,
                    spreadRadius: 0.1,
                    offset: Offset(0, 0),
                    blurStyle: BlurStyle.normal,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Points',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '-$points',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
