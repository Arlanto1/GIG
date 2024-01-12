import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> userList = ["User 1", "User 2", "User 3"];
  List<String> selectedUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Move User'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildUserList(userList, true),
          _buildUserList(selectedUsers, false),
        ],
      ),
    );
  }

  Widget _buildUserList(List<String> users, bool isSourceList) {
    return Container(
      height: 300,
      width: 150,
      color: Colors.grey[300],
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                if (isSourceList) {
                  selectedUsers.add(user);
                  userList.remove(user);
                } else {
                  userList.add(user);
                  selectedUsers.remove(user);
                }
              });
            },
            child: Card(
              child: ListTile(
                title: Text(user),
              ),
            ),
          );
        },
      ),
    );
  }
}
