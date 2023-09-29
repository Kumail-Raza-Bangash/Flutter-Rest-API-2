import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api_2/model/user.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Rest API 2"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: fetchUsers),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (content, index){
          final user = users[index];
          final email = user.email;

          return ListTile(
            leading: Text(user.name.first),
            trailing: Text(user.nat),
            title: Text(user.phone),
            subtitle: Text(user.email),
          );
        }
        ),
    );
  }

  void fetchUsers() async {

    print("FetchUser Called");

    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    
    final transformed = results.map((e) {

      final name = UserName(
        first: e['name']['first'], 
        title: e['name']['title'], 
        last: e['name']['last']);

        return User(
          cell: e['cell'],
          email: e['email'],
          gender: e['gender'],
          nat: e['nat'],
          phone: e['phone'],
          name: name,
        );
      }).toList();

    setState(() {
      users = transformed;
    });

    print("FetchUser Completed");

  }
}