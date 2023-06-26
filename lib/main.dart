import 'package:flutter/material.dart';
import './page/login_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Future <void> main() async{

  runApp(const MyApp());
}
Future<Database> initializeDatabase() async {
  String databasespath = await getDatabasesPath();
  String databasePath = path.join(databasespath, 'my_database.db');
  int version = 1;

  return await openDatabase(
    databasePath,
    version: version,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE subjects(id INTEGER PRIMARY KEY, name TEXT, image TEXT, isAvailable TEXT, isCompleted TEXT, isBooked TEXT)');
      await db.execute('CREATE TABLE teachers(id INTEGER PRIMARY KEY ,name TEXT, subjects TEXT, image TEXT, isAvailable TEXT)');
      await db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY ,firstName TEXT, lastName TEXT, email TEXT, password TEXT)');
      await db.transaction((txn) async {
        await txn.rawQuery('REPLACE INTO subjects(name, image, isAvailable, isCompleted, isBooked) '
            'VALUES("Italian","assets/images/courses/italian.jpg","Y", "N", "N"),'
            '("Maths","assets/images/courses/maths.jpg","Y", "N", "N"),'
            '("IT","assets/images/courses/it.jpg","Y", "N", "N"),'
            '("Chemistry","assets/images/courses/chemistry.jpg","Y", "N", "N"),'
            '("English","assets/images/courses/english.jpg","Y", "N", "N"),'
            '("French","assets/images/courses/french.jpg","Y", "N", "N"),'
            '("Physics","assets/images/courses/physics.jpg","Y", "N", "N"),'
            '("Music","assets/images/courses/music.jpg","Y", "N", "N")');
        await txn.rawQuery('REPLACE INTO teachers(name, subjects, image, isAvailable) '
            'VALUES("Prof. Deangelis", "Italian", "assets/images/professors/Prof. Deangelis.jpg","Y"),'
            '("Prof. Bianchi", "Italian", "assets/images/professors/Prof. Bianchi.jpg","Y"),'
            '("Prof. Verdi", "Maths", "assets/images/professors/Prof. Verdi.jpg","Y"),'
            '("Prof. Rossi", "Maths", "assets/images/professors/Prof. Rossi.jpg","Y"),'
            '("Prof. Esposito", "IT", "assets/images/professors/Prof. Esposito.jpg","Y"),'
            '("Prof. Conte", "IT", "assets/images/professors/Prof. Conte.jpg","Y"),'
            '("Prof. Ricci", "Chemistry", "assets/images/professors/Prof. Ricci.jpg","Y"),'
            '("Prof. Gallo", "Chemistry", "assets/images/professors/Prof. Gallo.jpg","Y"),'
            '("Prof. Smith", "English", "assets/images/professors/Prof. Smith.jpg","Y"),'
            '("Prof. Johnson", "English", "assets/images/professors/Prof. Johnson.jpg","Y"),'
            '("Prof. Dupont", "French", "assets/images/professors/Prof. Dupont.jpg","Y"),'
            '("Prof. Lefevre", "French", "assets/images/professors/Prof. Lefevre.jpg","Y"),'
            '("Prof. Bombace", "Physics", "assets/images/professors/Prof. Bombace.jpg","Y"),'
            '("Prof. Melis", "Physics", "assets/images/professors/Prof. Melis.jpg","Y"),'
            '("Prof. Venudo", "Music", "assets/images/professors/Prof. Venudo.jpg","Y")'
        );
        await txn.rawQuery('REPLACE INTO students (firstName, lastName, email, password) '
            'VALUES("Mario","Rossi","mario.rossi@mail.com","12345"),'
            '("Laura","Bianchi","laura.bianchi@mail.com","12345"),'
            '("Luca","Verdi","luca.verdi@mail.com","12345"),'
            '("Sara","Rizzo","sara.rizzo@mail.com","12345"),'
            '("Matteo","Ferrari","matteo.ferrari@mail.com","12345")');
      });
    },
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teach Me',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
