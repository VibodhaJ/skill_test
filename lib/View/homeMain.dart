import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_test/View/university_name.dart';
import 'package:skill_test/View/todo.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Vibodha Jayasinghe",
            style: GoogleFonts.poppins(
                fontSize: 19, color: Color.fromARGB(255, 80, 57, 219)),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 80, 57, 219),
                ))
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: "To-Do List",
              ),
              Tab(
                text: "University Names",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ToDoPage(),
            home(),
          ],
        ),
      ),
    );
  }
}
