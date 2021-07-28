import 'package:flutter/cupertino.dart';

class MedicalRecord {
  int totalNote;
  String title, startDate, lastUpdate;
  bool completed;
  double totalPayment, outOfPocket, deductible;
  List<Note> notes;
  MedicalRecord(String startDate) {
    this.totalNote = 0;
    this.completed = false;
    this.totalPayment = this.outOfPocket = this.deductible = 0;
    this.startDate = startDate;
    notes = [];
  }
  MedicalRecord.fromJson(Map<String, dynamic> json) {
    totalNote = json['totalNote'];
    title = json['title'];
    startDate = json['startDate'];
    lastUpdate = json['lastUpdate'];
    completed = json['completed'];
    totalPayment = json['totalPayment'];
    outOfPocket = json['outOfPocket'];
    deductible = json['deductible'];
    Iterable notesObjects = json['notes'];
    notes = List<Note>.from(notesObjects.map((e) {
      if (e['type'] == 'text_note') return TextNote.fromJson(e['body']);
      if (e['type'] == 'image_note') return ImageNote.fromJson(e['body']);
      if (e['type'] == 'procedure_note')
        return ProcedureNote.fromJson(e['body']);
    }));
  }
  Map toJson() {
    List<Map> notesJson =
        notes == null ? null : notes.map((e) => e.toJson()).toList();
    return {
      'totalNote': totalNote,
      'title': title,
      'startDate': startDate,
      'lastUpdate': lastUpdate,
      'completed': completed,
      'totalPayment': totalPayment,
      'outOfPocket': outOfPocket,
      'deductible': deductible,
      'notes': notes
    };
  }
}

abstract class Note {
  String date, time;
  Note({@required this.date, @required this.time});
  Map toJson();
}

class TextNote extends Note {
  String title, body;
  TextNote({
    @required String date,
    @required String time,
    this.title = '',
    this.body = '',
  }) : super(date: date, time: time);
  TextNote.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    title = json['title'];
    body = json['body'];
  }
  Map toJson() {
    return {
      'type': 'text_note',
      'body': {'date': date, 'time': time, 'title': title, 'body': body}
    };
  }
}

class ImageNote extends Note {
  String path, title;
  ImageNote({
    @required String date,
    @required String time,
    @required this.path,
    this.title = '',
  }) : super(date: date, time: time);
  ImageNote.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    title = json['title'];
    path = json['path'];
  }
  Map toJson() {
    return {
      'type': 'image_note',
      'body': {'date': date, 'time': time, 'path': path, 'title': title}
    };
  }
}

class ProcedureNote extends Note {
  String title;
  double priceEstLow, priceEstHigh, actualPrice;
  String comment;
  ProcedureNote({
    @required String date,
    @required String time,
    this.title = '',
    this.priceEstLow = 0,
    this.priceEstHigh = 0,
    this.actualPrice = 0,
    this.comment = '',
  }) : super(date: date, time: time);
  ProcedureNote.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    title = json['title'];
    priceEstLow = json['priceEstLow'];
    priceEstHigh = json['priceEstHigh'];
    actualPrice = json['pricactualPriceeEstLow'];
    comment = json['comment'];
  }
  Map toJson() {
    return {
      'type': 'procedure_note',
      'body': {
        'date': date,
        'time': time,
        'title': title,
        'priceEstLow': priceEstLow,
        'priceEstHigh': priceEstHigh,
        'actualPrice': actualPrice,
        'comment': comment
      }
    };
  }
}
