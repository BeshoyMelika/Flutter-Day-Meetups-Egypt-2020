import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterday/add_note.dart';
import 'package:flutterday/services/auth.dart';
import 'package:flutterday/task.dart';

import 'todo_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _numberOfTasks = 2;
  List<Task> _todoList;
  AuthBase authBase = AuthBase();
  User currentUser;

  @override
  void initState() {
    _todoList = [
      Task(title: "Call Max", date: DateTime.now()),
      Task(title: "Pracise Piano", date: DateTime.now())
    ];
    super.initState();

    _initData();
  }

  _initData() async {
    currentUser = await authBase.getCurrentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: _floatingActionButton(),
      backgroundColor: Theme.of(context).primaryColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("users")
            .document("${currentUser.uid}")
            .collection("notes")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CupertinoActivityIndicator();
          }

          if (snapshot.hasError) {
            return Text(snapshot.error);
          }

          if (snapshot.hasData) {
            return _homeBody(snapshot.data);
          }

          return Container();
        },
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          onPressed: () {
            authBase.logout();
            Navigator.of(context).pushReplacementNamed('login');
          },
          icon: Icon(Icons.exit_to_app, color: Colors.white),
        )
      ],
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: _addNote,
      child: Icon(Icons.add),
    );
  }

  Widget _homeBody(QuerySnapshot snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _header(snapshot),
        _todoBody(snapshot),
      ],
    );
  }

  Widget _header(QuerySnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.event_note,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Text(
            "All",
            style: Theme.of(context).textTheme.headline1,
          ),
          Text("${snapshot.documents.length} Tasks",
              style:
                  TextStyle(fontSize: 22, color: Colors.white.withAlpha(140))),
        ],
      ),
    );
  }

  Widget _todoBody(QuerySnapshot snapshot) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            child: ListView.builder(
              itemCount: snapshot.documents.length,
              itemBuilder: (_, i) {
                return TodoItem(
                  task: Task(
                    title: snapshot.documents[i]['title'],
                    date: (snapshot.documents[i]['date'] as Timestamp).toDate(),
                    status: snapshot.documents[i]['status'],
                  ),
                  index: i,
                  onChecked: (bool status) =>
                      _onChecked(snapshot.documents[i].documentID, status),
                );
              },
            )));
  }

  _onChecked(String index, bool status) {
    Firestore.instance
        .collection("users")
        .document(currentUser.uid)
        .collection("notes")
        .document(index)
        .updateData({
      "status": status,
    });
  }

  _addNote() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => AddNote(
                  currentUser,
                )));
//    if (_newTodo == null) return;
//    setState(() {
//      _todoList.add(_newTodo);
//    });
  }
}
