class VisitNote {
  String title, time, date, body;

  VisitNote({
    this.title = "",
    this.time = "",
    this.date = "",
    this.body = "",
  });
  VisitNote.fromJson(Map<String, dynamic> object) {
    title = object['title'];
    time = object['time'];
    date = object['date'];
    body = object['body'];
  }

  Map toJson() => {"title": title, "time": time, "date": date, "body": body};
}
