import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int ci = 0;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    print("in build");
    return Scaffold(
      // backgroundColor: Colors.white70,
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          Container(
              child: Icon(
            Icons.alarm,
            size: 100,
          )),
          Column(
            children: <Widget>[
              Icon(
                Icons.person,
                size: 100,
              ),
              RaisedButton(
                onPressed: () {
                  print("on press");
                },
                color: Colors.blueGrey,
                child: Text(
                  "Press",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
      appBar: AppBar(
        title: Text("Flutter Day 2020"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add_circle_outline, color: Colors.white),
              onPressed: () {
                print("OnPress 1");
              }),
          IconButton(
              icon: Icon(Icons.access_time, color: Colors.white),
              onPressed: () {
                print("OnPress 2");
              }),
          IconButton(
              icon: Icon(Icons.label_important, color: Colors.white),
              onPressed: () {
                print("OnPress 3");
              })
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.greenAccent,
          child: Center(
              child: FlutterLogo(
            colors: Colors.yellow,
            size: 50,
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("test button");
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.blueAccent,
          child: TabBar(controller: _controller, tabs: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.alarm,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.person,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

/*


BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.alarm), title: Text("ALarm")),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), title: Text("account box")),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), title: Text("account box")),
          ],
          onTap: (int index) {
            setState(() {
              ci = index;
            });
            print("Current index = $ci");
          },
          currentIndex: ci,
        )


Center(
          child: Container(
              child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.yellow,
                    height: 200,
                    width: 200,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Hello,World!"),
                        Text("Hello,World!"),
                        Text("Hello,World!"),
                        Text("Hello,World!"),
                        Text("Hello,World!"),
                        Text("Hello,World!"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
        */
