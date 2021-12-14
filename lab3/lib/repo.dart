import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:lab3/main.dart';

class Repo extends StatelessWidget {
  final String name;
  final String description;
  final String nameWithOwner;
  final String stargazerCount;
  final String forkCount;
  final String licenseName;
  final String commits;
  final String branches;

  Repo(
      {Key? key,
      required this.name,
      required this.description,
      required this.nameWithOwner,
      required this.stargazerCount,
      required this.forkCount,
      required this.licenseName,
      required this.commits,
      required this.branches})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExtendedRepo(
                        name: name,
                        description: description,
                        branches: branches,
                        commits: commits,
                        licence: licenseName,
                      )));
        },
        child: Container(
          width: 390,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: EdgeInsets.all(2),
                    ),
                    Padding(
                      child: Text(
                        nameWithOwner,
                        style: TextStyle(fontSize: 16),
                      ),
                      padding: EdgeInsets.all(2),
                    ),
                    Padding(
                      child: Text(description),
                      padding: EdgeInsets.all(2),
                    )
                  ],
                ),
                width: 280,
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Text(stargazerCount + " ⭐"),
                      padding: EdgeInsets.all(3),
                    ),
                    Container(
                      child: Text(forkCount + " 🍴"),
                      padding: EdgeInsets.all(3),
                    )
                  ],
                ),
              )
            ],
          ),
          margin: EdgeInsets.all(8),
        ),
      ),
    );
  }
}

class ExtendedRepo extends StatelessWidget {
  final String name;
  final String description;
  final String licence;
  final String commits;
  final String branches;

  const ExtendedRepo(
      {Key? key,
      required this.name,
      required this.description,
      required this.licence,
      required this.commits,
      required this.branches})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              width: 300,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
              padding: EdgeInsets.only(top: 60, bottom: 40),
            ),
          ),
          Center(
            child: Container(
              child: Row(
                children: [
                  Text(
                    "Licence",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(licence, style: TextStyle(fontSize: 18)),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              padding: EdgeInsets.all(15),
              width: 300,
            ),
          ),
          Center(
            child: Container(
              child: Row(
                children: [
                  Text(
                    "Commits",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(commits, style: TextStyle(fontSize: 18)),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              padding: EdgeInsets.all(15),
              width: 300,
            ),
          ),
          Center(
            child: Container(
              child: Row(
                children: [
                  Text(
                    "Branches",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(branches, style: TextStyle(fontSize: 18)),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              padding: EdgeInsets.all(15),
              width: 300,
            ),
          ),
          Center(
            child: Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                child: Text("Tillbaka"),
              ),
              padding: EdgeInsets.all(30),
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }
}
