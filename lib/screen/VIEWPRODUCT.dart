

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseproject/screen/UPDATEPAGE.dart';
import 'package:flutter/material.dart';

class VIEWPRODUCT extends StatefulWidget {


  @override
  State<VIEWPRODUCT> createState() => _VIEWPRODUCTState();
}

class _VIEWPRODUCTState extends State<VIEWPRODUCT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("VIEWPRODUCT")),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Products").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if(snapshot.hasData)
            {
              if(snapshot.data!.size<=0)
                {
                  return Center(
                    child: Text("No Data"),
                  );
                }
              else
                {
                  return ListView(
                    children: snapshot.data!.docs.map((document){
                      return Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors:[
                                Color(0xff4285F4),
                                Color(0xff8B0000),
                                Color(0xff000080),
                                Color(0xffFF00FF),

                              ],
                              stops: [0.1,0.20,0.50,0.75],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              transform: GradientRotation(double.maxFinite),

                            ),
                          ),
                          child: Column(
                            children: [
                              Image.network(document["fileurl"].toString()),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("NAME :-",style: TextStyle(fontSize: 20,color: Colors.white),),
                                    Text(document["productname"].toString(),style: TextStyle(fontSize: 20,color: Colors.white),),
                                  ],
                                ),

                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("category :-",style: TextStyle(fontSize: 20,color: Colors.white),),
                                    Text(document["category"].toString(),style: TextStyle(fontSize: 20,color: Colors.white),),
                                  ],
                                ),

                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("price :-",style: TextStyle(fontSize: 20,color: Colors.white),),
                                    Text(document["price"].toString(),style: TextStyle(fontSize: 20,color: Colors.white),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("type :-",style: TextStyle(fontSize: 20,color: Colors.white),),
                                    Text(document["type"].toString(),style: TextStyle(fontSize: 20,color: Colors.white),),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.black12,
                                    child: IconButton(
                                      onPressed: ()  async{
                                        var id = document.id.toString();

                                        AlertDialog dialog = new AlertDialog(
                                          title: Text("Warning!"),
                                          content: Text("Are you sure?"),
                                          actions: [
                                            ElevatedButton(onPressed: () async{

                                              await FirebaseFirestore.instance.collection("product")
                                                  .doc(id).delete().then((value){
                                                Navigator.of(context).pop();
                                              });
                                            }, child: Text("Yes")),
                                            ElevatedButton(onPressed: (){
                                              Navigator.of(context).pop();
                                            }, child: Text("No")),
                                          ],
                                        );

                                        showDialog(context: context, builder: (context){
                                          return dialog;
                                        });

                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.black12,
                                    child: IconButton(
                                      onPressed: () {
                                        var id = document.id.toString();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => UPDATEPAGE(
                                              updateid: id,
                                            )));
                                      },
                                      icon: Icon(Icons.update),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
            }
          else
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        },
      ),
    );
  }
}
