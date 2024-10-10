import 'package:flutter/material.dart';
import 'package:todo/lists/add_lists.dart';
import 'package:todo/lists/delete_lists.dart';
import 'package:todo/lists/time_table.dart';

import 'home_page.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});



  @override
  State<TodoList> createState() => _TodoListState();
}

  int selectedIndex = -1;
  final List<String> entries = <String>['Timetable', 'Notes', 'Projects', 'Priorities',"Reminder",'Objectifs'];
  final List<int> colorCodes = <int>[600, 600, 600,600,600,600];

class _TodoListState extends State<TodoList> {

  int _currentIndex= 0;

  setCurrentIndex(int index){
    setState(() {
      _currentIndex= index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TO DO LIST"),
      ),
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return MouseRegion(
                  cursor: SystemMouseCursors.click,
              child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });

                switch(entries[index]) {
                  case 'Timetable':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Timetable()));
                    break;
                  case 'Notes':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TodoList()));
                    break;
                  case 'Priorities':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TodoList()));
                    break;
                  case 'Reminder':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TodoList()));
                    break;
                  case 'Projects':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TodoList()));
                    break;
                  case 'Objectifs':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TodoList()));
                    break;
                  default:

                }
              },

             child:Container(
            height: 50,
               color: selectedIndex == index ? Colors.greenAccent : Colors.green[colorCodes[index]],
            child: Center(child: Text(' ${entries[index]}',
            style: const TextStyle(
              color: Colors.white
            ),)),
            )
              )
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            )
       ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index)  {setCurrentIndex(index);

            switch (index) {
              case 0: // Accueil
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage(title: 'title',)));
              break;
              case 1: // Calendrier
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddListPage()));
              break;
              case 2: // Delete
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const DeleteListPage()));

              default:
              }
              },

          type: BottomNavigationBarType.fixed,

          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,

          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home),
            label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.add),
                label: "Ajout"),
            BottomNavigationBarItem(icon: Icon(Icons.delete),
                label: "delete")
          ],

    ),

        );
      }
  }

