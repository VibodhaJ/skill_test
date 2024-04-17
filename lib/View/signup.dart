import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_test/Model/DB_Auth.dart';

import 'package:skill_test/Model/users.dart';
import 'package:skill_test/View/login.dart';

class signupPage extends StatefulWidget {
  const signupPage({super.key});

  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isVisible = false;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Image.asset(
                    "assets/signup.png",
                    width: 250,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                  padding: EdgeInsets.symmetric(
                    horizontal: 11,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 90, 39, 211).withOpacity(.2)),
                  child: TextFormField(
                    controller: username,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "username is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      border: InputBorder.none,
                      label: Text("Username",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          )),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 11),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 90, 39, 211).withOpacity(.2)),
                  child: TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail),
                      border: InputBorder.none,
                      label: Text("E-mail Address",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          )),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                  padding: EdgeInsets.symmetric(
                    horizontal: 11,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 90, 39, 211).withOpacity(.2)),
                  child: TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password is required";
                      }
                      return null;
                    },
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: InputBorder.none,
                        label: Text("Create Passsword",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            )),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 11),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 90, 39, 211).withOpacity(.2)),
                  child: TextFormField(
                    controller: confirmPassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password is required";
                      } else if (password.text != confirmPassword.text) {
                        return "Passwords don't match";
                      }
                      return null;
                    },
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: InputBorder.none,
                        label: Text(
                          "Conform Passsword",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                  ),
                ),
                Container(
                  width: 500,
                  margin: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                  padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 70, 57, 179)),
                  child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          //Login method will be here

                          final db = DatabaseHelper();
                          db
                              .signup(Users(
                                  userName: username.text,
                                  userPassword: password.text))
                              .whenComplete(() {
                            //After success user creation go to login screen
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          });
                        }
                      },
                      child: Text(
                        "SIGN UP",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          //Navigate to sign up
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
