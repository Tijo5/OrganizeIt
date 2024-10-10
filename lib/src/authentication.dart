import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/todo_list.dart';

import 'widgets.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 5),
        child: SizedBox(
        width: 150,
        height: 30,
          child: StyledButton(
              onPressed: () {
                !loggedIn ? context.push('/sign-in') : signOut();
              },
              child: !loggedIn ? const Text('Enter',style: TextStyle(color: Colors.green),) : const Text('Logout',style: TextStyle(color: Colors.green),)),
        ),
        ),
        Visibility(
          visible: loggedIn,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 5),
          child: SizedBox(
          width: 150, // Définissez la largeur souhaitée du bouton
          height: 30,
            child: StyledButton(
                onPressed: () {
                  context.push('/profile');
                },
                child: const Text('Profile',
                  style:  TextStyle(color: Colors.green),)),
          ),
          )
        ),
        Visibility(
        visible: loggedIn,
        child: Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 5),
          child: SizedBox(
            width: 150, // Définissez la largeur souhaitée du bouton
            height: 30,
            child: StyledButton(
              onPressed: () {
                Navigator.push(context,
                    PageRouteBuilder(
                    pageBuilder: (_,__,___)=> TodoList()
                )
                );
              },
              child: const Text('Todo List', style: TextStyle(color: Colors.green)),
            ),
          ),
        ),
        )
      ],
    );
  }
}