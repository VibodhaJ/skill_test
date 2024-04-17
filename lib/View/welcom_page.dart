import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:skill_test/View/homeMain.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Would You Like see My Amazing Project ?",
              style: GoogleFonts.poppins(
                  fontSize: 22, color: Color.fromARGB(255, 80, 57, 219)),
            ),
            actions: [
              Container(
                width: 500,
                margin: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 80, 57, 219)),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeMainPage()));
                    },
                    child: Text(
                      "Yeah , Sure",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )),
              )
            ],
            elevation: 24.0,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 55),
                child: Text(
                  "WELCOME TO SKILL TEST",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Color.fromARGB(255, 80, 57, 219)),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 55, top: 10),
                child: Text(
                  "Candidate :",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 80, 57, 219)),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: 56,
                ),
                child: Text(
                  "Vibodha Jayasinghe",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 80, 57, 219)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25, top: 25, bottom: 25),
                child: Image.asset(
                  "assets/welcome.jpeg",
                  width: 300,
                ),
              ),
              Container(
                width: 500,
                margin: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 80, 57, 219)),
                child: TextButton(
                    onPressed: _showDialog,
                    child: Text(
                      "CONTINUE",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
