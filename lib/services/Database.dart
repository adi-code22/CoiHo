import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coho/Models/Patient.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

// user
class DatabaseService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Patient>> gePatientDeets() {
    var a = _db
        .collection("Patient")
        .orderBy("bedNo", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((documents) {
              print("\n\n\n\n\n\ndata ${documents.data()["Name"]}");

              return Patient.fromJson(documents.data());
            }).toList());

    return a;
  }

  Future<void> editTrack(String docName, List<Track> track) {
    var a = [];
    track.forEach((element) {
      var temp = {
        "time": element.time,
        "spO2": element.spO2,
        "pressureH": element.pressureH,
        "pressureL": element.pressureL,
        "temp": element.temp,
        "pulse": element.pulse,
        "respirRate": element.respirRate,
      };
      a.add(temp);
      print("\n\n\n\n\n each val  from edit track is ${temp.toString()}");
    });
    print("\n\n\n\n\n each val  from edit track is ${a.toString()}");
    CollectionReference patRef =
        FirebaseFirestore.instance.collection('Patient');

    print("\n\n\n\n\n\all the data here \n ${track.toString()}");
    return patRef.doc(docName).update({"track": a}).then((value) {
      print("\n\n\nupdated yaaa");
    }).catchError(
        (onError) => print("\n\n\n error thrown ${onError.toString()}"));
  }

  Future<void> addNeTrack(List<Track> track, Track newVal, String op) {
    if (track.isEmpty) {
      track = [];
    }
    track.add(newVal);
    print("\n\n\n\n\n\n\n\n\nNew val${newVal.toString()}");
    // var a = json.encode(track.toJson());
    var a = [];
    track.forEach((element) {
      var temp = {
        "time": element.time,
        "spO2": element.spO2,
        "pressureH": element.pressureH,
        "pressureL": element.pressureL,
        "temp": element.temp,
        "pulse": element.pulse,
        "respirRate": element.respirRate,
      };

      a.add(temp);
    });
    print("\n\n\n\n\n\n ${a.toString()}");

    CollectionReference patRef =
        FirebaseFirestore.instance.collection('Patient');

    print("\n\n\n\n\n\all the data here \n ${track.toString()}");
    return patRef.doc(op).update({"track": a}).then((value) {
      print("\n\n\nupdated yaaa");
    }).catchError(
        (onError) => print("\n\n\n error thrown ${onError.toString()}"));
  }

  Future<void> addPatients(
      {String opNumber, String name, String age, String phone, String bedNo}) {
    var track = [{}];
    // track.add({"presure": null});
    Map<String, dynamic> newPatient = {
      "Name": name,
      "age": age,
      "opNo": opNumber,
      "phone": phone ?? "Nil",
      "bedNo": bedNo,
      "critical": "No",
      "track": track
    };
    // String sheetUrl =
    //     'https://script.google.com/macros/s/AKfycbyEzCqm6rZT1WhZAIiuZyyHy1xFbcH5hEqGnCSxU9M/dev?type=newPatient&opNumber=$opNumber&name=$name&age=$age&bedNo=$bedNo&phoneNumber=$phoneNumber';
    // try {
    //   launch(sheetUrl);
    // } catch (e) {

    //   print(e);
    // }
    CollectionReference patRef =
        FirebaseFirestore.instance.collection('Patient');
    return patRef
        .doc(opNumber)
        .set(newPatient)
        .then((value) => {
              print("Pt collection updated"),
            })
        .catchError((onError) =>
            {print("\n\n\n\terror : \n\n\n${onError.toString()}")});
  }
}
