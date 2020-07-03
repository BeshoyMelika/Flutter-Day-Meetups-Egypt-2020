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

  @override
  void initState() {
    _todoList = [
      Task(
        title: "Call Max",
        date: DateTime.now()
      ),
      Task(
        title: "Pracise Piano",
        date: DateTime.now()
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: _floatingActionButton(),
      backgroundColor: Theme.of(context).primaryColor,
      body: _homeBody(),
    );
  }

  Widget _appBar(){
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

  Widget _floatingActionButton(){
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: _addNote,
      child: Icon(Icons.add),
    );
  }

  Widget _homeBody(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _header(),
        _todoBody(),
      ],
    );
  }

  Widget _header(){
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
              child: Icon(Icons.event_note, color: Theme.of(context).primaryColor,),
            ),
          ),
          Text("All", style: Theme.of(context).textTheme.headline1,),
          Text("${_todoList.length} Tasks", style: TextStyle(fontSize: 22, color: Colors.white.withAlpha(140))),
        ],
      ),
    );
  }

  Widget _todoBody(){
    return Expanded(
        child: Container(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
            ),
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (_, i){
                return TodoItem(
                  task: _todoList[i],
                  index: i,
                  onChecked: _onChecked,
                );
              },
            )
        )
    );
  }


  _onChecked(int index){
    setState(
       () => _todoList[index].status = !_todoList[index].status
    );
  }

  _addNote()async{
    Task _newTodo = await Navigator.push(
      context, MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => AddNote()
    )
    );
    if(_newTodo == null)
      return;
    setState(() {
      _todoList.add(_newTodo);
    });
  }
}
