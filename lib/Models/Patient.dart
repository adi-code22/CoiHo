// To parse this JSON data, do
//
//     final patient = patientFromJson(jsonString);

import 'dart:convert';

// Patient patientFromJson(String str) => Patient.fromJson(json.decode(str));

// String patientToJson(Patient data) => json.encode(data.toJson());

class Patient {
  Patient(
      {this.name,
      this.age,
      this.bedNo,
      this.opNo,
      this.phone,
      this.track,
      this.critical});

  String name;
  String phone;
  String age;
  String bedNo;
  String opNo;
  String critical;
  List<Track> track;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        name: json["Name"],
        age: json["age"],
        bedNo: json["bedNo"],
        opNo: json["opNo"],
        phone: json["phone"],
        critical: json["critical"],
        track: List<Track>.from(json["track"].map((x) => Track.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "age": age,
        "bedNo": bedNo,
        "phone": phone,
        "opNo": opNo,
        "track": List<dynamic>.from(track.map((x) => x.toJson())),
      };
}

class Track {
  Track({
    this.time,
    this.spO2,
    this.pressureH,
    this.pressureL,
    this.temp,
    this.pulse,
    this.respirRate,
  });

  String time;
  String spO2;
  String pressureH;
  String pressureL;
  String temp;
  String pulse;
  String respirRate;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        time: json["time"].toString(),
        spO2: json["spO2"],
        pressureH: json["pressureH"],
        pressureL: json["pressureL"],
        temp: json["temp"],
        pulse: json["pulse"],
        respirRate: json["respirRate"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "spO2": spO2,
        "pressureH": pressureH,
        "pressureL": pressureL,
        "temp": temp,
        "pulse": pulse,
        "respirRate": respirRate,
      };
}
