import 'package:hospital_stay_helper/class/visitNote.dart';

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
    notes =
        List<VisitNote>.from(notesObjects.map((e) => VisitNote.fromJson(e)));
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
