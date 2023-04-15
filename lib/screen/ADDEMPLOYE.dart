


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ADDEMPLOYE extends StatefulWidget {


  @override
  State<ADDEMPLOYE> createState() => _ADDEMPLOYEState();
}

class _ADDEMPLOYEState extends State<ADDEMPLOYE> {

  TextEditingController employeename = TextEditingController();
  TextEditingController _slary =TextEditingController();


  var selected="java";
  var _gender="male";

  var em= "";
  var sl="";
  var gr="";
  var dp="";

  bool ch1=true;


  _handalRadio(val) {
    setState(() {
      _gender = val!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Addemployee"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0,),
                Text("NAME",style: TextStyle(fontSize: 20),),
                TextField(
                  controller: employeename,
                  maxLines: 1,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Colors.black),

                    ),
                    focusedBorder:   OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Colors.black),

                    ),
                  ),

                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10.0,),
                Text("salary",style: TextStyle(fontSize: 20),),
                TextField(
                  controller: _slary,
                  maxLines: 1,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Colors.black),

                    ),
                    focusedBorder:   OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Colors.black),

                    ),
                  ),

                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("job type"),
                    SizedBox(
                      width: 20,
                    ),
                    DropdownButton(

                      value: selected,
                      onChanged: (val){
                        setState(() {
                          selected=val!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text("flutter"),
                          value: "flutter",
                        ),
                        DropdownMenuItem(
                          child: Text("web"),
                          value: "web",
                        ),
                        DropdownMenuItem(
                          child: Text("php"),
                          value: "php",
                        ),
                        DropdownMenuItem(
                            child: Text("java"),
                            value: "java"
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: "male",
                      groupValue: _gender,
                      onChanged: _handalRadio,

                    ),
                    Text("male"),
                    Radio(
                      value: "female",
                      groupValue: _gender,
                      onChanged: _handalRadio,

                    ),
                    Text("female"),
                  ],
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async{
                      var ename = employeename.text.toString();
                      var eslary= _slary.text.toString();
                      var egender = _gender.toString();
                      var edepartment = selected.toString();


                      await FirebaseFirestore.instance.collection("Employee").add({
                        "employename":ename,
                        "slary":eslary,
                        "gender":egender,
                        "department":edepartment,
                      }).then((value){
                        print("Data Added");
                        employeename.text="";
                        _slary.text="";
                        _gender="";
                        selected="";

                      });

                    },
                    child: Text("ADD"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
        )
    );
  }
}
