import 'package:flutter/material.dart';
import 'package:teach_me/component/schedule_card.dart';
import './select_time.dart';

import 'home_page.dart';

class SelectDay extends StatefulWidget {
  SelectDay(
      {super.key, required this.courseImageUrl, required this.courseName, required this.userName});

  String courseImageUrl;
  String courseName;
  String userName;

  @override
  State<SelectDay> createState() => _SelectDayState();
}

class _SelectDayState extends State<SelectDay> {
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
            widget.courseName,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  ScheduleCard(
                    optionTitle: "Monday",
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SelectTime(
                            courseImageUrl: widget.courseImageUrl,
                            dayName: "Monday",
                            courseName: widget.courseName,
                            userName: widget.userName,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  ScheduleCard(
                      optionTitle: "Tuesday",
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SelectTime(
                              courseImageUrl: widget.courseImageUrl,
                              dayName: "Tuesday",
                              courseName: widget.courseName,
                              userName: widget.userName,
                            ),
                          ),
                        );
                      }),
                  const SizedBox(height: 10),
                  ScheduleCard(
                      optionTitle: "Wednesday",
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SelectTime(
                              courseImageUrl: widget.courseImageUrl,
                              dayName: "Wednesday",
                              courseName: widget.courseName,
                              userName: widget.userName,
                            ),
                          ),
                        );
                      }),
                  const SizedBox(height: 10),
                  ScheduleCard(
                      optionTitle: "Thursday",
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SelectTime(
                              courseImageUrl: widget.courseImageUrl,
                              dayName: "Thursday",
                              courseName: widget.courseName,
                              userName: widget.userName,
                            ),
                          ),
                        );
                      }),
                  const SizedBox(height: 10),
                  ScheduleCard(
                      optionTitle: "Friday",
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SelectTime(
                              courseImageUrl: widget.courseImageUrl,
                              dayName: "Friday",
                              courseName: widget.courseName,
                              userName: widget.userName,
                            ),
                          ),
                        );
                      },)
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
