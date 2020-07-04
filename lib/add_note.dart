import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterday/services/auth.dart';
import 'package:flutterday/task.dart';
import 'package:intl/intl.dart';

class AddNote extends StatefulWidget {
  User currentUser;

  AddNote(this.currentUser);
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController _controller = TextEditingController();
  DateTime _taskDate;
  Task _newTask;

  @override
  void initState() {
    _taskDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context, null),
          )
        ],
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("New task", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _controller,
                  minLines: 4,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "what are you planning?",
                  ),
                ),
                SizedBox(height: 15.0),
                FlatButton(
                  onPressed: _pickDate,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.notifications_none,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 10.0),
                      Text(DateFormat('MMM d hh:mm').format(_taskDate),
                          style: Theme.of(context).textTheme.headline4)
                    ],
                  ),
                ),
              ],
            ),
          ),
          MaterialButton(
            height: 50.0,
            minWidth: double.infinity,
            onPressed: () {
              if (_controller.text.isEmpty) return;
//              _newTask = Task(
//                title: _controller.text,
//                date: _taskDate
//              );
//              Navigator.pop(context, _newTask);
              Firestore.instance
                  .collection("users")
                  .document(widget.currentUser.uid)
                  .collection("notes")
                  .add({
                "title": _controller.text,
                "date": _taskDate,
                "status": false,
              });
              Navigator.of(context).pop();
            },
            color: Theme.of(context).primaryColor,
            child: Text(
              "Create",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(
          DateTime.now().year + 5,
        ));
    if (date == null) return;
    TimeOfDay time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      _taskDate = DateTime(
          date.year,
          date.month,
          date.day,
          time == null ? _taskDate.hour : time.hour,
          time == null ? _taskDate.minute : time.minute);
    });
  }
}
