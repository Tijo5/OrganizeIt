
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Timetable extends StatefulWidget {
const Timetable({super.key});

@override
State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TimeTable"),
      ),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Subjects").orderBy("date", descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }
            if(!snapshot.hasData){
              return Text("no Goal");
            }
            List<dynamic> subjects = [];
            snapshot.data!.docs.forEach((element) {
              subjects.add(element);
            });

            return ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final goal = subjects[index];
                final avatar = goal["avatar"];
                final subject = goal["subject"];
                final  Timestamp timestamp = goal["date"];
                final String date= DateFormat.yMd().add_jm().format(timestamp.toDate());
                final chapter = goal["chapter"];

                return Card(
                  child: ListTile(
                    leading: Image.asset("assets/images/$avatar.jpg"),
                    title: Text('$subject $date'),
                    subtitle: Text('$chapter'),
                    trailing: const Icon(Icons.more_vert),
                  ),
                );
              },
            );

          } ,
        )
      ),
    );
  }
}
