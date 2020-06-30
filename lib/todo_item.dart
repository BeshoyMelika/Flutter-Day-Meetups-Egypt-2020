import 'package:flutter/material.dart';
import 'package:flutterday/task.dart';
import 'package:intl/intl.dart';


class TodoItem extends StatelessWidget {
  final Task task;
  final int index;
  Function onChecked;

  TodoItem({this.index, this.task, this.onChecked});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: false,
      isThreeLine: true,
      trailing: Checkbox(
        onChanged: (_) => onChecked(index),
        value: task.status,
        activeColor: Theme.of(context).primaryColor,
      ),
      title: Text(task.title, style: Theme.of(context).textTheme.headline2,),
      subtitle: Text(DateFormat('MMM d hh:mm').format(task.date), style: Theme.of(context).textTheme.subtitle2),
    );
  }
}
