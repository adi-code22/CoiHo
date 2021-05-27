import 'package:coho/Models/Patient.dart';
import 'package:coho/Models/Selected.dart';
import 'package:coho/Screens/Nurse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewRecord extends StatefulWidget {
  @override
  _ViewRecordState createState() => _ViewRecordState();
}

class _ViewRecordState extends State<ViewRecord> {
  // Delete this

  @override
  Widget build(BuildContext context) {
    Color geColor(String tp, var vall) {
      print("\n\n\n\n\n\n\n\n\n\n\n\n value ${vall.toString()} ");
      if (vall.toString() != "null") {
        int val = int.parse(vall);
        print("\n\n\n\n\n\n\n something here $tp\t\t$val");
        if ((tp == "BpH" && (val > 180 || val < 70)) ||
            (tp == "BpL" && (val > 110 || val < 40)) ||
            (tp == "spo2" && val < 90) ||
            (tp == "rr" && val > 30) ||
            (tp == "pu" && (val > 120 || val < 40))) {
          print("color2");
          return Colors.redAccent;
        } else if ((tp == "BpH" && (val > 140 && val < 180)) ||
            (tp == "BpL") && (val > 90 && val < 110) ||
            (tp == "spo2" && (val >= 91 && val < 95)) ||
            (tp == "pu" &&
                ((val >= 40 && val <= 599) || (val >= 101 && val < 120))) ||
            (tp == "rr" && (val >= 24 && val <= 29))) {
          print("color3");
          return Colors.yellow;
        } else if ((tp == "BpH") ||
            (tp == "BpL") ||
            (tp == "spo2") ||
            (tp == "rr") ||
            (tp == "pu")) {}
      }
      return Colors.white;
    }

    dynamic TxtTheme = Theme.of(context).textTheme.bodyText1;
    Selected selected = Provider.of<Selected>(context);
    print("\n\n\n\n\n\n\n on page ${selected.patient.track[0].pressureH}");
    // Patient electedPatient = selected.getSelected;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Records'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name", style: TxtTheme),
                          Text("Age", style: TxtTheme),
                          Text("OP Number", style: TxtTheme),
                          Text("Phone", style: TxtTheme),
                          Text("Bed Number", style: TxtTheme),
                          Text("Current Status",
                              style: TxtTheme), // if possible else delete
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(":", style: TxtTheme),
                          Text(":", style: TxtTheme),
                          Text(":", style: TxtTheme),
                          Text(":", style: TxtTheme),
                          Text(":", style: TxtTheme),
                          Text(":", style: TxtTheme),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(selected.patient.name, style: TxtTheme),
                          Text(selected.patient.age, style: TxtTheme),
                          Text(selected.patient.opNo, style: TxtTheme),
                          Text(selected.patient.phone ?? "Nil",
                              style: TxtTheme),
                          Text(selected.patient.bedNo, style: TxtTheme),
                          Text(selected.patient.critical,
                              style: TxtTheme), // if possible else delete
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // selected.patient.track
                // selected.patient.track[0].pressure == null
                //     ? Text("empty")
                //     :

                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: MediaQuery.of(context).size.width * 0.1,
                        columns: [
                          DataColumn(label: Text('TIME')),
                          DataColumn(label: Text('temp')),
                          DataColumn(label: Text('PULSE')),
                          DataColumn(label: Text('RpRATE')),
                          DataColumn(label: Text('SPO2')),
                          DataColumn(label: Text('BPH')),
                          DataColumn(label: Text('BPL')),
                        ],
                        rows: selected.patient.track
                            .map((track) => DataRow(cells: [
                                  DataCell(Text(track.time ?? 'N/A')),
                                  DataCell(Text(track.temp ?? 'N/A')),
                                  DataCell(buildEachCell(
                                      track.pulse, "pu", geColor)),
                                  DataCell(buildEachCell(
                                      track.respirRate, "rr", geColor)),
                                  DataCell(buildEachCell(
                                      track.spO2, "spo2", geColor)),
                                  DataCell(buildEachCell(
                                      track.pressureH, "BpH", geColor)),
                                  DataCell(buildEachCell(
                                      track.pressureL, "BpL", geColor)),
                                ]))
                            .toList(),
                      ),
                    ),
                    // child: ListView.builder(
                    //   itemCount: selected.patient.track.length,
                    //   itemBuilder: (context, i) {
                    //     if (selected.patient.track[i].time == "null") {
                    //       print("\n\n\n\n\nti,e null");
                    //       return Container();
                    //     }

                    //     var values = [];
                    //     values.add(selected.patient.track[i].pulse == null
                    //         ? "N/A"
                    //         : selected.patient.track[i].pulse);
                    //     values.add(selected.patient.track[i].temp == null
                    //         ? "N/A"
                    //         : selected.patient.track[i].temp);
                    //     values.add(selected.patient.track[i].spO2 == null
                    //         ? "N/A"
                    //         : selected.patient.track[i].spO2);
                    //     values.add(selected.patient.track[i].time == null
                    //         ? "N/A"
                    //         : selected.patient.track[i].time);
                    //     values.add(selected.patient.track[i].respirRate == null
                    //         ? "N/A"
                    //         : selected.patient.track[i].respirRate);
                    //     values.add(selected.patient.track[i].pressure == null
                    //         ? "N/A"
                    //         : selected.patient.track[i].pressure);
                    //     print(values);
                    //     return new ExpansionTile(
                    //       leading: IconButton(
                    //         icon: Icon(Icons.edit),
                    //         onPressed: () {
                    //           // selected.changeSelect()
                    //           print(
                    //               "\n\nbefor nav ${selected.patient.track[i].spO2} ");
                    //           // selected.changeSelect(pa)
                    //           //TODO: Goto edit (Permission to edit for doc only)
                    //           print("Edit button clicked!");
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => Nurse(
                    //                     edit: "Yes",
                    //                     index: i,
                    //                     pat: selected.patient)),
                    //           );
                    //         },
                    //       ),
                    //       backgroundColor: Colors.white,
                    //       subtitle: Text(
                    //         "4 hours ago",
                    //         style: Theme.of(context).textTheme.subtitle2,
                    //       ),
                    //       //Use builder
                    //       title: new Text(
                    //         "Record " + (i + 1).toString(),
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .headline6
                    //             .copyWith(color: Colors.blue),
                    //       ),
                    //       children: <Widget>[
                    //         Card(
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.only(
                    //                   bottomLeft: Radius.circular(10),
                    //                   bottomRight: Radius.circular(10))),
                    //           child: Padding(
                    //             padding:
                    //                 const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    //             child: Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceAround,
                    //               children: [
                    //                 Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       'SpO2: ' + values[2],
                    //                       style: TxtTheme,
                    //                     ),
                    //                     Text(
                    //                       'Pulse: ' + values[0],
                    //                       style: TxtTheme,
                    //                     ),
                    //                     Text(
                    //                       'Temp: ' + values[1],
                    //                       style: TxtTheme,
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       'Pressure: ' + values[5],
                    //                       style: TxtTheme,
                    //                     ),
                    //                     Text(
                    //                       'Resp. rate: ' + values[4],
                    //                       style: TxtTheme,
                    //                       softWrap: true,
                    //                     ),
                    //                     Text(
                    //                       'Time: ' + values[3],
                    //                       style: TxtTheme,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         )
                    //       ],
                    //     );
                    //   },
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildEachCell(
      String track, String col, Color geColor(String tp, dynamic vall)) {
    print(track);
    return Container(
      child: Text(track ?? 'N/A'),
      color: geColor(col, track),
    );
  }
}
