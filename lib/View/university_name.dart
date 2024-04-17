import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Future<List<dynamic>> _fetchUniversities() async {
    final response = await http.get(Uri.parse(
        'http://universities.hipolabs.com/search?country=United+States'));

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return json.decode(response.body);
    } else {
      // If that call was not successful throw an error.
      throw Exception('Failed to load universities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _fetchUniversities(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> universities = snapshot.data!;
            return ListView.builder(
              itemCount: universities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(universities[index]['name']),
                  subtitle: Text(universities[index]['country']),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          // loading spinner
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
