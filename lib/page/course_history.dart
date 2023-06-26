import 'package:flutter/material.dart';
import 'package:teach_me/page/manage_booked.dart';
import 'package:teach_me/page/select_day.dart';
import '../component/custom_card.dart';
import '../utils/DB_Functions.dart';
import 'home_page.dart';
import 'my_courses.dart';

class CourseHistory extends StatefulWidget {
  CourseHistory({super.key, required this.userName});

  String userName;

  @override
  State<CourseHistory> createState() => _CourseHistoryState();
}

class _CourseHistoryState extends State<CourseHistory> {
  List<Widget> courseCards = [];
  Future<void> getBookedCourseCards() async {
    List<Map<String, dynamic>> data =
        await DbFunctions().get('subjects', 'isBooked = "Y"');
    if(data.isNotEmpty){
      for (int i = 0; i < data.length; i++) {
        courseCards.add(
          CustomCard(
            imageUrl: data[i]["image"],
            cardTitle: data[i]["name"],
            onClick: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ManageBooked(userName: widget.userName, courseId: '${data[i]["id"]}', courseName: '${data[i]["name"]}', ),
                ),
              )
            },
          ),
        );
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    getBookedCourseCards();
    super.initState();
  }

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
        children: [...courseCards],
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
