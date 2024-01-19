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
  const MyHomePage({Key? key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<String> userList = ["User 1", "User 2", "User 3"];
  List<String> selectedUsers = [];
  int maxSelectedUsers = 1; // Set the maximum number of selected users

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
                  if (selectedUsers.length < maxSelectedUsers) {
                    selectedUsers.add(user);
                    userList.remove(user);
                  } else {
                    // Show a message when the maximum number of users is reached
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Maximum users selected'),
                      ),
                    );
                  }
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
