import 'package:flutter/material.dart';
import 'package:teach_me/page/completed_course.dart';

import 'course_history.dart';
import 'home_page.dart';

class MyCourses extends StatefulWidget {
  MyCourses({super.key, required this.userName});
  String userName;
  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Teach Me"),
        ),
      ),
      body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.only(top: 190, right: 5),
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CourseHistory(userName: widget.userName,),
                  ),
                );
              },
              child: Card(
                elevation: 8,
                shadowColor: Colors.grey.withOpacity(0.4),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Column(
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.history,
                          size: 70,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Lessons History",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CompletedCourses(userName: widget.userName,),
                  ),
                );
              },
              child: Card(
                elevation: 8,
                shadowColor: Colors.grey.withOpacity(0.4),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Column(
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.check_circle,
                          size: 70,
                          color: Colors.green,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Completed Lessons",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
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
                            HomePage(userName: widget.userName),),
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
