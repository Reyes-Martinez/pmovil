import 'package:flutter/material.dart';
import 'package:practica2/provider/Task_provider.dart';
import 'package:practica2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ListTaskScreen extends StatelessWidget {
  const ListTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('List Task'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/task");
                },
                icon: const Icon(Icons.add_task_outlined))
          ],
        ),
        body: const TaskTiles());
  }
}
