class TodoModel {
  final int? id;
  final String? title;
  final String? dateandtime;

  TodoModel({this.id, this.title, this.dateandtime});

  TodoModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        dateandtime = res['dateandtime'];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "title": title,
      "dateandtime": dateandtime,
    };
  }
}
