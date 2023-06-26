import 'package:flutter/material.dart';
import 'package:teach_me/page/booking_page.dart';
import 'package:teach_me/component/custom_card.dart';
import 'package:teach_me/utils/DB_Functions.dart';
import './home_page.dart';

class SelectProfessor extends StatefulWidget {
  SelectProfessor(
      {super.key,
      required this.courseImageUrl,
      required this.timeFrame,
      required this.courseName,
      required this.userName,
      });

  String courseImageUrl;
  String timeFrame;
  String courseName;
  String userName;

  @override
  State<SelectProfessor> createState() => _SelectProfessorState();
}

class _SelectProfessorState extends State<SelectProfessor> {
  List<Widget> teachersForThisSubject = [];
  void teachersCards() async{
    List<Map<String,dynamic>> teacherData = await DbFunctions().get('teachers', 'isAvailable = "Y"');
    for (int i = 0; i < teacherData.length; i++) {
      if (teacherData[i]["subjects"] == widget.courseName &&
          teacherData[i]["isAvailable"]  == "Y" ) {
        teachersForThisSubject.add(
          CustomCard(
            imageUrl: teacherData[i]["image"],
            cardTitle: teacherData[i]["name"],
            onClick: () async{
              await DbFunctions().update("teachers", "isAvailable", 'id = ${teacherData[i]["id"]}', '"N"');
              await DbFunctions().update("subjects", "isAvailable", 'name = "${widget.courseName}"', '"N"');
              await DbFunctions().update("subjects", "isBooked", 'name = "${widget.courseName}"', '"Y"');
              if(context.mounted){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BookingPage(
                      courseImageUrl: widget.courseImageUrl,
                      professorName: teacherData[i]["name"],
                      userName: widget.userName,
                    ),
                  ),
                );
              }
            },
          ),
        );
      }
    }
    setState(() {});
  }
  @override
  void initState() {
    setState(() {
      teachersCards();
    });
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
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
            widget.timeFrame,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                ...teachersForThisSubject
              ],
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
