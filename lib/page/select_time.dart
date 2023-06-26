import 'package:flutter/material.dart';
import './select_professors.dart';
import '../component/schedule_card.dart';
import 'home_page.dart';

class SelectTime extends StatefulWidget {
  SelectTime({super.key, required this.courseImageUrl, required this.dayName, required this.courseName, required this.userName});

  String courseImageUrl;
  String dayName;
  String courseName;
  String userName;
  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  handleOnClick({required String timeFrame}) {}
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
          SizedBox(
            width: double.maxFinite,
            height: 130,
            child: Image(
              fit: BoxFit.fitWidth,
              image: AssetImage(widget.courseImageUrl),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.dayName,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  ScheduleCard(
                      optionTitle: "14:00 - 15:00",
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SelectProfessor(
                              courseImageUrl: widget.courseImageUrl,
                              timeFrame: "14:00 - 15:00",
                              courseName: widget.courseName,
                              userName: widget.userName,
                            ),
                          ),
                        );
                      }),
                  const SizedBox(height: 10),
                  ScheduleCard(
                      optionTitle: "15:00 - 16:00",
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SelectProfessor(
                              courseImageUrl: widget.courseImageUrl,
                              timeFrame: "15:00 - 16:00",
                              courseName: widget.courseName,
                              userName: widget.userName,
                            ),
                          ),
                        );
                      }),
                  const SizedBox(height: 10),
                  ScheduleCard(
                      optionTitle: "16:00 - 17:00",
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SelectProfessor(
                              courseImageUrl: widget.courseImageUrl,
                              timeFrame: "16:00 - 17:00",
                              courseName: widget.courseName,
                              userName: widget.userName,
                            ),
                          ),
                        );
                      },),
                ],
              ),
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
              child: Text('Teach Me',style: TextStyle(fontSize: 27),),
            ),
            ListTile(
              leading:const Icon(Icons.home),
              title:const Text('Home',style: TextStyle(fontSize: 20),),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomePage(userName: widget.userName)), (route) => false);
              },
            ),
            ListTile(
              leading:const Icon(Icons.book),
              title:const Text('My Lessons',style: TextStyle(fontSize: 20),),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
