import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:skill_test/Model/db_handler.dart';
import 'package:skill_test/Model/todo_Model.dart';
import 'package:skill_test/View/homeMain.dart';

class ToDoPage extends StatefulWidget {
  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  DBhelper? dBhelper;
  late Future<List<TodoModel>> dataList;

  @override
  void initState() {
    super.initState();
    dBhelper = DBhelper();
    loadData();
  }

  loadData() async {
    dataList = dBhelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              child: Text(
                "My To-Do List",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color.fromARGB(255, 80, 57, 219)),
              ),
            ),
            Column(
              children: [
                Container(
                    child: FutureBuilder(
                        future: dataList,
                        builder:
                            (context, AsyncSnapshot<List<TodoModel>> snapshot) {
                          if (!snapshot.hasData || snapshot.data == null) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.data!.length == 0) {
                            return Center(
                              child: Text(
                                "No Tasks Found",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: const Color.fromARGB(101, 0, 0, 0)),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                int todoId = snapshot.data![index].id!.toInt();
                                String todoTitle =
                                    snapshot.data![index].title.toString();
                                String todoDT = snapshot
                                    .data![index].dateandtime
                                    .toString();
                                return Dismissible(
                                  key: ValueKey(todoId),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    color: Color.fromARGB(255, 219, 15, 0),
                                    child: Icon(
                                      Icons.delete_forever,
                                      size: 25,
                                      color: Color.fromARGB(255, 114, 8, 0),
                                    ),
                                  ),
                                  onDismissed: (DismissDirection direction) {
                                    setState(() {
                                      dBhelper!..delete(todoId);
                                      dataList = dBhelper!.getDataList();
                                      snapshot.data!
                                          .remove(snapshot.data![index]);
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(155, 209, 202, 248),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                          )
                                        ]),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Addtask(
                                                      todoId: todoId,
                                                      todoTitle: todoTitle,
                                                      todoDT: todoDT,
                                                      update: true,
                                                    ),
                                                  ));
                                            },
                                            child: Icon(Icons.edit, size: 20),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          title: Padding(
                                            padding: EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              todoTitle,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)),
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              todoDT,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      210, 82, 78, 78)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        })),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Addtask()));
          }),
    );
  }
}

class Addtask extends StatefulWidget {
  int? todoId;
  String? todoTitle;
  String? todoDT;
  bool? update;

  Addtask({
    this.todoId,
    this.todoTitle,
    this.todoDT,
    this.update,
  });

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  DBhelper? dBhelper;
  late Future<List<TodoModel>> dataList;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dBhelper = DBhelper();
    loadData();
  }

  loadData() async {
    dataList = dBhelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.todoTitle);
    String title;
    if (widget.update == true) {
      title = "Update Task";
    } else {
      title = "Add Task";
    }
    return AlertDialog(
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
      ),
      actions: [
        Container(
            child: Form(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    hintText: "Note Title",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter some text";
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
          key: _formKey,
        )),
        Row(
          children: [
            Container(
              // width: 500,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              padding: EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 209, 203, 247)),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      titleController.clear();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeMainPage()));
                    });
                  },
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.poppins(
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  )),
            ),
            Container(
              // width: 500,
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 25),
              padding: EdgeInsets.symmetric(
                horizontal: 18,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 80, 57, 219)),
              child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.update == true) {
                        dBhelper!.update(TodoModel(
                          id: widget.todoId,
                          title: titleController.text,
                          dateandtime: widget.todoDT,
                        ));
                      } else {
                        dBhelper!.insert(TodoModel(
                            title: titleController.text,
                            dateandtime: DateFormat('yMd')
                                .add_jm()
                                .format(DateTime.now())
                                .toString()));
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeMainPage()));

                      titleController.clear();
                      print("task added");
                    }
                  },
                  child: Text(
                    "Submit",
                    style: GoogleFonts.poppins(
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )),
            ),
          ],
        )
      ],
      elevation: 24.0,
    );
  }
}
