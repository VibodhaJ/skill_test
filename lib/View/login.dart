import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_test/Model/DB_Auth.dart';

import 'package:skill_test/Model/users.dart';
import 'package:skill_test/View/signup.dart';
import 'package:skill_test/View/welcom_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final username = TextEditingController();
  final password = TextEditingController();

  bool isVisible = false;

  bool isLoginTrue = false;
  final db = DatabaseHelper();

  login() async {
    var response = await db
        .login(Users(userName: username.text, userPassword: password.text));
    if (response == true) {
      //If login is correct, then goto welcome page
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomePage()));
    } else {
      //If not, true the bool value to show error message
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
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
                        label: Text(
                          "Passsword",
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
                          login();
                        }
                      },
                      child: Text(
                        "LOGIN",
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
                      "Don't have an account ?",
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
                                  builder: (context) => signupPage()));
                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ))
                  ],
                ),
                isLoginTrue
                    ? const Text(
                        "Username or passowrd is incorrect",
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
