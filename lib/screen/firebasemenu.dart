

import 'package:firebaseproject/screen/ADDEMPLOYE.dart';
import 'package:firebaseproject/screen/ADDPRODUCT.dart';
import 'package:firebaseproject/screen/VIEWEMPLOYE.dart';
import 'package:firebaseproject/screen/VIEWPRODUCT.dart';
import 'package:flutter/material.dart';

class firebasemenu extends StatefulWidget {


  @override
  State<firebasemenu> createState() => _firebasemenuState();
}

class _firebasemenuState extends State<firebasemenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FIREBASE"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ADDPRODUCT()));
                },
                child: Text("ADDPRODUCT"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => VIEWPRODUCT()));
                },
                child: Text("VIEWPRODUCT"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ADDEMPLOYE()));
                },
                child: Text("ADDEMPLOYE"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => VIEWEMPLOYE()));
                },
                child: Text("VIEW EMPLOYE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
