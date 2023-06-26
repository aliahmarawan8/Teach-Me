import 'package:flutter/material.dart';
import 'package:teach_me/utils/DB_Functions.dart';
import './home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
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
          const Center(
            child: Text(
              "Benvenuto",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                TextField(
                  controller: userNameFieldController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: "User Name",
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: "Enter username",
                    hintStyle: TextStyle(color: Colors.grey),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Colors.lightBlueAccent),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordFieldController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Colors.lightBlueAccent),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () async {
                    List<
                        Map<String,
                            dynamic>> student = await DbFunctions().get(
                        "students",
                        'email = "${userNameFieldController.text}" and password = "${passwordFieldController.text}"');
                    print(student);
                    if (context.mounted) {
                      if (student.isNotEmpty) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      userName:
                                          '${student[0]["firstName"]} ${student[0]["lastName"]}',
                                    )),
                            (route) => false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Invalid Email or Password"),
                        ));
                      }
                    }
                  },
                  child: const Text("Login"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
