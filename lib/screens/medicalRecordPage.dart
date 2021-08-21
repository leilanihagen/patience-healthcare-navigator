import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/class/medicalRecord.dart';
import 'package:hospital_stay_helper/config/styles.dart';

class MedicalRecordPage extends StatefulWidget {
  MedicalRecordPage({Key key}) : super(key: key);

  @override
  _MedicalRecordPage createState() => _MedicalRecordPage();
}

const List<Map> test = [
  {
    'totalNote': 2,
    'title': 'Cancer treatment',
    'startDate': '7/10/2021',
    'lastUpdate': '7/11/2021',
    'completed': false,
    'totalPayment': 2000.0,
    'outOfPocket': 1000.0,
    'deductible': 50.0,
    'notes': [
      {
        'type': 'text_note',
        'body': {
          'date': '7/10/2021',
          'time': '5:08 PM',
          'title': 'Something',
          'body': 'Hallo'
        }
      },
      {
        'type': 'image_note',
        'body': {
          'date': '7/11/2021',
          'time': '5:08 PM',
          'path': 'path',
          'title': 'something'
        }
      }
    ]
  }
];

class _MedicalRecordPage extends State<MedicalRecordPage> {
  List<MedicalRecord> records = [];
  @override
  void initState() {
    super.initState();
    records =
        List<MedicalRecord>.from(test.map((e) => MedicalRecord.fromJson(e)));

    // print(jsonEncode(records));
    // _loadSaved();
  }

  _loadSaved() {}

  Widget getMedicalRecord() {
    return ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 8.0),
            padding: const EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ],
              border: Border.all(width: 1, color: Colors.grey[600]),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title:  ${records[index].title}"),
                Text("Total notes: ${records[index].totalNote}"),
                Text("Estimate Payment:  \$${records[index].totalPayment}"),
                Text("Out of Pocket:  \$${records[index].outOfPocket}"),
                Text("Deductible:  \$${records[index].deductible}"),
                Text(
                    "Status:  ${records[index].completed ? 'Completed' : 'In progress'}"),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.shadowWhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Styles.modestPink,
        foregroundColor: Styles.shadowWhite,
        child: Icon(Icons.add),
        onPressed: () {
          // createVisit();
        },
      ),
      body: Column(
        children: [Expanded(child: getMedicalRecord())],
      ),
    );
  }
}
