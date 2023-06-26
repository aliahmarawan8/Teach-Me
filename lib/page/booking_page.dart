import 'package:flutter/material.dart';

import './home_page.dart';

class BookingPage extends StatefulWidget {
  BookingPage(
      {super.key, required this.courseImageUrl, required this.professorName, required this.userName});

  String courseImageUrl;
  String professorName;
  String userName;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage(userName: widget.userName)), (route) => false);
        return true;
      },
      child: Scaffold(
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
              widget.professorName,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Center(child:  Icon(Icons.check_circle_outline_rounded,color: Colors.green,size: 100,)),
            const Text(
              "Lesson Booked!",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
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
      ),
    );
  }
}
