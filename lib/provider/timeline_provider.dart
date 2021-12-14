import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hospital_stay_helper/class/visit.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';

class VisitTimelineProvider extends ChangeNotifier {
  late Box _box;
  List<Visit> _visits = [];
  List<Visit> get visits => _visits;
  VisitTimelineProvider() {
    _box = Hive.box('visitsTimeline');
    var temp = _box.get('first_visit') ?? false;
    if (temp == false) {
      _visits = [Visit.fromTemplate()];
      updateVisit();
      _box.put('first_visit', true);
    } else {
      String _savedVisits = _box.get('visits') ?? '';
      if (_savedVisits.isNotEmpty) {
        Iterable? tmp = jsonDecode(_savedVisits);
        _visits = List<Visit>.from(tmp!.map((model) => Visit.fromJson(model)));
      }
    }
  }
  void updateVisit() {
    _box.put('visits', jsonEncode(_visits));
  }

  void createVisit() {
    _visits.insert(0, Visit([VisitNote()]));
    notifyListeners();
    updateVisit();
    observer.analytics.logEvent(name: 'create_visit');
  }

  void createNote(Visit visit, String type, String path) {
    if (type == 'note') {
      visit.notes!.insert(0, VisitNote());
      notifyListeners();
    }
    if (type == 'image') {
      visit.notes!.insert(0, VisitNote.fromPicture(path));
      notifyListeners();
    }
    updateVisit();
    observer.analytics
        .logEvent(name: 'create_note', parameters: {'type': type});
  }

  Visit removeVisitAt(int index) {
    Visit temp = _visits.removeAt(index);
    updateVisit();
    observer.analytics.logEvent(name: 'delete_visit');
    return temp;
  }

  VisitNote deleteNote(Visit visit, int noteIndex) {
    VisitNote temp = visit.notes!.removeAt(noteIndex);
    updateVisit();
    observer.analytics
        .logEvent(name: 'delete_note', parameters: {'type': temp.type});
    return temp;
  }

  void updateVisitData(Visit visit, String type, String data) {
    switch (type) {
      case 'date':
        {
          visit.date = data;
        }
        break;
      case 'patientName':
        {
          visit.patientName = data;
        }
        break;
      case 'healthcareProvider':
        {
          visit.healthcareProvider = data;
        }
        break;
    }
    notifyListeners();
    updateVisit();
  }

  void updateNoteData(Visit visit, int noteIndex, String type, String data) {
    switch (type) {
      case 'title':
        {
          visit.notes![noteIndex].title = data;
        }
        break;
      case 'time':
        {
          visit.notes![noteIndex].time = data;
        }
        break;
      case 'date':
        {
          visit.notes![noteIndex].date = data;
        }
        break;
      case 'body':
        {
          visit.notes![noteIndex].body = data;
        }
        break;
    }
    notifyListeners();
    updateVisit();
  }
}
