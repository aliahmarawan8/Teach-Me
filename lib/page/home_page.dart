import 'package:flutter/material.dart';
import 'package:teach_me/component/custom_card.dart';
import 'package:teach_me/utils/DB_Functions.dart';
import './my_courses.dart';
import './select_day.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key, required this.userName});

  String userName;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> courseCards = [];
  Future<void> getAvailableCourseCards() async {
    List<Map<String,dynamic>> data = await DbFunctions().get('subjects', 'isAvailable = "Y"');
    for (int i = 0; i < data.length; i++) {
      if (data[i]["isAvailable"] == "Y") {
        courseCards.add(
          CustomCard(
            imageUrl: data[i]["image"],
            cardTitle: data[i]["name"],
            onClick: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SelectDay(
                    courseImageUrl: data[i]["image"],
                    courseName: data[i]["name"],
                    userName: widget.userName,
                  ),
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
    databaseInitializer();
    setState(() {});
    super.initState();
  }
  void databaseInitializer() async{
    await getAvailableCourseCards();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Teach Me"),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Welcome, (${widget.userName})!",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            "choose your lessons:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [...courseCards],
            ),
          )
        ],
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
