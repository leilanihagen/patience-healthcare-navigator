class Visit {
  String date, patientName;
  List<VisitNote> notes;

  Visit({
    this.date = "",
    this.patientName = "",
    this.notes,
  });
  Visit.fromJson(Map<String, dynamic> object) {
    date = object['date'];
    patientName = object['patientName'];
    Iterable notesObjects = object['notes'];
    notes = List<VisitNote>.from(notesObjects.map(
        (e) => VisitNote.fromJson(e))); // cannot pass visitnote obj in here
  }

  Map toJson() {
    List<Map> notesJson =
        notes == null ? null : notes.map((e) => e.toJson()).toList();
    return {
      'date': date,
      'patientName': patientName,
      'notes': notesJson,
    };
  }
}

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
