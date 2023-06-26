import 'package:flutter/material.dart';
import '../component/schedule_card.dart';
import '../utils/DB_Functions.dart';
import 'home_page.dart';
import 'my_courses.dart';

class ManageBooked extends StatefulWidget {
  ManageBooked(
      {super.key,
      required this.userName,
      required this.courseId,
      required this.courseName});

  String userName;
  String courseId;
  String courseName;

  @override
  State<ManageBooked> createState() => _ManageBookedState();
}

class _ManageBookedState extends State<ManageBooked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Teach Me"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 180),
              ScheduleCard(
                optionTitle: "Mark Completed",
                onClick: () async {
                  await DbFunctions().update(
                      "teachers",
                      "isAvailable",
                      'subjects = "${widget.courseName}" and isAvailable = "N"',
                      '"Y"');
                  await DbFunctions().update("subjects", "isAvailable",
                      'id = ${widget.courseId}', '"Y"');
                  await DbFunctions().update(
                      "subjects", "isBooked", 'id = "${widget.courseId}"', '"N"');
                  await DbFunctions().update("subjects", "isCompleted",
                      'id = "${widget.courseId}"', '"Y"');
                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage(userName: widget.userName)),
                        (route) => false);
                  }
                },
              ),
              const SizedBox(height: 10),
              ScheduleCard(
                optionTitle: "Mark Canceled",
                onClick: () async {
                  await DbFunctions().update(
                      "teachers",
                      "isAvailable",
                      'subjects = "${widget.courseName}" and isAvailable = "N"',
                      '"Y"');
                  await DbFunctions().update("subjects", "isAvailable",
                      'id = ${widget.courseId}', '"N"');
                  await DbFunctions().update(
                      "subjects", "isBooked", 'id = "${widget.courseId}"', '"N"');
                  await DbFunctions().update("subjects", "isCompleted",
                      'id = "${widget.courseId}"', '"N"');
                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage(userName: widget.userName)),
                        (route) => false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Teach Me',
                style: TextStyle(fontSize: 27),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage(userName: widget.userName)),
                    (route) => false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(
                'My Lessons',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyCourses(userName: widget.userName),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
