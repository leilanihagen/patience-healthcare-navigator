import 'package:intl/intl.dart';

class Visit {
  String date, patientName;
  List<VisitNote> notes;

  Visit(List<VisitNote> notes) {
    this.date = DateFormat.yMd().format(DateTime.now());
    this.patientName = "";
    this.notes = notes;
  }
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

  Visit.fromTemplate() {
    this.date = '2/1/2018';
    this.patientName = 'JR';
    this.notes = [
      VisitNote.fromTemplate(
          'Template note',
          'Welcome to your Visits Timeline. Use this fake visit to learn about how to keep detailed records of your medical visits. The medical visit described in this Visit is based on a real event',
          '2:00 PM',
          '2/1/2018',
          'note'),
      VisitNote.fromTemplate(
          'intubated',
          'JR was intubated to prevent respiratory arrest. JR lost consciousness.',
          '3:00 PM',
          '2/1/2018',
          'note'),
      VisitNote.fromTemplate(
        'Arrived at emergency room',
        '',
        '3:30 PM',
        '2/1/2018',
        'note',
      ),
      VisitNote.fromTemplate(
        'Take an ambulance',
        'Called 911 and taken in an ambulance',
        '3:30 PM',
        '2/1/2018',
        'note',
      ),
      // VisitNote.fromTemplate('', 'assets/images/template_visit.png', '3:30 PM',
      //     '2/1/2018', 'image'),
    ];
  }
}

class VisitNote {
  String title, time, date, body, type;

  VisitNote() {
    DateTime now = DateTime.now();
    this.date = DateFormat.yMd().format(now);
    this.time = DateFormat.jm().format(now);
    this.title = "";
    this.body = "";
    this.type = 'note';
  }
  VisitNote.fromTemplate(
      String title, String body, String time, String date, String type) {
    this.date = date;
    this.time = time;
    this.title = title;
    this.body = body;
    this.type = type;
  }
  VisitNote.fromJson(Map<String, dynamic> object) {
    title = object['title'];
    time = object['time'];
    date = object['date'];
    body = object['body'];
    type = object['type'];
  }
  VisitNote.fromPicture(String path) {
    DateTime now = DateTime.now();
    this.date = DateFormat.yMd().format(now);
    this.time = DateFormat.jm().format(now);
    this.title = "";
    this.body = path;
    this.type = 'image';
  }
  Map toJson() =>
      {"title": title, "time": time, "date": date, "body": body, "type": type};
}
