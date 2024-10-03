import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user_api/modal/modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModal> userList = [];
  Future<List<UserModal>> getUserApi() async {
    var url = "https://jsonplaceholder.typicode.com/users";
    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        userList.add(UserModal.fromJson(i));
      }
      return userList;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          "User Details",
          style: _myStyle(Colors.white, FontWeight.bold, 28),
        ),
      ),
      body: Container(
        child: FutureBuilder(
            future: getUserApi(),
            builder: (context, AsyncSnapshot<List<UserModal>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            blurRadius: 100,
                            blurStyle: BlurStyle.normal,
                            color: Colors.white60,
                            offset: Offset(2, 2),
                            spreadRadius: .4,
                          )
                        ]),
                        child: Card(
                          color: Color(0xFF1FC5D6),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Text(
                                    userList[index].id.toString(),
                                    style: _myStyle(
                                        Colors.white, FontWeight.normal, 22),
                                  ),
                                ),
                                Text(
                                  userList[index].name.toString(),
                                  style: _myStyle(
                                      Colors.white, FontWeight.normal, 22),
                                ),
                                Text(
                                  userList[index].username.toString(),
                                  style: _myStyle(
                                      Colors.white, FontWeight.normal, 22),
                                ),
                                Text(
                                  userList[index].email.toString(),
                                  style: _myStyle(
                                      Colors.white, FontWeight.normal, 22),
                                ),
                                Text(
                                  userList[index].phone.toString(),
                                  style: _myStyle(
                                      Colors.white, FontWeight.normal, 22),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}

_myStyle(Color clr, FontWeight fw, double? size) {
  return TextStyle(
    color: clr,
    fontWeight: fw,
    fontSize: size,
  );
}
