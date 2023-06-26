import 'package:flutter/material.dart';
import '../component/custom_card.dart';
import '../utils/DB_Functions.dart';
import 'home_page.dart';
import 'my_courses.dart';

class CompletedCourses extends StatefulWidget {
  CompletedCourses({super.key, required this.userName});

  String userName;

  @override
  State<CompletedCourses> createState() => _CompletedCoursesState();
}

class _CompletedCoursesState extends State<CompletedCourses> {
  List<Widget> courseCards = [];
  Future<void> getCompletedCourseCards() async {
    List<Map<String, dynamic>> data =
    await DbFunctions().get('subjects', 'isCompleted = "Y"');
    if(data.isNotEmpty){
      for (int i = 0; i < data.length; i++) {
        courseCards.add(
          CustomCard(
            imageUrl: data[i]["image"],
            cardTitle: data[i]["name"],
            onClick: ()=>{},
          ),
        );
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    getCompletedCourseCards();
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

      drawer:Drawer(
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
